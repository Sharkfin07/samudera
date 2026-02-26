import 'package:flutter/material.dart';
import 'package:samudera/presentation/theme/app_palette.dart';

class WidgetShowcaseScreen extends StatelessWidget {
  const WidgetShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dev: Widget Showcase")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity),
            Text("AppPalette", textAlign: TextAlign.center),
            Row(
              spacing: 24,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: AppPalette.primaryGradient,
                  ),
                  width: 50,
                  height: 50,
                ),
                Container(color: AppPalette.darkIndigo, width: 50, height: 50),
                Container(color: AppPalette.lightIndigo, width: 50, height: 50),
                Container(color: AppPalette.purple, width: 50, height: 50),
                Container(color: AppPalette.vividBlue, width: 50, height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
