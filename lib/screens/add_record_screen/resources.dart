import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/utils/supabase.dart';
import 'package:get/get.dart';

class AddRecordResources extends GetxController {
  final supabase = SupabaseHelper();

  final accounts = <AccountViewModel>[].obs;
  final categories = <CategoryViewModel>[];
  var selectedRecordType = 1.obs;
  var selectedFromAccount = Rxn<AccountViewModel>();
  var selectedAccount = Rxn<AccountViewModel>();
  var selectedCategory = Rxn<CategoryViewModel>();
  var inputText = "0".obs;
}
