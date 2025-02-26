import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webapp/controller/home_controller.dart';
import 'package:webapp/views/email_sms_checker.dart';
import 'package:webapp/views/password_generator.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 800;
    HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildToolCard(
                  icon: Icons.email,
                  title: 'Email & Message Phishing Checker',
                  description:
                      'Analyze suspicious emails and messages for phishing threats.',
                  onTap: () {
                    Get.to(PhishingCheckerScreen());
                  },
                ),
                const SizedBox(height: 20),
                _buildToolCard(
                  icon: Icons.vpn_key,
                  title: 'Strong Password Generator',
                  description:
                      'Generate highly secure passwords for better online safety.',
                  onTap: () {
                    Get.to(PasswordGeneratorScreen());
                  },
                ),
                const SizedBox(height: 20),
                _buildToolCard(
                  icon: Icons.web,
                  title: 'Phishing Website Checker',
                  description:
                      'Use this tool to verify suspicious websites before you enter sensitive data.',
                  onTap: () {
                    homeController.currentPageIndex.value = 0;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToolCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.3),
              child: Icon(icon, size: 30, color: Colors.white),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 18, color: Colors.white70),
          ],
        ),
      ),
    );
  }
}
