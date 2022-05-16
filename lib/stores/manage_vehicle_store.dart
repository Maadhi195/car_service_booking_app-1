import 'package:mobx/mobx.dart';

//models
import '../custom_utils/function_response.dart';
import '../custom_utils/general_helper.dart';
import '../models/vehicle.dart';
import '../service_locator.dart';

part 'manage_vehicle_store.g.dart';

class ManageVehicleStore = _ManageVehicleStore with _$ManageVehicleStore;

abstract class _ManageVehicleStore with Store {
  @observable
  String selectedVehicleType = VehicleType.bike.getName();

  @observable
  ObservableList<String> vehicleImageList = ObservableList<String>.of([]);

  @observable
  ObservableList<Vehicle> userVehicleList = ObservableList<Vehicle>.of([]);

  @action
  void changeSelectedVehicleType(String newVehicleType) {
    selectedVehicleType = newVehicleType;
  }

  @action
  void addNewVehicleImage(String newImage) {
    vehicleImageList.add(newImage);
  }

  @action
  void removeVehicleImage(String image) {
    vehicleImageList.remove(image);
  }

  @action
  Future<FunctionResponse> addNewVehicleToList(Vehicle newVehicle) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    await delayFunction();
    newVehicle.id = DateTime.now().microsecondsSinceEpoch.toString();
    newVehicle.vehicleType = getVehicleTypeFromVehicleName(selectedVehicleType);
    newVehicle.vehicleImages = vehicleImageList;

    try {
      userVehicleList.add(newVehicle);
      fResponse.passed(message: 'Successfully added new vehicle');
    } catch (e) {
      fResponse.failed(message: 'Unable to add new Vehicle : $e');
    }
    print('Model Name ${newVehicle.vehicleModel}');
    print('Comapny ${newVehicle.vehicleCompany}');
    print('Description ${newVehicle.vehicleDescription}');
    print('Vehicle Type ${newVehicle.vehicleType.getName()}');
    print('total images ${newVehicle.vehicleImages.length}');

    print('total vehicles : ${userVehicleList.length}');
    vehicleImageList.clear();
    return fResponse;
  }
}
