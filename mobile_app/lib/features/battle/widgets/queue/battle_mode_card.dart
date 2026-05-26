import 'package:flutter/material.dart';

class BattleModeCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradientColors;
  final VoidCallback onTap;
  final bool compact;
  final bool primary;
  final String? badgeText;
  final Color? badgeColor;
  final Widget? footer;
  final bool showArrow;

  const BattleModeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradientColors,
    required this.onTap,
    this.compact = false,
    this.primary = false,
    this.badgeText,
    this.badgeColor,
    this.footer,
    this.showArrow = true,
  });

  @override
  State<BattleModeCard> createState() => _BattleModeCardState();
}

class _BattleModeCardState extends State<BattleModeCard> {
  bool _hoverOrTap = false;

  @override
  Widget build(BuildContext context) {
    final scale = _hoverOrTap ? 1.015 : 1.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoverOrTap = true),
      onExit: (_) => setState(() => _hoverOrTap = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        scale: scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.compact ? 20 : 24),
            gradient: LinearGradient(
              colors: [
                widget.gradientColors[0].withOpacity(0.32),
                widget.gradientColors[1].withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: _hoverOrTap
                  ? widget.gradientColors[0].withOpacity(0.9)
                  : Colors.white12,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.gradientColors[0].withOpacity(
                  _hoverOrTap ? 0.45 : (widget.primary ? 0.28 : 0.18),
                ),
                blurRadius: _hoverOrTap ? 32 : (widget.primary ? 24 : 18),
                spreadRadius: _hoverOrTap ? 2 : 0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(widget.compact ? 20 : 24),
              onTap: widget.onTap,
              onHighlightChanged: (value) =>
                  setState(() => _hoverOrTap = value),
              child: Padding(
                padding: EdgeInsets.all(
                  widget.compact ? 14 : (widget.primary ? 20 : 16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: widget.compact
                              ? 40
                              : (widget.primary ? 56 : 50),
                          height: widget.compact
                              ? 40
                              : (widget.primary ? 56 : 50),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: widget.gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: widget.gradientColors[0].withOpacity(
                                  0.4,
                                ),
                                blurRadius: 14,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            widget.icon,
                            color: Colors.black,
                            size: widget.compact
                                ? 20
                                : (widget.primary ? 32 : 28),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      widget.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: widget.compact
                                            ? 15
                                            : (widget.primary ? 18 : 17),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  if (widget.badgeText != null) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            (widget.badgeColor ??
                                                    const Color(0xFF3F6BFF))
                                                .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(
                                          999,
                                        ),
                                        border: Border.all(
                                          color:
                                              (widget.badgeColor ??
                                                      const Color(0xFF3F6BFF))
                                                  .withOpacity(0.7),
                                        ),
                                      ),
                                      child: Text(
                                        widget.badgeText!,
                                        style: TextStyle(
                                          color:
                                              widget.badgeColor ??
                                              const Color(0xFF55C1FF),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.subtitle,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  height: 1.25,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (widget.showArrow) ...[
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white70,
                            size: 18,
                          ),
                        ],
                      ],
                    ),
                    if (widget.footer != null) ...[
                      const SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.only(
                          left: widget.compact
                              ? 52.0
                              : (widget.primary ? 68.0 : 62.0),
                        ),
                        child: widget.footer!,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
