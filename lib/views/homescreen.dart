import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:webapp/controller/home_controller.dart';
import 'package:webapp/views/about.dart';
import 'package:webapp/views/contact_us.dart';
import 'package:webapp/views/tools.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(
    HomeController(),
  );

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of pages to display in the body
    final List<Widget> pages = [
      HomeContent(
        controller: controller,
      ), // Home page content
      const ToolsScreen(),
      AboutUsScreen(),
      ContactUsScreen(), // Contact Us page
      // Add more pages here as needed
    ];
    return Scaffold(
      body: Column(
        children: [
          // Persistent AppBar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade900, Colors.blue.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const Text(
                //   'PhishGuard',
                //   style: TextStyle(
                //       fontSize: 24,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white),
                // ),
                SizedBox(
                    height: 60,
                    child: Image.asset(
                        color: Colors.white, 'assets/PHISHINGGUARD-LOGO.png')),
                Row(
                  children: [
                    _navButton(
                        'Home', () => controller.currentPageIndex.value = 0),
                    _navButton(
                        'Tools', () => controller.currentPageIndex.value = 1),
                    _navButton(
                        'About', () => controller.currentPageIndex.value = 2),
                    _navButton(
                        'Contact', () => controller.currentPageIndex.value = 3),
                  ],
                ),
              ],
            ),
          ),

          // Dynamic Body Content

          Expanded(
            child: Obx(() => pages[controller.currentPageIndex.value]),
          ),
        ],
      ),
    );
  }

  Widget _navButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final HomeController controller;

  HomeContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 800; // Responsive Check

    return SingleChildScrollView(
      child: Column(
        children: [
          // 🔹 Hero Section
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 10 : 20,
              vertical: isMobile ? 60 : 100,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade50, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Phishing URL Checker',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 28 : 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Enter a URL to check if it\'s safe or phishing',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 40),

                // 🔹 Input Field (Responsive)
                Container(
                  width: isMobile ? screenWidth * 0.9 : 600,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Enter URL to check...',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) => controller.url.value = value,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Obx(() => ElevatedButton(
                            onPressed: controller.checkPhishing,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 20 : 30,
                                vertical: isMobile ? 10 : 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              backgroundColor: Colors.blue.shade900,
                            ),
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text(
                                    'Check',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 🔹 Result Display
                Obx(() => Text(
                      controller.result.value,
                      style: TextStyle(
                        fontSize: isMobile ? 18 : 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    )),
              ],
            ),
          ),

          // 🔹 Features Section
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: isMobile ? 40 : 60,
            ),
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  'Why Choose PhishGuard?',
                  style: TextStyle(
                    fontSize: isMobile ? 24 : 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ).animate().fadeIn(delay: 300.ms).slideY(begin: -0.5),
                const SizedBox(height: 40),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildFeatureCard(
                      icon: Icons.security,
                      title: 'Advanced Security',
                      description:
                          'Uses cutting-edge algorithms to detect phishing websites.',
                    ),
                    _buildFeatureCard(
                      icon: Icons.speed,
                      title: 'Fast Results',
                      description:
                          'Get instant results with minimal waiting time.',
                    ),
                    _buildFeatureCard(
                      icon: Icons.verified_user,
                      title: 'Reliable',
                      description: 'Trusted by thousands of users worldwide.',
                    ),
                    _buildFeatureCard(
                      icon: Icons.phone_android,
                      title: 'Cross-Platform',
                      description:
                          'Works seamlessly on all devices and platforms.',
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 🔹 How It Works Section
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: isMobile ? 40 : 60,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade50, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'How It Works',
                  style: TextStyle(
                    fontSize: isMobile ? 24 : 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ).animate().fadeIn(delay: 300.ms).slideY(begin: -0.5),
                const SizedBox(height: 40),

                // Steps (Responsive: Wrap for Mobile, Row for Desktop)
                isMobile
                    ? Column(
                        children: [
                          _buildStepCard(
                              step: '1',
                              title: 'Enter URL',
                              description: 'Enter the URL to check.'),
                          SizedBox(height: 10),
                          _buildStepCard(
                              step: '2',
                              title: 'Click Check',
                              description: 'Click the "Check" button.'),
                          SizedBox(height: 10),
                          _buildStepCard(
                              step: '3',
                              title: 'Get Results',
                              description: 'See if it’s phishing or safe.'),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStepCard(
                              step: '1',
                              title: 'Enter URL',
                              description: 'Enter the URL to check.'),
                          _buildStepCard(
                              step: '2',
                              title: 'Click Check',
                              description: 'Click the "Check" button.'),
                          _buildStepCard(
                              step: '3',
                              title: 'Get Results',
                              description: 'See if it’s phishing or safe.'),
                        ],
                      ),
              ],
            ),
          ),

          // 🔹 Footer
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade900, Colors.blue.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Text(
                '© 2023 PhishGuard. All rights reserved.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
      {required IconData icon,
      required String title,
      required String description}) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 50, color: Colors.blue.shade900),
          const SizedBox(height: 10),
          Text(title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(description, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildStepCard(
      {required String step,
      required String title,
      required String description}) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue.shade900,
            child: Text(
              step,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
