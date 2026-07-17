import 'package:finanzas_lite/components/common_scaffold.dart';
import 'package:finanzas_lite/components/navbar.dart';
import 'package:finanzas_lite/components/transactions_list.dart';
import 'package:finanzas_lite/screens/add_record_screen/screen.dart';
import 'package:finanzas_lite/screens/records_screen/state.dart';
import 'package:finanzas_lite/utils/delegates/header_child_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RecordsScreen extends StatelessWidget {
  const RecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecordsState>(
      init: RecordsState(),
      builder: (state) => CommonScaffold(
        bottomNavigationBar: Navbar(),
        slivers: [
          // Header superior
          SliverPadding(
            padding: const EdgeInsets.only(top: 60, left: 25, right: 25),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _topRow(),
                const SizedBox(height: 12),
                _title(context),
              ]),
            ),
          ),

          // SearchBar fija (pinned)
          _persistentSearchBar(state),

          state.transactions.isNotEmpty
              ? Obx(
                  () => SliverPadding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    sliver: TransactionsSliverList(
                      transactions: state.filteredOperations(),
                    ),
                  ),
                )
              : SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("No has registrado transacciones aún"),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _persistentSearchBar(final RecordsState state) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: HeaderChildSliverList(
        maxSize: 80,
        minSize: 80,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
          child: Material(
            color: Colors.white,
            elevation: 4,
            borderRadius: BorderRadius.circular(16),
            child: TextField(
              style: const TextStyle(color: Colors.white, fontSize: 16),
              onChanged: state.onSearchUpdated,
              decoration: InputDecoration(
                hintText: 'Buscar por fecha / descripción / cuenta / categoría',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.black,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Transacciones",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddRecordScreen(),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF6A66FF), Color(0xFF8B86FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF6A66FF).withOpacity(0.5),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.add, color: Colors.white, size: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _topRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 15,
              color: Colors.white,
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Text("2025"),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
