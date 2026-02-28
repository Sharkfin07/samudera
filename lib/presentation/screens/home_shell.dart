import 'package:flutter/material.dart';
import 'package:samudera/presentation/screens/developer/developer_screen.dart';
import 'package:samudera/presentation/screens/explore/explore_screen.dart';
import 'package:samudera/presentation/screens/news/news_screen.dart';
import 'package:samudera/presentation/screens/search/search_screen.dart';
import 'package:samudera/presentation/widgets/global/navigation_bar.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;
  final List<Widget> _pages = const [
    ExploreScreen(),
    SearchScreen(),
    NewsScreen(),
    DeveloperScreen(),
  ];

  void _onTabChange(int i) => setState(() {
    _index = i;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: GlobalNavigationBar(
        index: _index,
        onTabChange: _onTabChange,
      ),
    );
  }
}
