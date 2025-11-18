import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AccountsState extends GetxController {
  final accounts = [
    AccountViewModel(
      name: "Tarjeta Oro",
      currentAmount: 12500.75,
      expirationDate: "08/27",
      lastFourNumbers: "4821",
      owner: "Luis C. Ruiz",
      type: AccountType.cash,
    ),
    AccountViewModel(
      name: "Cuenta Débito",
      currentAmount: 3540.20,
      expirationDate: "05/26",
      lastFourNumbers: "9214",
      owner: "Luis C. Ruiz",
      type: AccountType.cash,
    ),
    AccountViewModel(
      name: "Tarjeta Digital",
      currentAmount: 820.90,
      expirationDate: "12/28",
      lastFourNumbers: "1078",
      owner: "Luis C. Ruiz",
      type: AccountType.cash,
    ),
  ].obs;

  // Controladores del formulario
  final nameCtrl = TextEditingController();
  final numberCtrl = TextEditingController();
  final expCtrl = TextEditingController();
  final ownerCtrl = TextEditingController();
  final amountCtrl = TextEditingController();

  void addAccount() {
    final newAccount = AccountViewModel(
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
