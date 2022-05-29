import 'package:app_30_car_service_app/models/vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import '../../custom_utils/function_response.dart';
import '../constants/firebase_constants.dart';
import '../custom_utils/general_helper.dart';
import '../custom_utils/google_maps_helper.dart';
import '../models/app_user.dart';
import '../models/service_request.dart';
import '../models/vehicle_service.dart';
import '../service_locator.dart';
import 'profile_store.dart';

part 'book_service_store.g.dart';

class BookServiceStore = _BookServiceStore with _$BookServiceStore;

abstract class _BookServiceStore with Store {
  _BookServiceStore(this._profileScreenStore);
  final ProfileStore _profileScreenStore;

  @observable
  bool isLoadingOrders = false;

  @observable
  DateTime bookingTime = DateTime.now();

  @observable
  VehicleService? vehicleService;

  @observable
  ObservableList<ServiceRequest> serviceRequestList =
      ObservableList<ServiceRequest>.of([]);

  @action
  void setBookingTime(DateTime newDateTime) {
    bookingTime = newDateTime;
  }

  @action
  void setVehicleService(VehicleService newVehicleService) {
    vehicleService = newVehicleService;
  }

  @action
  Future<FunctionResponse> createServiceRequest(
      DateTime date, VehicleService vehicleService, bool isMobile) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    try {
      fResponse = await _profileScreenStore.loadProfile();
      fResponse.printResponse();
      if (fResponse.success) {
        AppUser currentUser = _profileScreenStore.currentUser;

        ServiceRequest newServiceRequest = ServiceRequest(
          id: '',
          userId: currentUser.id,
          shopId: vehicleService.shopId,
          paymentMethod: PaymentMethod.cash,
          dateTime: date,
          vehicleService: vehicleService,
          isMobile: isMobile,
          serviceRequestStatus: ServiceRequestStatus.idle,
          userLocation: currentUser.userLatLng,
          shopLocation: vehicleService.shopLocation,
        );
        final DocumentReference fbServiceRequest =
            await firestoreOrdersCollection.add({
          'userId': currentUser.id,
          'shopId': vehicleService.shopId,
          'paymentMethod': PaymentMethod.cash.getName(),
          'dateTime': date.toIso8601String(),
          'vehicleService': {
            'id': vehicleService.id,
            'coverImage': vehicleService.coverImage,
            'shopName': vehicleService.shopName,
            'shopId': vehicleService.shopId,
            'serviceName': vehicleService.serviceName,
            'description': vehicleService.description,
            'serviceType': vehicleService.serviceType.getName(),
            'vehicleType': vehicleService.vehicleType.getName(),
            'rating': vehicleService.rating,
            'cost': vehicleService.cost,
            'address': vehicleService.address,
            'distance': vehicleService.distance,
            'shopLocation': GeoPoint(vehicleService.shopLocation.latitude,
                vehicleService.shopLocation.longitude),
          },
          'isMobile': isMobile,
          'serviceRequestStatus': ServiceRequestStatus.idle.getName(),
          'userLocation': GeoPoint(currentUser.userLatLng.latitude,
              currentUser.userLatLng.longitude),
          'shopLocation': GeoPoint(vehicleService.shopLocation.latitude,
              vehicleService.shopLocation.longitude),
        });
        newServiceRequest.id = fbServiceRequest.id;
        serviceRequestList.add(newServiceRequest);
        fResponse.passed(message: 'Request sent successfully');
      } else {
        fResponse.failed(message: 'Current User not found');
      }
    } catch (e) {
      fResponse.failed(message: 'Error booking Service : $e');
    }
    return fResponse;
  }

  @action
  Future<void> loadAllServiceRequests() async {
    isLoadingOrders = true;

    try {
      if (firebaseAuth.currentUser?.uid == null) {
        return;
      }

      serviceRequestList.clear();

      await firestoreOrdersCollection.get().then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          print(' total orders found : ${querySnapshot.docs.length}');
          if (doc['userId'] == firebaseAuth.currentUser!.uid) {
            print('id : ${doc.id}');

            LatLng shopLocation = GoogleMapsHelper().defaultGoogleMapsLocation;
            LatLng userLocation = GoogleMapsHelper().defaultGoogleMapsLocation;
            if (doc['shopLocation'] == null) {
              final GeoPoint dbLocation = doc['shopLocation'] as GeoPoint;
              shopLocation = LatLng(dbLocation.latitude, dbLocation.longitude);
            }
            if (doc['userLocation'] == null) {
              final GeoPoint dbLocation = doc['userLocation'] as GeoPoint;
              userLocation = LatLng(dbLocation.latitude, dbLocation.longitude);
            }
            print(doc.data());

            serviceRequestList.add(ServiceRequest(
                id: doc.id,
                userId: doc['userId'],
                shopId: doc['shopId'],
                paymentMethod: getPaymentMethodByName(doc['paymentMethod']),
                dateTime: DateTime.parse(doc['dateTime']),
                vehicleService: VehicleService(
                  id: doc['vehicleService']['id'],
                  address: doc['vehicleService']['address'],
                  cost: doc['vehicleService']['cost'],
                  coverImage: doc['vehicleService']['coverImage'],
                  description: doc['vehicleService']['description'],
                  distance: doc['vehicleService']['distance'],
                  shopId: doc['vehicleService']['shopId'],
                  rating: doc['vehicleService']['rating'],
                  serviceName: doc['vehicleService']['serviceName'],
                  serviceType: getServiceTypeFromServiceName(
                      doc['vehicleService']['serviceType']),
                  shopLocation: shopLocation,
                  shopName: doc['vehicleService']['shopName'],
                  vehicleType: getVehicleTypeFromVehicleName(
                      doc['vehicleService']['vehicleType']),
                ),
                isMobile: doc['isMobile'],
                serviceRequestStatus:
                    getServiceRequestStatusByName(doc['serviceRequestStatus']),
                userLocation: userLocation,
                shopLocation: shopLocation));
            print(serviceRequestList.length);
          }
        }
      });
    } catch (e) {
      print('Error loading all services : $e');
    }

    isLoadingOrders = false;
  }

  Future<FunctionResponse> updateRequsetStatus(
      String serviceRequestId, ServiceRequestStatus newValue) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      await firestoreOrdersCollection
          .doc(serviceRequestId)
          .update({'serviceRequestStatus': newValue.getName()});
      ServiceRequest? updatebleRequest = serviceRequestList.firstWhere(
          (element) => element.id == serviceRequestId,
          orElse: null);
      if (updatebleRequest != null) {
        updatebleRequest = ServiceRequest(
            id: updatebleRequest.id,
            userId: updatebleRequest.userId,
            shopId: updatebleRequest.shopId,
            paymentMethod: updatebleRequest.paymentMethod,
            dateTime: updatebleRequest.dateTime,
            vehicleService: updatebleRequest.vehicleService,
            isMobile: updatebleRequest.isMobile,
            serviceRequestStatus: newValue,
            userLocation: updatebleRequest.userLocation,
            shopLocation: updatebleRequest.shopLocation);
        fResponse.passed(message: 'Request Status Updated');
      }
    } catch (e) {
      fResponse.failed(message: 'Error Canceling Request : $e');
    }
    return fResponse;
  }
}
