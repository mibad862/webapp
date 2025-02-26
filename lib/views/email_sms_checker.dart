import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhishingCheckerScreen extends StatefulWidget {
  const PhishingCheckerScreen({super.key});

  @override
  State<PhishingCheckerScreen> createState() => _PhishingCheckerScreenState();
}

class _PhishingCheckerScreenState extends State<PhishingCheckerScreen>
    with SingleTickerProviderStateMixin {
  final RxString inputText = ''.obs;
  final RxString result = ''.obs;
  final RxBool isLoading = false.obs;

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
  }

  void checkPhishing() async {
    if (inputText.value.trim().isEmpty) {
      result.value = "⚠️ Please enter an email or message to analyze.";
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // Simulating API response

    // Dummy response for phishing detection
    if (inputText.value.contains("bank") ||
        inputText.value.contains("password")) {
      result.value = "🚨 Warning: This message might be phishing!";
    } else {
      result.value = "✅ Safe: No phishing indicators found.";
    }

    isLoading.value = false;
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
          "🔍 Phishing Email & Message Checker",
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
                        "🛡️ Paste an email or message to check for phishing:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: "Paste your email or message here...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (value) => inputText.value = value,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: Obx(
                          () => ElevatedButton(
                            onPressed: checkPhishing,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: Colors.blue.shade900,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 5,
                            ),
                            child: isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text(
                                    "🔎 Check Now",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(() => result.value.isNotEmpty
                          ? AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: result.value.contains("🚨")
                                    ? Colors.red.shade50
                                    : Colors.green.shade50,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: result.value.contains("🚨")
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                              child: FadeTransition(
                                opacity: _fadeAnimation,
                                child: Text(
                                  result.value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: result.value.contains("🚨")
                                        ? Colors.red
                                        : Colors.green.shade800,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox()),
                      const SizedBox(height: 20),
                      Divider(color: Colors.grey.shade300),
                      const SizedBox(height: 15),
                      Row(
                        children: const [
                          Icon(Icons.info_outline,
                              color: Colors.blue, size: 20),
                          SizedBox(width: 5),
                          Text(
                            "Tip: Never click links from unknown senders!",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                        ],
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
