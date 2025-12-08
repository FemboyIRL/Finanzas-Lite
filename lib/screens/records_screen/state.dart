import 'package:finanzas_lite/models/transactions/transactions_view_model.dart';
import 'package:finanzas_lite/utils/supabase.dart';
import 'package:get/get.dart';

class RecordsState extends GetxController {
  final transactions = <TransactionViewModel>[];
  final supabase = SupabaseHelper();

  @override
  void onInit() async {
    super.onInit();
    await supabase.init();

    transactions.addAll(await supabase.fetchTransactions());

    update();
  }

  final searchValue = "".obs;

  void onSearchUpdated(final String newValue) {
    searchValue.value = newValue;
  }

  List<TransactionViewModel> filteredOperations() {
    // Falta agregar otros campos de busqueda, ej: por fecha, por descripcion
    return transactions.where((item) {
      final query = searchValue.value.toLowerCase();

      final searchableText = [
        item.account,
        item.category,
        item.description,
        item.amount.toString(),
      ].join(' ').toLowerCase();

      return searchableText.contains(query);
    }).toList();
  }
}
