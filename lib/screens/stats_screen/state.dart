import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/utils/supabase.dart';
import 'package:get/get.dart';

class StatisticsState extends GetxController {
  final List<CategoryViewModel> categories = [];
  final supabase = SupabaseHelper();

  late double total = 0;

  @override
  void onInit() async {
    super.onInit();
    await supabase.init();

    categories.addAll(await supabase.fetchCategories());
    total = categories.fold(0, (sum, c) => sum + c.currentAmountSpent);
    update();
  }
}
