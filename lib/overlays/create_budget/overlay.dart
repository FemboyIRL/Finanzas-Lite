import 'package:finanzas_lite/components/overlay.dart';
import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/overlays/create_budget/state.dart';
import 'package:finanzas_lite/overlays/select_accounts/overlay.dart';
import 'package:finanzas_lite/overlays/select_categories/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CreateBudgetOverlay extends StatelessWidget {
  final List<CategoryViewModel> categories;
  final List<AccountViewModel> accounts;
  const CreateBudgetOverlay({
    super.key,
    required this.categories,
    required this.accounts,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateBudgetState>(
      init: CreateBudgetState(),
      builder: (state) => FullScreenOverlay(
        title: "Crear Presupuesto",
        child: Column(
          children: [
            Text(
              "Presupuesto Mensual",
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
            ),
            _amountView(state),

            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _nameEntry(state),
                      Divider(
                        thickness: 2,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      _colorEntry(state, context),
                      Divider(
                        thickness: 2,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      _buildIconEntry(
                        context,
                        "Cuenta",
                        accounts[0].type.icon,
                        (context) => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SelectAccountsOverlay(
                              accounts: accounts,
                              onSave:
                                  (List<AccountViewModel> selectedAccounts) =>
                                      state.pickAccounts(selectedAccounts),
                            ),
                          ),
                        ),
                        state.selectedAccounts.length,
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      _buildIconEntry(
                        context,
                        "Categorías",
                        categories[0].icon,
                        (context) => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SelectCategoriesOverlay(
                                categories: categories,
                                onSave:
                                    (
                                      List<CategoryViewModel>
                                      selectedCategories,
                                    ) => state.pickCategories(
                                      selectedCategories,
                                    ),
                              ),
                            ),
                          ),
                        },
                        state.selectedCategories.length,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
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
                  "Crear Presupuesto",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorEntry(CreateBudgetState state, BuildContext context) {
    return GestureDetector(
      onTap: () => state.onTapColor(context),
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Color",
                style: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
              Obx(
                () => Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: state.selectedColor.value,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _nameEntry(CreateBudgetState state) {
    return GestureDetector(
      onTap: () => state.editName(),
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nombre",
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
            ),
            Obx(
              () =>
                  Text(state.budgetName.value, style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Container _amountView(CreateBudgetState state) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => state.editAmount(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Obx(
              () => Text(
                "\$${state.budgetAmount.value.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 50),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconEntry(
    BuildContext context,
    String name,
    String icon,
    Function(BuildContext) onTap,
    int numberSelected,
  ) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(color: Colors.white.withOpacity(0.5)),
                ),
                Text(
                  "${numberSelected} seleccionadas",
                  style: TextStyle(fontSize: 18),
                ),
                Divider(thickness: 2, color: Colors.white.withOpacity(0.3)),
              ],
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  icon,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
