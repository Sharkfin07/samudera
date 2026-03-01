import 'package:flutter/material.dart';
import 'package:samudera/core/utils/is_dark.dart';
import 'package:samudera/presentation/theme/app_palette.dart';
import 'package:super_bullet_list/bullet_list.dart';

class DeveloperCard extends StatelessWidget {
  final String picturePath;
  const DeveloperCard({super.key, required this.picturePath});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = isDark(context);
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? AppPalette.darkIndigo : Colors.white,
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? AppPalette.lightIndigo
                  : Colors.black.withValues(
                      alpha: 0.5,
                    ), // Shadow color and opacity
              offset: Offset(0, 0), // Horizontal and vertical offset
              blurRadius: 10, // How soft the edge of the shadow is
              spreadRadius: 5, // How much the shadow expands or contracts
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  image: AssetImage(picturePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mohammad Zidane Kurnianto",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Garet",
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Text(
                        "Information Systems 2025",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: double.infinity),
                  Text(
                    "What I Am",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withValues(alpha: .7),
                    ),
                  ),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      _buildTag(
                        icon: Icons.smartphone,
                        text: "Mobile Developer",
                        color: Colors.blue,
                      ),
                      _buildTag(
                        icon: Icons.web,
                        text: "Front-End Developer",
                        color: Colors.purple,
                      ),
                      _buildTag(
                        icon: Icons.music_note,
                        text: "Musician",
                        color: Colors.orange,
                      ),
                      _buildTag(
                        icon: Icons.art_track,
                        text: "Designer",
                        color: Colors.teal,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // * About Me Section
                  Text(
                    "About Me",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withValues(alpha: .7),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Hello World! My name is Mohammad Zidane Kurnianto but you can call me Zika. I am an Information Systems student at Universitas Indonesia with a strong interest in software engineering. Currently, I am focused on learning best practices in scalable app architecture, clean code, and user-centered design while continuously exploring new technologies to grow as a developer.",
                  ),
                  SizedBox(height: 16),

                  // * Fun Fact Section
                  Text(
                    "Fun Facts",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withValues(alpha: .7),
                    ),
                  ),
                  SizedBox(height: 6),
                  SuperBulletList(
                    separator: SizedBox(height: 4),
                    iconSize: 6,
                    gap: 6,
                    crossAxisMargin: 8,
                    items: [
                      Text(
                        "Obsessed with bread (especially freshly baked ones)",
                      ),
                      Text("(Kinda) hates JavaScript"),
                      Text("But somehow likes TypeScript"),
                      Text("Can't drive stick"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
