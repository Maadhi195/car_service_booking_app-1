import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

//models
import '../constants/firebase_constants.dart';
import '../custom_utils/function_response.dart';
import '../custom_utils/general_helper.dart';
import '../custom_utils/google_maps_helper.dart';
import '../models/vehicle.dart';
import '../models/vehicle_service.dart';
import '../resources/app_images.dart';
import '../service_locator.dart';
import 'profile_store.dart';

part 'available_shops_store.g.dart';

class AvailableShopStore = _AvailableShopStore with _$AvailableShopStore;

abstract class _AvailableShopStore with Store {
  _AvailableShopStore(this._profileStore);

  final ProfileStore _profileStore;

  @observable
  Vehicle? selectedVehicle;
  @observable
  ServiceType? selectedServiceType;
  @observable
  bool isLoadingServices = false;

  @observable
  ObservableList<VehicleService> availableServicesList =
      ObservableList<VehicleService>.of([
    // VehicleService(
    //   id: '1',
    //   coverImage: carTyreChangeServiceImage,
    //   shopName: 'Abc Shop',
    //   description: 'description',
    //   serviceType: ServiceType.tyreChange,
    //   rating: 4,
    //   distance: 3,
    //   cost: 1200,
    //   address: '5th downing street, startwars avenue',
    // ),
    // VehicleService(
    //   id: '2',
    //   coverImage: carTyreChangeServiceImage,
    //   shopName: 'A service Shop',
    //   description: 'description 112o3u',
    //   serviceType: ServiceType.tyreChange,
    //   rating: 3,
    //   distance: 19,
    //   cost: 1100,
    //   address: '5th downing street, startwars avenue',
    // ),
  ]);

  void updateSelectedServiceType(ServiceType newType) {
    selectedServiceType = newType;
    print('slected service Type : ${newType.getName()}');
  }

  void updateSelectedVehicle(Vehicle newVehicle) {
    selectedVehicle = newVehicle;
    print('selected vehicle : ${newVehicle.vehicleModel}');
  }

  Future<void> loadAvailableServices(LatLng currentUserLocation) async {
    isLoadingServices = true;
    await _profileStore.loadProfile();

    log('current user long : ${_profileStore.currentUser.userLatLng.latitude}');
    try {
      if (firebaseAuth.currentUser?.uid == null) {
        return;
      }
      availableServicesList.clear();
      await firestoreServicesCollection
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc['vehicleType'] == selectedVehicle?.vehicleType.getName() &&
              doc['serviceType'] == selectedServiceType?.getName()) {
            LatLng shopLocation;
            final GeoPoint dbLocation = doc['shopLocation'] as GeoPoint;
            shopLocation = LatLng(
              dbLocation.latitude,
              dbLocation.longitude,
            );
            log('id : ${doc.id}');

            log(shopLocation.latitude.toString());
            log(shopLocation.longitude.toString());

            log('after finalizing location');
            availableServicesList.add(VehicleService(
              id: doc.id,
              shopId: doc['shopId'],
              coverImage: doc['coverImage'],
              shopName: doc['shopName'],
              serviceName: doc['serviceName'],
              description: doc['description'],
              serviceType: getServiceTypeFromServiceName(doc['serviceType']),
              vehicleType: getVehicleTypeFromVehicleName(doc['vehicleType']),
              rating: doc['rating'],
              cost: doc['cost'],
              address: doc['address'],
              distance: GoogleMapsHelper().calculateDistanceBetweenGeoPoints(
                shopLocation.latitude,
                shopLocation.longitude,
                _profileStore.currentUser.userLatLng.latitude,
                _profileStore.currentUser.userLatLng.longitude,
              ),
              shopLocation: shopLocation,
            ));
            availableServicesList
                .sort((a, b) => a.distance.compareTo(b.distance));
          } else {}
        }
      });
    } catch (e) {
      print('Error Loading Available Services : $e');
    }
    isLoadingServices = false;
  }
}
