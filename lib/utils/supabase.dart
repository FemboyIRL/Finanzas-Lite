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

  Future<List<BudgetViewModel>> fetchBudgets() async {
    try {
      print('=== STARTING BUDGET FETCH ===');

      final data = await supabase
          .from("budgets")
          .select("""
          *,
          budget_categories (
            category_id,
            categories (*)
          ),
          budget_accounts (
            account_id,
            accounts (*)
          )
        """)
          .eq("user_id", userId)
          .order("created_at", ascending: false);

      final budgets = <BudgetViewModel>[];

      for (var i = 0; i < data.length; i++) {
        try {
          final budget = BudgetViewModel.fromJson(data[i]);
          budgets.add(budget);
        } catch (e, stackTrace) {
          continue;
        }
      }

      print('\n=== FETCHING TRANSACTIONS FOR BUDGETS ===');

      for (final budget in budgets) {
        try {
          final categoryIds = budget.categories.map((c) => c.id).toList();
          final accountIds = budget.accounts.map((a) => a.id).toList();

          if (categoryIds.isEmpty || accountIds.isEmpty) {
            budget.transactions = [];
            budget.currentAmountSpent = 0;
            continue;
          }

          final txData = await supabase
              .from("transactions")
              .select("""
              *,
              categories:category_id (*),
              accounts:account_id (*)
            """)
              .inFilter("category_id", categoryIds)
              .inFilter("account_id", accountIds)
              .order("transaction_date", ascending: false);

          final transactions = <TransactionViewModel>[];

          for (var txJson in txData) {
            final transaction = TransactionViewModel.fromJson(txJson);
            transactions.add(transaction);
          }

          budget.transactions = transactions;
          budget.recalculateAmountSpent();
        } catch (e) {
          budget.transactions = [];
          budget.currentAmountSpent = 0;
        }
      }

      print('\n=== BUDGET FETCH COMPLETE ===');
      print('Total budgets loaded: ${budgets.length}');

      return budgets;
    } catch (e, stackTrace) {
      print("=== ERROR IN fetchBudgets ===");
      print("Error: $e");
      print("Stack trace: $stackTrace");
      return [];
    }
  }

  // Delete Budget

  Future<void> deleteBudget(String id) async {
    try {
      await supabase.from("budgets").delete().eq("id", id);
    } catch (e) {
      print("error deleting budget $e");
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
          .select("""
          *,
          categories:category_id (*),
          accounts:account_id (*),
          from_accounts:from_account_id (*),
          to_accounts:to_account_id (*)
        """)
          .eq("user_id", userId)
          .order('transaction_date', ascending: false);

      return data.map((e) => TransactionViewModel.fromJson(e)).toList();
    } catch (e) {
      print("Error fetching transactions: $e");
      return [];
    }
  }
}
