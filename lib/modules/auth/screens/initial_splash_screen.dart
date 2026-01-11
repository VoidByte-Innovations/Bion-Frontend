import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:bion_frontend/modules/auth/screens/splash_screen.dart';

class InitialSplashScreen extends StatefulWidget {
  const InitialSplashScreen({super.key});

  @override
  _InitialSplashScreenState createState() => _InitialSplashScreenState();
}

class _InitialSplashScreenState extends State<InitialSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  // Theme constants based on the design
  static const Color primaryYellow = Color(0xFFF2F20D);
  static const Color backgroundLight = Color(0xFFFCFCF8);
  static const Color textDark = Color(0xFF1C1C0D);
  static const Color subtextGrey = Color(0xFF9C9C49);
  static const Color progressTrack = Color(0xFFE8E8CE);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SplashScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),

            // Central Branding Section
            Column(
              children: [
                // Hexagon Logo
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipPath(
                      clipper: HexagonClipper(),
                      child: Container(
                        width: 120,
                        height: 138,
                        color: primaryYellow,
                      ),
                    ),
                    ClipPath(
                      clipper: HexagonClipper(),
                      child: Container(
                        width: 90,
                        height: 104,
                        color: backgroundLight,
                        child: Center(
                          child: Stack(
                            children: [
                              const Text(
                                'B',
                                style: TextStyle(
                                  color: textDark,
                                  fontSize: 48,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -2,
                                ),
                              ),
                              // Small security dot
                              Positioned(
                                bottom: 6,
                                right: 0,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: primaryYellow,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: backgroundLight,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Brand Name
                const Text(
                  'Bion',
                  style: TextStyle(
                    color: textDark,
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                    height: 1,
                  ),
                ),
                const Text(
                  'HIGH-SECURITY',
                  style: TextStyle(
                    color: subtextGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),

            const Spacer(flex: 2),

            // Footer / Progress Area
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 48.0,
                vertical: 48.0,
              ),
              child: Column(
                children: [
                  Text(
                    'Initializing secure tunnel...',
                    style: TextStyle(
                      color: textDark.withOpacity(0.6),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Progress Bar
                  AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return Container(
                        width: double.infinity,
                        height: 4,
                        decoration: BoxDecoration(
                          color: progressTrack,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: _progressAnimation.value,
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryYellow,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // Security Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.verified_user, size: 18, color: subtextGrey),
                      SizedBox(width: 8),
                      Text(
                        'END-TO-END ENCRYPTED',
                        style: TextStyle(
                          color: subtextGrey,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
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
}

// Custom Clipper to create the Hexagon shape
class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.lineTo(size.width, size.height * 0.25);
    path.lineTo(size.width, size.height * 0.75);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(0, size.height * 0.75);
    path.lineTo(0, size.height * 0.25);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
