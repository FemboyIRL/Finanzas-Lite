import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:get/get.dart';

class SelectAccountsState extends GetxController {
  List<AccountViewModel> selected = [];

  void toggle(AccountViewModel cat) {
    if (selected.contains(cat)) {
      selected.remove(cat);
    } else {
      selected.add(cat);
    }
    update();
  }

  bool isSelected(AccountViewModel cat) {
    return selected.contains(cat);
  }
}
