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
    final query = searchValue.value.toLowerCase();

    return transactions.where((item) {
      final searchableText = [
        item.account.name, // nombre de la cuenta
        item.category.name, // nombre de la categoría
        item.description,
        item.amount.toString(),
        item.date.toIso8601String(), // fecha en texto para búsquedas
        item.type.name, // income / expense
        item.fromAccount?.name ?? '',
        item.toAccount?.name ?? '',
      ].join(' ').toLowerCase();

      return searchableText.contains(query);
    }).toList();
  }
}
