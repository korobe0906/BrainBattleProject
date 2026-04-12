import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../battle_routes.dart';
import '../widgets/queue/battle_mode_card.dart';
import '../widgets/queue/battle_role_chip.dart';
import '../widgets/queue/battle_room_code_banner.dart';
import '../widgets/queue/battle_team_panel.dart';
import '../widgets/queue/leaderboard_section.dart';
import '../widgets/queue/player_profile_section.dart';
import '../widgets/queue/progress_section.dart';
import '../widgets/queue/utility_actions_section.dart';
import '../widgets/queue/mode_meta_row.dart';

class BattleQueuePage extends StatefulWidget {
  const BattleQueuePage({super.key});
  static const routeName = BattleRoutes.mode;

  @override
  State<BattleQueuePage> createState() => _BattleQueuePageState();
}

class _BattleQueuePageState extends State<BattleQueuePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  String _selectedFilter = 'Grammar';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0.02, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _open1v1Entry() async {
    await Navigator.of(context).pushNamed(BattleRoutes.v1Entry);
  }

  Future<void> _open3v3Entry() async {
    await Navigator.of(context).pushNamed(BattleRoutes.v3Entry);
  }

  void _onUtilityTap(String action) {
    if (action == 'Join Room') {
      _open1v1Entry();
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$action is coming soon'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: BBColors.darkBg,
      child: SafeArea(
        bottom: false,
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PlayerProfileSection(),
                  const SizedBox(height: 24),
                  BattleModeCard(
                    title: 'Quick 1v1 Battle',
                    subtitle: 'Instant matchmaking with a random opponent.',
                    icon: Icons.flash_on_rounded,
                    gradientColors: const [
                      Color(0xFFF6A0CA),
                      Color(0xFFE86FFF),
                    ],
                    primary: true,
                    badgeText: 'LIVE',
                    badgeColor: const Color(0xFF5BAFFF),
                    footer: const ModeMetaRow(),
                    onTap: _open1v1Entry,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: BattleModeCard(
                          compact: true,
                          title: 'Create 1v1',
                          subtitle: 'Choose Listening / Reading / Writing.',
                          icon: Icons.add_rounded,
                          gradientColors: const [
                            Color(0xFF8463FF),
                            Color(0xFFB590FF),
                          ],
                          onTap: _open1v1Entry,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: BattleModeCard(
                          compact: true,
                          title: 'Join room',
                          subtitle: 'Enter a room code from your friend.',
                          icon: Icons.meeting_room_outlined,
                          gradientColors: const [
                            Color(0xFF57E1F3),
                            Color(0xFF2BC8F0),
                          ],
                          onTap: _open1v1Entry,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('Grammar', Icons.menu_book_rounded),
                        const SizedBox(width: 8),
                        _buildFilterChip('Listening', Icons.headphones_rounded),
                        const SizedBox(width: 8),
                        _buildFilterChip('Vocabulary', Icons.translate),
                        const SizedBox(width: 8),
                        _buildFilterChip('Mixed', Icons.adjust_rounded),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  BattleTeamPanel(
                    title: '3v3 Team Battle',
                    subtitle: 'Role-based battle like a MOBA.',
                    neededText: '6 NEEDED',
                    roles: const ['Grammar', 'Listening', 'Vocab'],
                    onTap: _open3v3Entry,
                  ),
                  const SizedBox(height: 24),
                  UtilityActionsSection(onTap: _onUtilityTap),
                  const SizedBox(height: 24),
                  BattleRoomCodeBanner(
                    title: 'Daily Battle Progress',
                    subtitle: 'Battles today',
                    trailingText: '+18 BP',
                    leading: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0x222BC8F0),
                      ),
                      child: const Icon(
                        Icons.track_changes_rounded,
                        color: Color(0xFF2BC8F0),
                      ),
                    ),
                    bottom: const ProgressSection(),
                  ),
                  const SizedBox(height: 24),
                  const LeaderboardSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon) {
    return BattleRoleChip(
      label: label,
      icon: icon,
      selected: _selectedFilter == label,
      onTap: () => setState(() => _selectedFilter = label),
    );
  }
}
