import 'package:flutter/material.dart';
import 'package:samudera/presentation/theme/app_palette.dart';
import 'package:samudera/presentation/widgets/global/global_button.dart';
import 'package:samudera/presentation/widgets/global/global_field.dart';
import 'package:samudera/presentation/widgets/global/global_loading_indicator.dart';
import 'package:samudera/presentation/widgets/global/global_logo.dart';
import 'package:samudera/presentation/widgets/global/navigation_bar.dart';

class WidgetShowcaseScreen extends StatelessWidget {
  const WidgetShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dev: Widget Showcase")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity),
              Text("AppPalette", textAlign: TextAlign.center),
              SizedBox(height: 16),
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
                  Container(
                    color: AppPalette.darkIndigo,
                    width: 50,
                    height: 50,
                  ),
                  Container(
                    color: AppPalette.lightIndigo,
                    width: 50,
                    height: 50,
                  ),
                  Container(color: AppPalette.purple, width: 50, height: 50),
                  Container(color: AppPalette.vividBlue, width: 50, height: 50),
                ],
              ),
              _showcaseDivider(),
              Text("Button", textAlign: TextAlign.center),
              SizedBox(height: 16),
              Column(
                spacing: 12,
                children: [
                  GlobalButton(
                    text: "Gradient Button",
                    variant: ButtonVariant.gradient,
                    onPressed: () {},
                  ),
                  GlobalButton(
                    text: "Gradient Button w/ Icon",
                    variant: ButtonVariant.gradient,
                    icon: Icon(Icons.graphic_eq),
                    onPressed: () {},
                  ),
                  GlobalButton(
                    text: "Outlined Button",
                    variant: ButtonVariant.outlined,
                    onPressed: () {},
                  ),
                  GlobalButton(
                    text: "Outlined Button w/ Icon",
                    variant: ButtonVariant.outlined,
                    icon: Icon(Icons.ac_unit),
                    onPressed: () {},
                  ),
                  GlobalButton(
                    text: "Text Button",
                    variant: ButtonVariant.text,
                    onPressed: () {},
                  ),
                  GlobalButton(
                    text: "Text Button",
                    onPressed: () {},
                    isLoading: true,
                  ),
                ],
              ),
              _showcaseDivider(),
              Text("Disabled Button", textAlign: TextAlign.center),
              SizedBox(height: 16),
              Column(
                spacing: 12,
                children: [
                  GlobalButton(
                    text: "Disabled Gradient Button",
                    variant: ButtonVariant.gradient,
                  ),
                  GlobalButton(
                    text: "Disabled Gradient Button",
                    variant: ButtonVariant.outlined,
                  ),
                ],
              ),
              _showcaseDivider(),
              Text("Global Logo", textAlign: TextAlign.center),
              Column(
                spacing: 12,
                children: [
                  GlobalLogo(),
                  GlobalLogo(variant: LogoVariant.short),
                  GlobalLogo(variant: LogoVariant.long, size: 40),
                ],
              ),
              _showcaseDivider(),
              Text("Loading Indicator", textAlign: TextAlign.center),
              GlobalLoadingIndicator(),
              GlobalLoadingIndicator(variant: LoadingIndicatorVariant.circle),
              GlobalLoadingIndicator(variant: LoadingIndicatorVariant.plane),
              _showcaseDivider(),
              Text("Text Field"),
              GlobalField(
                prefixIcon: Icon(Icons.search, color: AppPalette.vividBlue),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GlobalNavigationBar(
        index: 0,
        onTabChange: (int value) {},
      ),
    );
  }

  Widget _showcaseDivider({double? height}) {
    return Column(
      children: [
        SizedBox(height: height ?? 16),
        Divider(),
        SizedBox(height: height ?? 16),
      ],
    );
  }
}
