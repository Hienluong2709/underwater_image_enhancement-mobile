import 'dart:async';
import 'package:flutter/material.dart';
import 'package:underwater_image_enhancement/constants/app_colors.dart';
import 'package:underwater_image_enhancement/utils/time_utils.dart';
import 'package:underwater_image_enhancement/modules/historys/history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String greeting;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    greeting = getGreetingByLocalTime();

    // Cập nhật mỗi phút để bắt mốc giờ mới
    _timer = Timer.periodic(
      const Duration(minutes: 1),
          (_) {
        setState(() {
          greeting = getGreetingByLocalTime();
        });
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text chào
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            greeting,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Restore true underwater colors',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      // Icon History
                      IconButton(
                        icon: const Icon(
                          Icons.history,
                          color: AppColors.textPrimary,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HistoryPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const Spacer(),

              // Main Camera Button
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [
                          AppColors.accentPrimary,
                          AppColors.accentSecondary,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentPrimary,
                          blurRadius: 30,
                          spreadRadius: 4,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.camera_alt_rounded,
                          color: AppColors.textPrimary,
                          size: 42,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Enhance with AI',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Secondary actions
              Row(
                children: [
              Expanded(
              child: _ActionCard(
              icon: Icons.photo_library_outlined,
                label: 'Gallery',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
                child: _ActionCard(
                  icon: Icons.auto_fix_high,
                  label: 'Batch Enhance',
                ),
            ),
                ],
              ),

              const SizedBox(height: 20),
            ]),
            ),
        ));
  }
}
class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionCard({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.glass,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.textPrimary),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
