import 'dart:ui';
import 'package:finanzas_lite/screens/accounts_screen/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AddAccountCard extends StatelessWidget {
  AddAccountCard({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountsState>(
      builder: (state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1.2,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 22),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      "Agregar Cuenta",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE3B53C),
                      ),
                    ),

                    const SizedBox(height: 25),

                    _input(
                      controller: state.nameCtrl,
                      label: "Nombre de la cuenta",
                    ),

                    const SizedBox(height: 15),

                    _input(
                      controller: state.numberCtrl,
                      label: "Últimos 4 dígitos",
                      maxLength: 4,
                      keyboard: TextInputType.number,
                      validator: (v) => v != null && v.length == 4
                          ? null
                          : "Debe tener 4 dígitos",
                    ),

                    const SizedBox(height: 15),

                    _input(
                      controller: state.expCtrl,
                      label: "Fecha de expiración (MM/AA)",
                    ),

                    const SizedBox(height: 15),

                    _input(controller: state.ownerCtrl, label: "Propietario"),

                    const SizedBox(height: 15),

                    _input(
                      controller: state.amountCtrl,
                      label: "Monto inicial",
                      keyboard: TextInputType.number,
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: 150,
                      child: Material(
                        borderRadius: BorderRadius.circular(14),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFFF8C42), Color(0xFFFF5B1E)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                state.addAccount();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.center,
                              child: const Text(
                                "Guardar",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _input({
    required TextEditingController controller,
    required String label,
    TextInputType keyboard = TextInputType.text,
    int? maxLength,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      maxLength: maxLength,
      style: const TextStyle(color: Colors.white),
      validator:
          validator ??
          (v) => v == null || v.isEmpty ? "Campo obligatorio" : null,
      decoration: InputDecoration(
        counterText: "",
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.07),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
      ),
    );
  }
}
