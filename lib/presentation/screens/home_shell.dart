import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samudera/presentation/cubit/explore_cubit.dart';
import 'package:samudera/presentation/cubit/news_cubit.dart';
import 'package:samudera/presentation/screens/developer/developer_screen.dart';
import 'package:samudera/presentation/screens/explore/explore_screen.dart';
import 'package:samudera/presentation/screens/news/news_screen.dart';
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
    NewsScreen(),
    DeveloperScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchForTab(_index);
    });
  }

  // Lazy fetching (hemat token cui)
  void _fetchForTab(int tabIndex) {
    if (tabIndex == 0) {
      context.read<ExploreCubit>().fetchMarketMovers();
    } else if (tabIndex == 2) {
      context.read<NewsCubit>().fetchNews();
    }
  }

  void _onTabChange(int i) {
    setState(() {
      _index = i;
    });
    _fetchForTab(i);
  }

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
