import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum LoadingIndicatorVariant { dots, circle, plane }

class GlobalLoadingIndicator extends StatelessWidget {
  final LoadingIndicatorVariant variant;
  final double size;
  const GlobalLoadingIndicator({
    super.key,
    this.size = 128,
    this.variant = LoadingIndicatorVariant.dots,
  });

  @override
  Widget build(BuildContext context) {
    late String lottiePath = "assets/lottie/";
    switch (variant) {
      case LoadingIndicatorVariant.circle:
        lottiePath += "loading-circles.json";
        break;
      case LoadingIndicatorVariant.dots:
        lottiePath += "loading-dots.json";
        break;
      case LoadingIndicatorVariant.plane:
        lottiePath += "loading-plane.json";
        break;
    }
    return Lottie.asset(
      lottiePath,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
