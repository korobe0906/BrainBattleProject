import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../battle_routes.dart';
import '../models/battle_stage.dart';
import '../widgets/battle_1v1/entry/battle_1v1_header.dart';
import '../widgets/battle_1v1/entry/duel_mode_card.dart';
import '../widgets/battle_1v1/entry/duel_tab_switcher.dart';
import '../widgets/battle_1v1/entry/match_info_card.dart';
import '../widgets/battle_1v1/entry/room_code_input_card.dart';

class Battle1v1EntryPage extends StatefulWidget {
  const Battle1v1EntryPage({super.key});
  static const routeName = BattleRoutes.v1Entry;
  static const stage = BattleStage.entry;

  @override
  State<Battle1v1EntryPage> createState() => _Battle1v1EntryPageState();
}

class _Battle1v1EntryPageState extends State<Battle1v1EntryPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  String _battleType = 'MIXED';
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
              child: BattleHeader(
                onBack: () => Navigator.of(context).pop(),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DuelTabSwitcher(controller: _tab),
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

  // ------------------ CREATE DUEL TAB ------------------

  Widget _buildCreateTab(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Battle Mode',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '10 questions • Ranked duel',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 24),
          DuelModeCard(
            selected: _battleType == 'LISTENING',
            onTap: () => setState(() => _battleType = 'LISTENING'),
            title: 'Listening battle',
            subtitle:
                'Test your listening skills by answering audio questions.',
            detailLabel: 'Difficulty: ',
            detailValue: 'Medium',
            detailSuffix: ' • ~2 minutes',
            detailValueColor: const Color(0xFF00D9FF),
            icon: Icons.headphones_rounded,
            questionCount: '10 questions',
          ),
          const SizedBox(height: 16),
          DuelModeCard(
            selected: _battleType == 'VOCABULARY',
            onTap: () => setState(() => _battleType = 'VOCABULARY'),
            title: 'Vocabulary battle',
            subtitle: 'Choose the correct word or meaning in context.',
            detailLabel: 'Difficulty: ',
            detailValue: 'Medium',
            detailSuffix: ' • ~2 minutes',
            detailValueColor: const Color(0xFF00D9FF),
            icon: Icons.menu_book_rounded,
            questionCount: '10 questions',
          ),
          const SizedBox(height: 16),
          DuelModeCard(
            selected: _battleType == 'GRAMMAR',
            onTap: () => setState(() => _battleType = 'GRAMMAR'),
            title: 'Grammar battle',
            subtitle: 'Test your grammar skills with sentence challenges.',
            detailLabel: 'Difficulty: ',
            detailValue: 'Hard',
            detailSuffix: ' • ~3 minutes',
            detailValueColor: const Color(0xFFFFA726),
            icon: Icons.spellcheck_rounded,
            questionCount: '10 questions',
          ),
          const SizedBox(height: 16),
          DuelModeCard(
            selected: _battleType == 'MIXED',
            onTap: () => setState(() => _battleType = 'MIXED'),
            mixedStyle: true,
            title: 'Mixed battle',
            subtitle: 'All three skills combined.',
            icon: Icons.auto_awesome_rounded,
            badgeText: '10 Questions',
            roles: const [
              (label: 'Listening', icon: Icons.headphones_rounded),
              (label: 'Reading', icon: Icons.menu_book_rounded),
              (label: 'Writing', icon: Icons.spellcheck_rounded),
            ],
          ),
          const SizedBox(height: 24),
          const MatchInfoCard(),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: const LinearGradient(
                  colors: [Color(0xFFF57AA7), Color(0xFFEAAFC8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF8DB7).withOpacity(0.45),
                    blurRadius: 24,
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
                      BattleRoutes.v1Matchmaking,
                      arguments: {
                        'battleType': _battleType,
                        'isHost': true,
                        'roomCode': 'AB37X',
                      },
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        'Create Duel',
                        style: TextStyle(
                          color: Color(0xFF160B18),
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Searching opponent with similar rank',
              style: TextStyle(color: Colors.white38, fontSize: 13),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Wrap(
              spacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text(
                  'Private duel?',
                  style: TextStyle(color: Colors.white54, fontSize: 13),
                ),
                InkWell(
                  onTap: () => _tab.animateTo(1),
                  borderRadius: BorderRadius.circular(10),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      'Join by code instead',
                      style: TextStyle(
                        color: Color(0xFF00D9FF),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------ JOIN BY CODE TAB ------------------

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
            'Join a private duel created by another player.',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 24),
          RoomCodeInputCard(controller: _codeCtrl),
          const SizedBox(height: 8),
          const Text(
            'You will join the battle mode chosen by the host.',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 24),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _codeCtrl,
            builder: (context, value, _) {
              final code = value.text.trim().toUpperCase();
              final canJoin = RegExp(r'^[A-Z0-9]{4,10}$').hasMatch(code);

              return SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: canJoin
                        ? const LinearGradient(
                            colors: [Color(0xFFF57AA7), Color(0xFFEAAFC8)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [
                              const Color(0xFF4A556B).withOpacity(0.55),
                              const Color(0xFF2A364B).withOpacity(0.55),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    boxShadow: canJoin
                        ? [
                            BoxShadow(
                              color: const Color(0xFFFF8DB7).withOpacity(0.38),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ]
                        : null,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: canJoin
                          ? () {
                              Navigator.of(context).pushNamed(
                                BattleRoutes.v1Matchmaking,
                                arguments: {
                                  'battleType': 'UNKNOWN',
                                  'isHost': false,
                                  'roomCode': code,
                                },
                              );
                            }
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            'Join Duel',
                            style: TextStyle(
                              color: canJoin
                                  ? const Color(0xFF160B18)
                                  : Colors.white38,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Center(
            child: Wrap(
              spacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text(
                  'No code?',
                  style: TextStyle(color: Colors.white54, fontSize: 13),
                ),
                InkWell(
                  onTap: () => _tab.animateTo(0),
                  borderRadius: BorderRadius.circular(10),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      'Create your own duel',
                      style: TextStyle(
                        color: Color(0xFF00D9FF),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}