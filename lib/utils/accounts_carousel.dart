import 'package:finanzas_lite/components/card_widget.dart';
import 'package:finanzas_lite/screens/accounts_screen/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class AccountsCarousel extends StatelessWidget {
  final AccountsState state;

  const AccountsCarousel({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 240,
          child: PageView.builder(
            controller: state.pageController,
            itemCount: state.accounts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CardWidget(account: state.accounts[index]),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(state.accounts.length, (index) {
              bool active = index == state.currentPage.value;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: active ? 12 : 8,
                height: active ? 12 : 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: active ? Color(0xffE3B53C) : Colors.white30,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
