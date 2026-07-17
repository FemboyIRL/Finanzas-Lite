import 'package:finanzas_lite/components/common_scaffold.dart';
import 'package:finanzas_lite/screens/login_screen/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginEmailScreen extends StatelessWidget {
  const LoginEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginEmailState>(
      init: LoginEmailState(),
      builder: (state) => CommonScaffold(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: [
                    const Text(
                      'Ingresa tu correo',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    Center(
                      child: TextField(
                        controller: state.emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Correo electrónico',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state.continueWithEmail,
                        child: const Text('Continuar'),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
