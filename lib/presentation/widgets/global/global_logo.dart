import 'package:flutter/material.dart';

enum LogoVariant { emblem, short, long }

class GlobalLogo extends StatelessWidget {
  final LogoVariant variant;
  final double size;
  const GlobalLogo({
    super.key,
    this.variant = LogoVariant.emblem,
    this.size = 32,
  });
  final logoPath = "assets/icons/samudera-icon.png";

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case LogoVariant.emblem:
        return _buildEmblem();
      case LogoVariant.short:
        return _buildShort();
      case LogoVariant.long:
        return _buildLong();
    }
  }

  Widget _buildEmblem() {
    return Image.asset(logoPath, width: size);
  }

  Widget _buildWithText(String text) {
    return Row(
      children: [
        _buildEmblem(),
        SizedBox(width: size * 0.4),
        Text(
          text,
          style: TextStyle(
            fontSize: size * 0.9,
            fontWeight: FontWeight.w600,
            fontFamily: "Garet",
          ),
        ),
      ],
    );
  }

  Widget _buildShort() {
    return _buildWithText("smdr");
  }

  Widget _buildLong() {
    return _buildWithText("samudera");
  }
}
