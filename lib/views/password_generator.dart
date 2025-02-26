import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PasswordGeneratorScreen extends StatefulWidget {
  const PasswordGeneratorScreen({super.key});

  @override
  State<PasswordGeneratorScreen> createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen>
    with SingleTickerProviderStateMixin {
  final RxString generatedPassword = ''.obs;
  final RxInt passwordLength = 12.obs;
  final RxBool includeNumbers = true.obs;
  final RxBool includeSymbols = true.obs;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    generatePassword();
  }

  void generatePassword() {
    const String chars =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_+-=[]{}|;:'\",.<>?/";

    String password = "";
    Random rand = Random();
    for (int i = 0; i < passwordLength.value; i++) {
      password += chars[rand.nextInt(chars.length)];
    }

    generatedPassword.value = password;
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: generatedPassword.value));
    Get.snackbar(
      "Copied!",
      "Password copied to clipboard",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue.shade900,
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
      duration: const Duration(seconds: 2),
    );
  }

  Color getStrengthColor() {
    if (passwordLength.value < 8) return Colors.red;
    if (passwordLength.value < 12) return Colors.orange;
    return Colors.green;
  }

  String getStrengthText() {
    if (passwordLength.value < 8) return "Weak";
    if (passwordLength.value < 12) return "Medium";
    return "Strong";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "🔑 AI-Powered Password Generator",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        elevation: 5,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ScaleTransition(
              scale: _fadeAnimation,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "🔒 Secure AI-Generated Password:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      Obx(() => Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    generatedPassword.value,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  onPressed: copyToClipboard,
                                  icon: const Icon(Icons.copy,
                                      color: Colors.blue),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(height: 20),
                      Obx(() => Row(
                            children: [
                              const Text("Password Strength: ",
                                  style: TextStyle(fontSize: 14)),
                              Text(
                                getStrengthText(),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: getStrengthColor()),
                              ),
                              const SizedBox(width: 10),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 50,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: getStrengthColor(),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(height: 20),
                      Obx(() => Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Password Length:",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                  Text("${passwordLength.value}",
                                      style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                              Slider(
                                value: passwordLength.value.toDouble(),
                                min: 6,
                                max: 20,
                                divisions: 14,
                                label: "${passwordLength.value}",
                                activeColor: Colors.blue.shade900,
                                onChanged: (value) {
                                  passwordLength.value = value.toInt();
                                  generatePassword();
                                },
                              ),
                            ],
                          )),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("🔹 Why Choose AI-Powered Passwords?",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Text("• Unique and hard-to-guess passwords",
                                style: TextStyle(fontSize: 14)),
                            Text("• Enhanced security with strong encryption",
                                style: TextStyle(fontSize: 14)),
                            Text("• Designed to prevent brute-force attacks",
                                style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: generatePassword,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Colors.blue.shade900,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                          ),
                          child: const Text("🔄 Generate New Password",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
