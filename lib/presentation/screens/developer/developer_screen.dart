import 'package:flutter/material.dart';
import 'package:samudera/presentation/screens/developer/secret_screen.dart';
import 'package:samudera/presentation/widgets/developer/developer_card.dart';
import 'package:samudera/presentation/widgets/global/global_button.dart';

class DeveloperScreen extends StatefulWidget {
  const DeveloperScreen({super.key});

  @override
  State<DeveloperScreen> createState() => _DeveloperScreenState();
}

class _DeveloperScreenState extends State<DeveloperScreen> {
  final picturePath = "assets/images/self-pic.jpg";
  int _tapCount = 0;
  DateTime? _lastTap;

  void _onEasterEggTap() {
    final now = DateTime.now();
    // Reset counter if more than 1 second since last tap
    if (_lastTap != null && now.difference(_lastTap!).inMilliseconds > 1000) {
      _tapCount = 0;
    }
    _lastTap = now;
    _tapCount++;

    if (_tapCount >= 3) {
      _tapCount = 0;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SecretScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity),
              Text(
                "Made With Love By:",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(height: 16),

              // * Dev Card
              DeveloperCard(picturePath: picturePath),
              SizedBox(height: 16),

              // * Easter egg button
              GlobalButton(
                text: "Version 1.0.0",
                variant: ButtonVariant.text,
                onPressed: _onEasterEggTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
