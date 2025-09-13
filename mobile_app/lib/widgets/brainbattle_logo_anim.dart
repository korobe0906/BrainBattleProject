// lib/widgets/brainbattle_logo_anim.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// BrainBattleLogoAnim
/// ─────────────────────────────────────────────────────────────────
/// Hiển thị một Lottie ở nền + logo PNG xoay.
/// Hỗ trợ 3 chế độ:
///
/// 1) Finite spin (legacy - mặc định nếu không bật chế độ khác)
///    - Xoay `turnsCount` vòng trong `spinTotalDuration`, xong thì gọi `onSpinEnd`.
///
/// 2) Constant-speed infinite spin
///    - `infiniteSpin = true`: xoay lặp vô hạn với tốc độ cố định,
///      1 vòng = `roundDuration`. Có thể hẹn `turnsForCallback` để
///      gọi `onSpinEnd` sau N vòng (logo vẫn xoay tiếp).
///
/// 3) Sync to Lottie (được khuyến nghị khi cần đồng bộ toàn timeline)
///    - `syncToLottie = true`: Lottie play once (không repeat),
///      lấy duration Lottie (raw), sau đó chuẩn hoá:
///        `target = max(raw, minTotalDuration ?? raw)`
///      -> ép tối thiểu thời lượng hiển thị để tránh “chớp”
///    - Logo xoay đúng **1 vòng** trong đúng `target`.
///    - Callback:
///        * `onTimelineReady(target)` – bắn ra ngay khi biết `target`
///        * `onAllDone()` – khi Lottie (và spin) kết thúc
///
/// Lưu ý: Nếu bật `syncToLottie`, 2 chế độ còn lại sẽ bị bỏ qua.
class BrainBattleLogoAnim extends StatefulWidget {
  const BrainBattleLogoAnim({
    super.key,
    required this.logoAsset,         // 'assets/logo.png'
    required this.loopLottieAsset,   // 'assets/animations/logo_animation.json'

    // ── Finite spin (legacy)
    this.turnsCount = 1.0,
    this.spinTotalDuration = const Duration(seconds: 3),

    // ── Constant-speed infinite spin
    this.infiniteSpin = false,
    this.roundDuration = const Duration(seconds: 4),
    this.turnsForCallback,
    this.spinCurve = Curves.linear,

    // ── Sync to Lottie (play once & 1 vòng spin)
    this.syncToLottie = false,
    this.minTotalDuration,                 // ép tối thiểu thời lượng hiển thị
    this.onTimelineReady,                  // báo duration đã chuẩn hoá
    this.onAllDone,                        // kết thúc Lottie (và spin)

    // ── Layout
    this.widthFactor = 0.66,               // bề rộng khung ~ % chiều ngang màn hình
    this.logoFactor = 0.33,                // bề rộng logo     ~ % chiều ngang màn hình

    // ── Legacy callback (finite/infinite)
    this.onSpinEnd,
  });

  // Assets
  final String logoAsset;
  final String loopLottieAsset;

  // Finite spin
  final double turnsCount;
  final Duration spinTotalDuration;

  // Infinite spin (constant-speed)
  final bool infiniteSpin;
  final Duration roundDuration;
  final double? turnsForCallback;

  // Curve chung cho spin
  final Curve spinCurve;

  // Sync to Lottie (ưu tiên cao nhất)
  final bool syncToLottie;
  final Duration? minTotalDuration;
  final void Function(Duration)? onTimelineReady;
  final VoidCallback? onAllDone;

  // Layout
  final double widthFactor;
  final double logoFactor;

  // Legacy callback
  final VoidCallback? onSpinEnd;

  @override
  State<BrainBattleLogoAnim> createState() => _BrainBattleLogoAnimState();
}

class _BrainBattleLogoAnimState extends State<BrainBattleLogoAnim>
    with TickerProviderStateMixin {
  late final AnimationController _spinCtrl;
  late Animation<double> _turns;
  late final AnimationController _lottieCtrl;
  Timer? _callbackTimer; // dùng cho infiniteSpin + turnsForCallback

  @override
  void initState() {
    super.initState();

    // Controller cho Lottie (khởi tạo trước để có thể set duration khi onLoaded)
    _lottieCtrl = AnimationController(vsync: this);

    // Controller cho spin (duration tuỳ mode, sẽ set ở từng nhánh)
    _spinCtrl = AnimationController(vsync: this);

    if (widget.syncToLottie) {
      // ── MODE 3: SYNC TO LOTTIE ───────────────────────────────────
      _turns = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _spinCtrl, curve: widget.spinCurve),
      );

      // Khi Lottie kết thúc (và vì spin cũng kết thúc cùng lúc) -> báo all done
      _lottieCtrl.addStatusListener((st) {
        if (st == AnimationStatus.completed) {
          widget.onAllDone?.call();
        }
      });
    } else if (widget.infiniteSpin) {
      // ── MODE 2: INFINITE CONSTANT-SPEED ──────────────────────────
      _spinCtrl.duration = widget.roundDuration;
      _turns = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _spinCtrl, curve: widget.spinCurve),
      );
      _spinCtrl.repeat();

      // Hẹn giờ callback sau N vòng (nếu cần), nhưng logo vẫn xoay tiếp
      if (widget.onSpinEnd != null && (widget.turnsForCallback ?? 0) > 0) {
        final micros =
            (widget.roundDuration.inMicroseconds * (widget.turnsForCallback ?? 0))
                .round();
        _callbackTimer = Timer(Duration(microseconds: micros), () {
          if (mounted) widget.onSpinEnd?.call();
        });
      }
    } else {
      // ── MODE 1: FINITE (LEGACY) ──────────────────────────────────
      _spinCtrl.duration = widget.spinTotalDuration;
      _turns = Tween<double>(begin: 0, end: widget.turnsCount).animate(
        CurvedAnimation(parent: _spinCtrl, curve: widget.spinCurve),
      );
      _spinCtrl.addStatusListener((st) {
        if (st == AnimationStatus.completed) widget.onSpinEnd?.call();
      });
      _spinCtrl.forward();
    }
  }

  @override
  void dispose() {
    _callbackTimer?.cancel();
    _spinCtrl.dispose();
    _lottieCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final double boxSize = (screenW * widget.widthFactor).clamp(180.0, 320.0) as double;
    final double logoSize = (screenW * widget.logoFactor).clamp(100.0, 180.0) as double;

    return SizedBox(
      width: boxSize,
      height: boxSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Lottie nền ────────────────────────────────────────────
          Lottie.asset(
            widget.loopLottieAsset,
            controller: _lottieCtrl,
            fit: BoxFit.contain,
            onLoaded: (comp) {
              if (widget.syncToLottie) {
                // 1) Lấy duration thô của Lottie
                final raw = comp.duration;

                // 2) Chuẩn hoá với minTotalDuration để tránh "chớp"
                final min = widget.minTotalDuration;
                final Duration target =
                    (min != null && raw < min) ? min : raw;

                // 3) Chạy Lottie ONCE đúng 'target'
                _lottieCtrl
                  ..duration = target
                  ..reset()
                  ..forward();

                // 4) Cho spin chạy 1 vòng đúng 'target'
                _spinCtrl
                  ..duration = target
                  ..reset()
                  ..forward();

                // 5) Báo ra ngoài để đồng bộ các hiệu ứng khác (vd: chữ rơi)
                widget.onTimelineReady?.call(target);
              } else {
                // Không sync: Lottie loop vô hạn (để làm nền)
                _lottieCtrl
                  ..duration = comp.duration
                  ..repeat();
              }
            },
          ),

          // ── Logo xoay ─────────────────────────────────────────────
          RotationTransition(
            turns: _turns,
            child: Image.asset(
              widget.logoAsset,
              width: logoSize,
              height: logoSize,
            ),
          ),
        ],
      ),
    );
  }
}
