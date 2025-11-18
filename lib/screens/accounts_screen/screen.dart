import 'package:finanzas_lite/components/add_account_card.dart';
import 'package:finanzas_lite/components/common_scaffold.dart';
import 'package:finanzas_lite/components/navbar.dart';
import 'package:finanzas_lite/screens/accounts_screen/state.dart';
import 'package:finanzas_lite/utils/accounts_carousel.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountsState>(
      init: AccountsState(),
      builder: (state) => CommonScaffold(
        bottomNavigationBar: Navbar(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _topRow(state, context),
                _divider(),
                _cardView(),
                _balanceView(state),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 10,
                    right: 10,
                  ),
                  child: AddAccountCard(),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Column _balanceView(AccountsState state) {
    return Column(
      children: [
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.accounts[state.currentPage.value].name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "\$${(state.accounts[state.currentPage.value].currentAmount).toStringAsFixed(2)}",
              ),
            ],
          ),
        ),
        Center(child: Text("Balance Disponible")),
      ],
    );
  }

  Padding _cardView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<AccountsState>(
        init: AccountsState(),
        builder: (state) => AccountsCarousel(state: state),
      ),
    );
  }

  Column _divider() {
    return Column(
      children: [
        Center(
          child: Text("Cuentas", style: TextStyle(color: Color(0xffE3B53C))),
        ),
        Divider(color: Colors.grey.withOpacity(0.3)),
      ],
    );
  }

  Widget _topRow(AccountsState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: SizedBox(
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => state.onGoBack(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const Text(
              "Cartera",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
