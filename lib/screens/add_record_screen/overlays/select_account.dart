import 'package:finanzas_lite/components/overlay.dart';
import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SelectAccountOverlay extends StatelessWidget {
  final List<AccountViewModel> accounts;
  final VoidCallback? onAddAccount;
  final Function(AccountViewModel) onSelectAccount;

  const SelectAccountOverlay({
    super.key,
    required this.accounts,
    this.onAddAccount,
    required this.onSelectAccount,
  });

  @override
  Widget build(BuildContext context) {
    return FullScreenOverlay(
      title: "Seleccionar Cuenta",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lista de cuentas existentes
          ...accounts.map((acc) => _buildAccountEntry(acc)).toList(),

          const SizedBox(height: 10),

          _buildAddNewAccount(),
        ],
      ),
    );
  }

  Padding _buildAccountEntry(AccountViewModel account) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          onSelectAccount(account);
          Navigator.of(Get.context!).pop();
        },
        child: Row(
          children: [
            Container(
              height: 50,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  account.type.icon,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              account.name,
              style: const TextStyle(fontSize: 19, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNewAccount() {
    return GestureDetector(
      onTap: onAddAccount ?? () => Get.back(),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.add, size: 30, color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "Agregar nueva cuenta",
            style: const TextStyle(fontSize: 19, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
