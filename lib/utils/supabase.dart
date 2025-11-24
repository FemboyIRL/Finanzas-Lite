import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/models/budgets/budget_view_model.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/models/transactions/transactions_view_model.dart';
import 'package:finanzas_lite/utils/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  final supabase = Supabase.instance.client;

  late final String userId;

  SupabaseHelper();

  // Inicialización obligatoria
  Future<void> init() async {
    final userIdFromPreferences = await SharedPreferencesMethods.getUserId();

    if (userIdFromPreferences == null) {
      return;
    } else {
      userId = userIdFromPreferences;
    }
  }

  // ========================
  // FETCH BUDGETS
  // ========================
  Future<List<BudgetViewModel>> fetchBudgets() async {
    try {
      final data = await supabase
          .from('budgets')
          .select()
          .eq("user_id", userId)
          .order('created_at', ascending: false);

      return data.map((e) => BudgetViewModel.fromJson(e)).toList();
    } catch (e) {
      print("Error fetching budgets: $e");
      return [];
    }
  }

  // ========================
  // FETCH CATEGORIES
  // ========================
  Future<List<CategoryViewModel>> fetchCategories() async {
    try {
      final data = await supabase
          .from('categories')
          .select()
          .eq("user_id", userId)
          .order('created_at', ascending: true);

      print(data);

      return data.map((e) => CategoryViewModel.fromJson(e)).toList();
    } catch (e) {
      print("Error fetching categories: $e");
      return [];
    }
  }

  // ========================
  // FETCH ACCOUNTS
  // ========================
  Future<List<AccountViewModel>> fetchAccounts() async {
    try {
      final data = await supabase
          .from('accounts')
          .select()
          .eq("user_id", userId)
          .order('created_at', ascending: false);

      return data.map((e) => AccountViewModel.fromJson(e)).toList();
    } catch (e) {
      print("Error fetching accounts: $e");
      return [];
    }
  }

  // ========================
  // FETCH TRANSACTIONS
  // ========================
  Future<List<TransactionViewModel>> fetchTransactions() async {
    try {
      final data = await supabase
          .from('transactions')
          .select()
          .eq("user_id", userId)
          .order('transaction_date', ascending: false);

      return data.map((e) => TransactionViewModel.fromJson(e)).toList();
    } catch (e) {
      print("Error fetching transactions: $e");
      return [];
    }
  }
}
