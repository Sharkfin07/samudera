import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:samudera/core/utils/is_dark.dart';
import 'package:samudera/presentation/theme/app_palette.dart';
import 'package:samudera/presentation/widgets/global/global_logo.dart';

class GlobalNavigationBar extends StatefulWidget {
  final int index;
  final ValueChanged<int>? onTabChange;
  const GlobalNavigationBar({
    super.key,
    required this.index,
    required this.onTabChange,
  });

  @override
  State<GlobalNavigationBar> createState() => _GlobalNavigationBarState();
}

class _GlobalNavigationBarState extends State<GlobalNavigationBar> {
  final double gap = 10;
  late int selectedIndex;
  int badge = 0;
  final padding = EdgeInsets.symmetric(horizontal: 18, vertical: 12);

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = isDark(context);
    Color iconColor = isDarkMode ? AppPalette.lightIndigo : Colors.black;
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDarkMode ? AppPalette.darkIndigo : Colors.white,
        boxShadow: [
          BoxShadow(
            spreadRadius: -10,
            blurRadius: 60,
            color: isDarkMode
                ? AppPalette.lightIndigo.withValues(alpha: .2)
                : Colors.black.withValues(alpha: .4),
            offset: Offset(0, 25),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 8),
        child: GNav(
          tabs: [
            GButton(
              gap: gap,
              iconActiveColor: AppPalette.vividBlue,
              iconColor: iconColor,
              textColor: AppPalette.vividBlue,
              backgroundColor: AppPalette.vividBlue.withValues(alpha: .2),
              iconSize: 24,
              padding: padding,
              icon: Icons.home,
              text: 'Explore',
              leading: GlobalLogo(variant: LogoVariant.emblem, size: 20),
            ),
            GButton(
              gap: gap,
              iconActiveColor: isDarkMode
                  ? AppPalette.lightIndigo
                  : AppPalette.vividIndigo,
              iconColor: iconColor,
              textColor: isDarkMode
                  ? AppPalette.lightIndigo
                  : AppPalette.vividIndigo,
              backgroundColor: AppPalette.vividIndigo.withValues(alpha: .2),
              iconSize: 24,
              padding: padding,
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              gap: gap,
              iconActiveColor: Colors.pink,
              iconColor: iconColor,
              textColor: Colors.pink,
              backgroundColor: Colors.pink.withValues(alpha: .2),
              iconSize: 24,
              padding: padding,
              icon: Icons.newspaper,
              text: "News",
            ),
            GButton(
              gap: gap,
              iconActiveColor: AppPalette.purple,
              iconColor: iconColor,
              textColor: AppPalette.purple,
              backgroundColor: AppPalette.purple.withValues(alpha: .2),
              iconSize: 24,
              padding: padding,
              icon: Icons.developer_mode,
              text: 'Developer',
            ),
          ],
          selectedIndex: selectedIndex,
          onTabChange: (index) {
            widget.onTabChange?.call(index);
          },
        ),
      ),
    );
  }
}
