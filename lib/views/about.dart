import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:webapp/utils/app_color.dart';
import 'package:webapp/utils/constants.dart'; // Importing AppColors

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(),
            LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = Constants.isMobile(context);

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Lottie animation (responsive width & height)
                      if (!isMobile)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Lottie.asset(
                              'assets/protect.json',
                              height: Get.height * 0.5,
                              width: Get.width * 0.4,
                            ),
                            _buildCompanyStory(),
                          ],
                        )
                      else ...[
                        Lottie.asset(
                          'assets/protect.json',
                          height: Get.height * 0.3,
                          width: Get.width * 0.7,
                        ),
                        _buildCompanyStory(),
                      ],
                      const SizedBox(height: 40),
                      _buildCTASection(),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

// 🔹 Hero Section
  Widget _buildHeroSection() {
    return Stack(
      children: [
        Image.asset(
          'assets/cyber_image.jpeg',
          width: double.infinity,
          height: 350,
          fit: BoxFit.cover,
        ),
        Container(
          height: 350,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.heroGradientStart, AppColors.heroGradientEnd],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 20,
          right: 20,
          child: Column(
            children: [
              const FittedBox(
                child: Text(
                  'Protect Yourself from Phishing Attacks',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                    letterSpacing: 1.5,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonPrimary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Learn More',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

// 🔹 Company Story Section
  Widget _buildCompanyStory() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FittedBox(
            child: Text(
              "Who We Are",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "We specialize in providing cutting-edge phishing detection solutions. Our team of experts uses machine learning algorithms and advanced techniques to identify phishing websites, emails, and other online threats, ensuring a safer digital experience for everyone.",
            style: TextStyle(
              fontSize: 18,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3);
  }

// 🔹 Call-to-Action Section
  Widget _buildCTASection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.ctaBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.ctaShadow.withOpacity(0.4),
            blurRadius: 10,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Stay One Step Ahead of Phishing Threats!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.textWhite,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.buttonPrimary,
              backgroundColor: AppColors.buttonSecondary,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Protect My Account',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
