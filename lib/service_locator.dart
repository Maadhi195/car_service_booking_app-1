import 'package:get_it/get_it.dart';

//UI and Theme
import 'theme/my_app_colors.dart';

//Custom Utilities
import 'custom_utils/function_response.dart';
import 'custom_utils/connectivity_helper.dart';
import 'custom_utils/custom_alerts.dart';
import 'custom_utils/custom_validator.dart';
import 'custom_utils/form_helper.dart';
import 'custom_utils/image_helper.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  //Custom Utilities
  getIt.registerFactory(() => FunctionResponse());
  getIt.registerFactory(() => CustomAlerts());
  getIt.registerFactory(() => CustomValidator());
  getIt.registerFactory(() => CustomFormHelper());
  getIt.registerFactory(() => CustomImageHelper());
  getIt.registerFactory(() => ConnectivityHelper());

  //UI and Theme
  getIt.registerFactory(() => AppColors());

  //Services
  // getIt.registerSingletonAsync<SharedPreferences>(
  //   () => LocalModule.provideSharedPreferences(),
  // );

  //Shared Preferences Helpers
}
