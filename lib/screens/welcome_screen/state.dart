import 'package:finanzas_lite/models/welcome_page_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeState extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final steps = <WelcomePageModel>[
    WelcomePageModel(
      icon: "assets/images/welcome1.png",
      step: 1,
      text: "Toma control de tus finanzas usando Finance Lite",
    ),
    WelcomePageModel(
      icon: "assets/images/welcome2.png",
      step: 2,
      text: "Vigila de cerca tus finanzas y alcanza tu meta de forma sencilla",
    ),
    WelcomePageModel(
      icon: "assets/images/welcome3.png",
      step: 3,
      text: "Elimina el estrés financiero y nunca más vuelvas a gastar de más",
    ),
    WelcomePageModel(
      icon: "assets/images/welcome4.png",
      step: 4,
      text: "Asegura el futuro y toma el control de tu dinero",
    ),
  ];

  void nextPage() {
    if (currentPage.value < steps.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAllNamed('/home');
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void updatePage(int index) {
    currentPage.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
