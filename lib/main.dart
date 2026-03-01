import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samudera/presentation/cubit/explore_cubit.dart';
import 'package:samudera/presentation/cubit/news_cubit.dart';
import 'package:samudera/presentation/screens/home_shell.dart';
import 'package:samudera/presentation/theme/app_theme.dart';

import './core/config/env_config.dart';

Future<void> main() async {
  await EnvConfig.load();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsCubit>(create: (_) => NewsCubit()),
        BlocProvider<ExploreCubit>(create: (_) => ExploreCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: HomeShell(),
      ),
    );
  }
}
