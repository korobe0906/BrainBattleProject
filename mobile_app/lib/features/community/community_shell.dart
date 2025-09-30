class CommunityShell extends StatefulWidget {
  const CommunityShell({super.key});
  static const route = '/community';

  @override
  State<CommunityShell> createState() => _CommunityShellState();
}

class _CommunityShellState extends State<CommunityShell> {
  int _index = 0;
  final _pages = const [PulsePage(), RoomsPage(), DMPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_index]),
      bottomNavigationBar: NavigationBar(
        height: 68,
        selectedIndex: _index,
        backgroundColor: BBPalette.darkBg,
        indicatorColor: BBPalette.purple.withOpacity(0.22),
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.bolt_outlined), selectedIcon: Icon(Icons.bolt), label: 'Pulse'),
          NavigationDestination(icon: Icon(Icons.forum_outlined), selectedIcon: Icon(Icons.forum), label: 'Rooms'),
          NavigationDestination(icon: Icon(Icons.mail_outline), selectedIcon: Icon(Icons.mail), label: 'DM'),
        ],
      ),
    );
  }
}
