import 'package:finanzas_lite/components/common_scaffold.dart';
import 'package:finanzas_lite/screens/register_screen/state.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterState>(
      init: RegisterState(),
      builder: (state) => CommonScaffold(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text(
                  'Crea un PIN de 6 dígitos',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 25),

                TextField(
                  controller: state.pinController,
                  obscureText: true,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'PIN',
                    labelStyle: TextStyle(color: Colors.white),
                    counterText: '',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.createAccount,
                    child: const Text('Crear cuenta'),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
