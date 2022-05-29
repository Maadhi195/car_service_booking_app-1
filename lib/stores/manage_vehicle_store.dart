import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mobx/mobx.dart';

//models
import '../constants/firebase_constants.dart';
import '../custom_utils/function_response.dart';
import '../custom_utils/general_helper.dart';
import '../custom_utils/google_maps_helper.dart';
import '../custom_utils/image_helper.dart';
import '../models/app_user.dart';
import '../models/vehicle.dart';
import '../service_locator.dart';
import 'profile_store.dart';

part 'manage_vehicle_store.g.dart';

class ManageVehicleStore = _ManageVehicleStore with _$ManageVehicleStore;

abstract class _ManageVehicleStore with Store {
  _ManageVehicleStore(this._profileStore, this._customImageHelper);

  final ProfileStore _profileStore;
  final CustomImageHelper _customImageHelper;

  @observable
  bool isLoadingAllVehicles = false;

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
      fResponse = await _profileStore.loadProfile();
      fResponse.printResponse();

      if (fResponse.success) {
        AppUser currentUser = _profileStore.currentUser;
        List<String> newImages = [];
        for (String image in vehicleImageList) {
          fResponse = await _customImageHelper.uploadPicture(
              (image), userImagesDirectory);
          if (fResponse.success) {
            newImages.add(fResponse.data);
          }
        }
        newVehicle = Vehicle(
          id: '',
          userId: currentUser.id,
          vehicleType: getVehicleTypeFromVehicleName(selectedVehicleType),
          vehicleImages: newImages,
          vehicleCompany: newVehicle.vehicleCompany,
          vehicleDescription: newVehicle.vehicleDescription,
          vehicleModel: newVehicle.vehicleModel,
        );

        final DocumentReference dbVehicle =
            await firestoreVehiclesCollection.add({
          'userId': newVehicle.userId,
          'vehicleType': newVehicle.vehicleType.getName(),
          'vehicleImages': newVehicle.vehicleImages,
          'vehicleCompany': newVehicle.vehicleCompany,
          'vehicleDescription': newVehicle.vehicleDescription,
          'vehicleModel': newVehicle.vehicleModel,
        });
        newVehicle.id = dbVehicle.id;
        userVehicleList.add(newVehicle);
        fResponse.passed(message: 'Vehicle Added Successfull');
      } else {
        fResponse.failed(message: 'Current User not found');
      }
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

  @action
  @action
  Future<void> loadAllVehicles() async {
    isLoadingAllVehicles = true;

    try {
      if (firebaseAuth.currentUser?.uid == null) {
        return;
      }

      userVehicleList.clear();

      await firestoreVehiclesCollection
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          print(' total vehicles found : ${querySnapshot.docs.length}');
          if (doc['userId'] == firebaseAuth.currentUser!.uid) {
            print('id : ${doc.id}');
            List<String> imagesList = [];
            List<dynamic> dbImages = doc['vehicleImages'];
            print('total Images : ${dbImages.length}');

            for (var e in dbImages) {
              imagesList.add(e as String);
            }

            userVehicleList.add(Vehicle(
              id: doc.id,
              userId: doc['userId'],
              vehicleCompany: doc['vehicleCompany'],
              vehicleDescription: doc['vehicleCompany'],
              vehicleModel: doc['vehicleModel'],
              vehicleImages: imagesList,
              vehicleType: getVehicleTypeFromVehicleName(doc['vehicleType']),
            ));
          }
        }
      });
    } catch (e) {
      print('Error loading all Vehicles : $e');
    }

    isLoadingAllVehicles = false;
  }
}
