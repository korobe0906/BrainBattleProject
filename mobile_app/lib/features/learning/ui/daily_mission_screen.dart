import 'package:flutter/material.dart';
import '../data/daily_service.dart';

class DailyMissionScreen extends StatefulWidget {
  const DailyMissionScreen({super.key});

  @override
  State<DailyMissionScreen> createState() => _DailyMissionScreenState();
}

class _DailyMissionScreenState extends State<DailyMissionScreen> {
  DailyMission? _mission;
  final _checked = <int, bool>{};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final m = await DailyService.instance.fetchToday();
    setState(() => _mission = m);
  }

  String _countdown(DateTime resetAt) {
    final now = DateTime.now();
    final d = resetAt.difference(now);
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;
    return "${h.toString().padLeft(2,'0')}:${m.toString().padLeft(2,'0')}:${s.toString().padLeft(2,'0')}";
  }

  @override
  Widget build(BuildContext context) {
    final m = _mission;
    if (m == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final doneCount = _checked.values.where((v) => v == true).length;
    final allDone = doneCount == m.tasks.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Mission"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Chip(
                label: Text("🔥 Streak: ${m.streak}",
                    style: const TextStyle(color: Colors.white)),
                backgroundColor: Colors.orangeAccent.withOpacity(0.3),
                side: BorderSide(color: Colors.orangeAccent.withOpacity(0.5)),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              const Icon(Icons.timer, color: Colors.white70),
              const SizedBox(width: 8),
              Text("Reset sau: ${_countdown(m.resetAt)}",
                  style: const TextStyle(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(m.tasks.length, (i) {
            final checked = _checked[i] ?? false;
            return Card(
              color: const Color(0xFF141C34),
              child: CheckboxListTile(
                value: checked,
                onChanged: m.completedToday
                    ? null
                    : (v) => setState(() => _checked[i] = v ?? false),
                title: Text(m.tasks[i],
                    style: const TextStyle(color: Colors.white)),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.lightBlueAccent,
                secondary: checked
                    ? const Icon(Icons.check_circle, color: Colors.lightGreen)
                    : const Icon(Icons.radio_button_unchecked,
                        color: Colors.white54),
              ),
            );
          }),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.rocket_launch),
              label: Text(m.completedToday
                  ? "Đã hoàn thành hôm nay"
                  : allDone
                      ? "Hoàn tất Daily Mission"
                      : "Đánh dấu hoàn tất"),
              onPressed: m.completedToday || !allDone
                  ? null
                  : () async {
                      await DailyService.instance.markCompletedToday();
                      await _load();
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("🔥 Hoàn tất Daily Mission!")),
                      );
                    },
            ),
          )
        ]),
      ),
      backgroundColor: const Color(0xFF0B1020),
    );
  }
}
