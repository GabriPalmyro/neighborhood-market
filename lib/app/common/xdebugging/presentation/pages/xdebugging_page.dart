import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/xdebugging/presentation/pages/menu_xdebugging_page.dart';

import '../../features/network/presentation/pages/network_requests_page.dart';

class DebuggingPage extends StatefulWidget {
  const DebuggingPage({super.key});

  @override
  State<DebuggingPage> createState() => _DebuggingPageState();
}

class _DebuggingPageState extends State<DebuggingPage> {
  int _index = 0;
  final List<Widget> _pages = [
    const NetworkRequestsPage(),
    const MenuXdebuggingPage(),
    Container(),
  ];

  final List<String> _titles = [
    'Network',
    'Menu',
    'Shared Preferences',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.network_check),
            label: _titles[0],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu),
            label: _titles[1],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: _titles[2],
          ),
        ],
      ),
    );
  }
}
