import 'package:finanzas_lite/components/common_scaffold.dart';
import 'package:finanzas_lite/components/numeric_keyboard.dart';
import 'package:finanzas_lite/screens/add_record_screen/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddRecordScreen extends StatelessWidget {
  const AddRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddRecordState>(
      init: AddRecordState(),
      builder: (state) => CommonScaffold(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              _topRow(state, context),
              _selectRecordType(state),
              _categorySelector(context, state),
              _amountView(state),
              _descriptionInput(),
              _dateView(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: NumericKeyboard(
                  onKeyPressed: (value) => state.onKeyPressed(value),
                  onBackspacePressed: () => state.onBackspacePressed(),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  SizedBox _dateView() {
    final now = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(now);

    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE33C3C), Color(0xFFE3823C)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.0, 0.71],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Center(
            child: Text(
              "Fecha $formattedDate",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _descriptionInput() {
    return Padding(
      padding: const EdgeInsets.only(right: 25, left: 25, bottom: 25, top: 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Descripción',
          hintStyle: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Container(
            width: 1,
            margin: const EdgeInsets.only(
              right: 25,
              left: 25,
              top: 10,
              bottom: 10,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFE3B53C),
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white30, width: 1),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE3B53C), width: 5),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
        style: const TextStyle(color: Colors.white),
        cursorColor: Color(0xFFE3B53C),
      ),
    );
  }

  Padding _amountView(AddRecordState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            IconData icon;
            Color color;

            switch (state.selectedRecordType.value) {
              case 1: // Ingreso
                icon = Icons.add;
                color = Colors.greenAccent;
                break;
              case 2: // Gasto
                icon = Icons.remove;
                color = Colors.redAccent;
                break;
              case 3: // Transferencia
                icon = Icons.sync_alt;
                color = Colors.orangeAccent;
                break;
              default:
                icon = Icons.help_outline;
                color = Colors.grey;
            }

            return Icon(icon, size: 50, color: color);
          }),
          Obx(
            () => Text(
              "\$ ${state.inputText.value}",
              style: TextStyle(fontSize: 50),
            ),
          ),
        ],
      ),
    );
  }

  Row _categorySelector(BuildContext context, AddRecordState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 25,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE33C3C), Color(0xFFE3823C)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.0, 0.71],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45),
            ),
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
            child: GestureDetector(
              onTap: () => state.onTapSelectCategory(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Text(
                      state.selectedCategory.value == null
                          ? "Categoría"
                          : state.selectedCategory.value!.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  SizedBox _selectRecordType(AddRecordState state) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          // BOTÓN 1
          Expanded(
            child: Obx(() {
              final isSelected = state.selectedRecordType.value == 1;
              return AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: isSelected ? 1.05 : 1.0,
                curve: Curves.easeOut,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [Color(0xFFFF8C42), Color(0xFFFF5B1E)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : const LinearGradient(
                            colors: [Color(0xFFE33C3C), Color(0xFFE3823C)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [0.0, 0.71],
                          ),
                    borderRadius: BorderRadius.circular(isSelected ? 8 : 0),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: const Color(0xFFFF5B1E).withOpacity(0.6),
                              blurRadius: 12,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => state.changeSelectedRecordType(1),
                      child: SizedBox(
                        height: 45,
                        child: Center(
                          child: Text(
                            "INGRESO",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: isSelected ? 16 : 15,
                              letterSpacing: isSelected ? 0.5 : 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),

          // BOTÓN 2
          Expanded(
            child: Obx(() {
              final isSelected = state.selectedRecordType.value == 2;
              return AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: isSelected ? 1.05 : 1.0,
                curve: Curves.easeOut,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [Color(0xFFFF8C42), Color(0xFFFF5B1E)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : const LinearGradient(
                            colors: [Color(0xFFE33C3C), Color(0xFFE3823C)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [0.0, 0.71],
                          ),
                    borderRadius: BorderRadius.circular(isSelected ? 8 : 0),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: const Color(0xFFFF5B1E).withOpacity(0.6),
                              blurRadius: 12,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => state.changeSelectedRecordType(2),
                      child: SizedBox(
                        height: 45,
                        child: Center(
                          child: Text(
                            "GASTO",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: isSelected ? 16 : 15,
                              letterSpacing: isSelected ? 0.5 : 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),

          // BOTÓN 3
          Expanded(
            child: Obx(() {
              final isSelected = state.selectedRecordType.value == 3;
              return AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: isSelected ? 1.05 : 1.0,
                curve: Curves.easeOut,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [Color(0xFFFF8C42), Color(0xFFFF5B1E)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : const LinearGradient(
                            colors: [Color(0xFFE33C3C), Color(0xFFE3823C)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [0.0, 0.71],
                          ),
                    borderRadius: BorderRadius.circular(isSelected ? 8 : 0),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: const Color(0xFFFF5B1E).withOpacity(0.6),
                              blurRadius: 12,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => state.changeSelectedRecordType(3),
                      child: SizedBox(
                        height: 45,
                        child: Center(
                          child: Text(
                            "TRANSFERENCIA",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: isSelected ? 16 : 15,
                              letterSpacing: isSelected ? 0.5 : 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _topRow(AddRecordState state, BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          top: 60,
          bottom: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Botón cerrar
            GestureDetector(
              onTap: () => state.onGoBack(),
              child: const Icon(Icons.close, color: Colors.white),
            ),

            // Cuenta origen (solo para tipo 3)
            if (state.selectedRecordType.value == 3)
              Expanded(
                child: GestureDetector(
                  onTap: () => state.onTapSelectAccount(context, 2),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            state.selectedFromAccount.value == null
                                ? "Desde Cuenta"
                                : state.selectedFromAccount.value!.name,
                            style: const TextStyle(
                              color: Color(0xFFE3B53C),
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFFE3B53C),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              const Spacer(), // Espacio flexible cuando no hay cuenta origen
            // Cuenta destino
            Expanded(
              child: GestureDetector(
                onTap: () => state.onTapSelectAccount(context, 1),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          state.selectedAccount.value == null
                              ? "${state.selectedRecordType.value == 3 ? "A " : ""}Cuenta"
                              : state.selectedAccount.value!.name,
                          style: const TextStyle(
                            color: Color(0xFFE3B53C),
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFFE3B53C),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
