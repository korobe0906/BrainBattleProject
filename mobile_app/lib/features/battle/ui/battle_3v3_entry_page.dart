import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../battle_routes.dart';
import '../models/battle_stage.dart';
import '../widgets/battle_3v3/entry/battle_3v3_header.dart';
import '../widgets/battle_3v3/entry/role_card.dart';
import '../widgets/battle_3v3/entry/team_battle_info_card.dart';
import '../widgets/battle_3v3/entry/team_mode_explanation_card.dart';
import '../widgets/battle_3v3/entry/team_preview_section.dart';
import '../widgets/battle_3v3/entry/team_room_code_card.dart';
import '../widgets/battle_3v3/entry/team_tabs.dart';

class Battle3v3EntryPage extends StatefulWidget {
  const Battle3v3EntryPage({super.key});
  static const routeName = BattleRoutes.v3Entry;
  static const stage = BattleStage.entry;

  @override
  State<Battle3v3EntryPage> createState() => _Battle3v3EntryPageState();
}

class _Battle3v3EntryPageState extends State<Battle3v3EntryPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  final _codeCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    _codeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BBColors.darkBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Battle3v3Header(
                onBack: () => Navigator.of(context).pop(),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TeamTabs(controller: _tab),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tab,
                children: [_buildCreateTab(context), _buildJoinTab(context)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------------
  // --------------------------- CREATE TEAM TAB -----------------------------
  // ------------------------------------------------------------------------

  Widget _buildCreateTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TeamModeExplanationCard(),
          const SizedBox(height: 24),
          const Text(
            'Choose Your Role',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          const RoleCard(
            title: 'Grammar',
            description: 'Test your grammar skills with sentence challenges.',
            icon: Icons.spellcheck_rounded,
            badgeText: '10 questions',
          ),
          const SizedBox(height: 12),
          const RoleCard(
            title: 'Listening',
            description:
                'Test your listening skills by answering audio questions.',
            icon: Icons.headphones_rounded,
            badgeText: '10 questions',
          ),
          const SizedBox(height: 12),
          const RoleCard(
            title: 'Vocabulary',
            description:
                'Test your vocabulary knowledge in different contexts.',
            icon: Icons.menu_book_rounded,
            badgeText: '10 questions',
          ),
          const SizedBox(height: 24),
          const TeamBattleInfoCard(),
          const SizedBox(height: 24),
          const TeamPreviewSection(),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: const LinearGradient(
                  colors: [Color(0xFFF57AA7), Color(0xFFF76095)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF7EB6).withOpacity(0.45),
                    blurRadius: 22,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      BattleRoutes.v3Matchmaking,
                      arguments: {'roomCode': 'TEAM1', 'isHost': true},
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        'Create Team Room',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A0B1B),
                          fontSize: 15.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'Invite teammates or share the room code.',
              style: TextStyle(color: Colors.white54, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------------
  // ---------------------------- JOIN TEAM TAB -----------------------------
  // ------------------------------------------------------------------------

  Widget _buildJoinTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter Room Code',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Join a team room created by your teammates.',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 24),
          TeamRoomCodeCard(controller: _codeCtrl),
          const SizedBox(height: 8),
          const Text(
            'You will automatically be placed in Team A or Team B depending on available slots.',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: const LinearGradient(
                  colors: [Color(0xFFF57AA7), Color(0xFFF76095)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF7EB6).withOpacity(0.42),
                    blurRadius: 22,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      BattleRoutes.v3Matchmaking,
                      arguments: {
                        'roomCode': _codeCtrl.text.trim().isEmpty
                            ? 'TEAM'
                            : _codeCtrl.text.trim().toUpperCase(),
                        'isHost': false,
                      },
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        'Join Team Room',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A0B1B),
                          fontSize: 15.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}