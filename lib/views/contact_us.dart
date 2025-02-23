import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:webapp/controller/contact_us_controller.dart';
import 'package:webapp/utils/app_color.dart';

class ContactUsScreen extends StatelessWidget {
  final ContactUsController controller = Get.put(ContactUsController());

  ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Lottie Animation
                Center(
                  child: Lottie.asset(
                    height: Get.height * 0.35,
                    width: Get.width * 0.55,
                    'assets/contact_us.json',
                  ),
                ),

                // Glass Morphism Container
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: AppColors.glassBackground,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: AppColors.glassBorder),
                    boxShadow: [
                      const BoxShadow(
                        color: AppColors.shadowColor,
                        blurRadius: 25,
                        spreadRadius: 6,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Column(
                        children: [
                          const Text(
                            "Got Any Questions or Remarks? We'd Love to Hear From You!",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                              letterSpacing: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),

                          _buildAnimatedTextField(
                            label: 'Name',
                            onChanged: (value) => controller.name.value = value,
                          ).animate().fadeIn(delay: 500.ms).slideY(begin: -0.5),

                          const SizedBox(height: 20),

                          _buildAnimatedTextField(
                            label: 'Email',
                            onChanged: (value) =>
                                controller.email.value = value,
                          ).animate().fadeIn(delay: 700.ms).slideY(begin: -0.5),

                          const SizedBox(height: 20),

                          _buildAnimatedTextField(
                            label: 'Message',
                            onChanged: (value) =>
                                controller.message.value = value,
                            maxLines: 5,
                          ).animate().fadeIn(delay: 900.ms).slideY(begin: -0.5),

                          const SizedBox(height: 30),

                          // Submit Button
                          Obx(
                            () => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: controller.isLoading.value ? 50 : 160,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.buttonGradientStart,
                                    AppColors.buttonGradientEnd
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(
                                    controller.isLoading.value ? 25 : 10),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.buttonShadow.withOpacity(0.3),
                                    blurRadius: 15,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: controller.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.white),
                                    )
                                  : ElevatedButton(
                                      onPressed: controller.submitForm,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text(
                                        'Send',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                            )
                                .animate()
                                .fadeIn(delay: 1100.ms)
                                .slideY(begin: -0.5)
                                .scale(
                                  begin: const Offset(0.95, 0.95),
                                  end: const Offset(1, 1),
                                  curve: Curves.easeInOut,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTextField({
    required String label,
    required Function(String) onChanged,
    int maxLines = 1,
  }) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
            color: AppColors.inputLabel, fontWeight: FontWeight.w600),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Icon(
          label == 'Email'
              ? Icons.email
              : (label == 'Message' ? Icons.message : Icons.person),
          color: AppColors.iconColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppColors.inputBorder, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppColors.inputBorderFocused, width: 2),
        ),
        filled: true,
        fillColor: AppColors.inputBackground,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      maxLines: maxLines,
      style: const TextStyle(fontSize: 16, color: AppColors.inputTextColor),
    );
  }
}
