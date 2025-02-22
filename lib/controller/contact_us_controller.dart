import 'package:get/get.dart';

class ContactUsController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var message = ''.obs;
  var isLoading = false.obs;

  void submitForm() {
    isLoading.value = true;

    if (name.value.isNotEmpty &&
        email.value.isNotEmpty &&
        message.value.isNotEmpty) {
      Get.snackbar('Success', 'Message sent successfully!',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Error', 'Please fill all fields',
          snackPosition: SnackPosition.BOTTOM);
    }
    isLoading.value = false;
  }
}
