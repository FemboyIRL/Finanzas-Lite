import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/utils/supabase.dart';
import 'package:get/get.dart';

class SelectCategoryState extends GetxController {
  final supabase = SupabaseHelper();
  final categories = <CategoryViewModel>[];

  @override
  void onInit() async {
    super.onInit();
    await supabase.init();
    await fetchData();

    update();
  }

  Future<void> fetchData() async {
    categories.addAll(await supabase.fetchCategories());
  }
}
