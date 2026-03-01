import 'package:flutter/material.dart';

class GlobalSliverAppBar extends StatelessWidget {
  final String heroImage;
  final String heroTitle;
  final String heroDesc;
  final IconData heroIcon;
  const GlobalSliverAppBar({
    super.key,
    required this.heroImage,
    required this.heroTitle,
    required this.heroDesc,
    required this.heroIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(heroImage),
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.6),
                BlendMode.darken,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(heroIcon, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        heroTitle,
                        style: const TextStyle(
                          fontFamily: 'Garet',
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    heroDesc,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
