import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/utils/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AccountsState extends GetxController {
  final accounts = [].obs;

  // Controladores del formulario
  final nameCtrl = TextEditingController();
  final numberCtrl = TextEditingController();
  final expCtrl = TextEditingController();
  final ownerCtrl = TextEditingController();
  final amountCtrl = TextEditingController();

  void addAccount() async {
    final userId = await SharedPreferencesMethods.getUserId();

    final newAccount = AccountViewModel(
      id: '0',
      userId: userId!,
      name: nameCtrl.text,
      currentAmount: double.tryParse(amountCtrl.text) ?? 0,
      expirationDate: expCtrl.text,
      lastFourNumbers: numberCtrl.text,
      owner: ownerCtrl.text,
      // Es necesario sacar el tipo desde el UI
      type: AccountType.cash,
    );

    accounts.add(newAccount);

    // Limpiar inputs después de guardar
    nameCtrl.clear();
    numberCtrl.clear();
    expCtrl.clear();
    ownerCtrl.clear();
    amountCtrl.clear();

    update();
  }

  final pageController = PageController();
  final currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();

    pageController.addListener(() {
      final page = pageController.page?.round() ?? 0;
      currentPage.value = page;
    });
  }

  void onGoBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
