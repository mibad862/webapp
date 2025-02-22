import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webapp/views/about.dart';
import 'package:webapp/views/contact_us.dart';
import 'package:webapp/views/homescreen.dart';
import 'package:webapp/views/tools.dart';

class HomeController extends GetxController {
  var url = ''.obs;
  var result = ''.obs;
  var isLoading = false.obs;

  
  // Track the current page to display in the body
  final RxInt currentPageIndex = 0.obs;



  void checkPhishing() async {
    isLoading.value = true;

    // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;
    result.value = url.value.contains('phish') ? 'Phishing Website' : 'Safe Website';
  }
}
