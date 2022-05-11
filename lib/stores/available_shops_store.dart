import 'package:mobx/mobx.dart';

//models
import '../custom_utils/function_response.dart';
import '../custom_utils/general_helper.dart';
import '../models/vehicle.dart';
import '../models/vehicle_service.dart';
import '../resources/app_images.dart';
import '../service_locator.dart';

part 'available_shops_store.g.dart';

class AvailableShopeStore = _AvailableShopeStore with _$AvailableShopeStore;

abstract class _AvailableShopeStore with Store {
  @observable
  ObservableList<VehicleService> availableShopsList =
      ObservableList<VehicleService>.of([
    VehicleService(
      id: '1',
      coverImage: carTyreChangeServiceImage,
      shopName: 'Abc Shop',
      description: 'description',
      serviceType: ServiceType.tyreChange,
      rating: 4,
      distance: 3,
      cost: 1200,
      address: '5th downing street, startwars avenue',
    ),
    VehicleService(
      id: '2',
      coverImage: carTyreChangeServiceImage,
      shopName: 'A service Shop',
      description: 'description 112o3u',
      serviceType: ServiceType.tyreChange,
      rating: 3,
      distance: 19,
      cost: 1100,
      address: '5th downing street, startwars avenue',
    ),
  ]);
}
