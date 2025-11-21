import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:get/get.dart';

class SelectCategoriesState extends GetxController {
  List<CategoryViewModel> selected = [];

  void toggle(CategoryViewModel cat) {
    if (selected.contains(cat)) {
      selected.remove(cat);
    } else {
      selected.add(cat);
    }
    update();
  }

  bool isSelected(CategoryViewModel cat) {
    return selected.contains(cat);
  }
}
