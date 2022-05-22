import 'package:get_it/get_it.dart';

//UI and Theme
import 'custom_utils/google_maps_helper.dart';
import 'stores/auth_store.dart';
import 'stores/available_shops_store.dart';
import 'stores/book_service_store.dart';
import 'stores/manage_vehicle_store.dart';
import 'theme/my_app_colors.dart';

//Custom Utilities
import 'custom_utils/function_response.dart';
import 'custom_utils/connectivity_helper.dart';
import 'custom_utils/custom_alerts.dart';
import 'custom_utils/custom_validator.dart';
import 'custom_utils/custom_form_helper.dart';
import 'custom_utils/image_helper.dart';

//Stores
import 'stores/user_profile_screen_store.dart';
import 'stores/home_screen_store.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  //Custom Utilities
  getIt.registerFactory(() => FunctionResponse());
  getIt.registerFactory(() => CustomAlerts());
  getIt.registerFactory(() => CustomValidator());
  getIt.registerFactory(() => CustomImageHelper());
  getIt.registerFactory(() => ConnectivityHelper());
  getIt.registerFactory(() => CustomFormHelper());
  getIt.registerFactory(() => GoogleMapsHelper());

  //UI and Theme
  getIt.registerFactory(() => AppColors());

  //Services
  // getIt.registerSingletonAsync<SharedPreferences>(
  //   () => LocalModule.provideSharedPreferences(),
  // );

  //Stores
  getIt.registerSingleton(AuthStore(
    getIt<CustomImageHelper>(),
  ));
  getIt.registerSingleton(UserProfileScreenStore());
  getIt.registerSingleton(HomeScreenStore(
    getIt<UserProfileScreenStore>(),
  ));
  getIt.registerSingleton(ManageVehicleStore(
    getIt<UserProfileScreenStore>(),
    getIt<CustomImageHelper>(),
  ));
  getIt.registerSingleton(AvailableShopStore());
  getIt.registerSingleton(BookServiceStore(
    getIt<UserProfileScreenStore>(),
  ));
}
