import 'package:finanzas_lite/components/overlay.dart';
import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/overlays/select_accounts/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/state_manager.dart';

class SelectAccountsOverlay extends StatelessWidget {
  final Function(List<AccountViewModel>) onSave;
  final List<AccountViewModel> accounts;

  const SelectAccountsOverlay({
    super.key,
    required this.accounts,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectAccountsState>(
      init: SelectAccountsState(),
      builder: (state) => FullScreenOverlay(
        title: "Seleccionar Cuentas",
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: accounts
                    .map((acc) => _buildAccountEntry(acc, state))
                    .toList(),
              ),
            ),

            const SizedBox(height: 25),

            // Botón Guardar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  onSave(state.selected);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A66FF),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Guardar",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildAccountEntry(
    AccountViewModel account,
    SelectAccountsState state,
  ) {
    final selected = state.isSelected(account);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () => state.toggle(account),
        child: Container(
          width: double.infinity,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Icono + nombre
              if (selected)
                const Icon(
                  Icons.check_circle,
                  color: Colors.greenAccent,
                  size: 28,
                )
              else
                const Icon(
                  Icons.circle_outlined,
                  color: Colors.white54,
                  size: 28,
                ),
              SizedBox(width: 20),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(account.type.icon),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        account.name,
                        style: const TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
