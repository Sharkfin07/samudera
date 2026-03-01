import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samudera/presentation/cubit/news_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsCubit>(create: (_) => NewsCubit()..fetchNews()),
        // tambah BlocProvider lain di sini nanti
      ],
      child: Scaffold(
        body: IndexedStack(index: _index, children: _pages),
        bottomNavigationBar: GlobalNavigationBar(
          index: _index,
          onTabChange: _onTabChange,
        ),
      ),
    );
  }
}
