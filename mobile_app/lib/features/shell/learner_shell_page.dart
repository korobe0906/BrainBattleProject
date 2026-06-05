import 'package:flutter/material.dart';

import '../profile/ui/language_goal_setup_page.dart';
import '../profile/ui/learner_profile_page.dart';
import '../profile/ui/wallet_link_page.dart';
import 'widgets/learner_bottom_nav.dart';
import 'widgets/shell_placeholder_page.dart';

class LearnerShellPage extends StatefulWidget {
  const LearnerShellPage({super.key});

  static const routeName = '/learner-shell';

  @override
  State<LearnerShellPage> createState() => _LearnerShellPageState();
}

class _LearnerShellPageState extends State<LearnerShellPage> {
  int _index = 0;

  late final List<Widget> _pages = [
    ShellPlaceholderPage.home(onGoLearn: () => setState(() => _index = 1)),
    const LanguageGoalSetupPage(embedded: true),
    const ShellPlaceholderPage(
      title: 'Battle',
      subtitle: 'Real-time battle core will be connected after auth/profile.',
      icon: Icons.flash_on_rounded,
      primaryActionLabel: 'Coming Soon',
    ),
    ShellPlaceholderPage(
      title: 'Rewards',
      subtitle: 'BrainPoints, wallet, and blockchain verification.',
      icon: Icons.bolt_rounded,
      primaryActionLabel: 'Connect Wallet',
      onPrimaryAction: () {
        Navigator.of(context).pushNamed(WalletLinkPage.routeName);
      },
    ),
    const LearnerProfilePage(embedded: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: LearnerBottomNav(
        currentIndex: _index,
        onChanged: (value) => setState(() => _index = value),
      ),
    );
  }
}