import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/utils/supabase.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SelectAccountState extends GetxController {
  final accounts = <AccountViewModel>[];
  final supabase = SupabaseHelper();

  @override
  void onInit() async {
    super.onInit();

    await supabase.init();

    accounts.addAll(await supabase.fetchAccounts());

    update();
  }
}
