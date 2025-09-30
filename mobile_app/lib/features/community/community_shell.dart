import 'package:flutter/material.dart';


import '../../features/community/pulse_page.dart';
import '../../features/community/rooms_page.dart';
import '../../features/community/dm_page.dart';


class CommunityShell extends StatefulWidget {
  static const routeName = '/community';
  const CommunityShell({super.key});

  @override
  State<CommunityShell> createState() => _CommunityShellState();
}

class _CommunityShellState extends State<CommunityShell> {
  int _index = 0;
  final _pages = const [PulsePage(), RoomsPage(), DMPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.public), label: 'Pulse'),
          NavigationDestination(icon: Icon(Icons.forum), label: 'Rooms'),
          NavigationDestination(icon: Icon(Icons.mail), label: 'DM'),
        ],
      ),
    );
  }
}
