import 'package:get/get.dart';

class MailSmsCheckerController extends GetxController {
  var inputText = ''.obs;
  var result = ''.obs;
  var isLoading = false.obs;

  void checkPhishing() async {
    if (inputText.value.isEmpty) {
      result.value = "Please enter a message or email to check.";
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // Simulate analysis

    // Basic keyword-based phishing detection (you can replace with ML model)
    List<String> phishingKeywords = [
      "urgent",
      "verify your account",
      "click this link",
      "free gift",
      "update payment",
      "bank alert",
      "security threat",
      "reset password"
    ];

    bool isPhishing = phishingKeywords.any((keyword) =>
        inputText.value.toLowerCase().contains(keyword.toLowerCase()));

    result.value = isPhishing
        ? "🚨 This message may be a phishing attempt!"
        : "✅ This message seems safe.";
    isLoading.value = false;
  }
}
