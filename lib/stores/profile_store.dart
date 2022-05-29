import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
//Models
import '../constants/firebase_constants.dart';
import '../custom_utils/google_maps_helper.dart';
import '../custom_utils/image_helper.dart';
import '../models/app_user.dart';
//Custom Utilities
import '../../custom_utils/general_helper.dart';
import '../../custom_utils/function_response.dart';
import '../service_locator.dart';
part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  _ProfileStore(this._customImageHelper);

  final CustomImageHelper _customImageHelper;

  @observable
  bool isLoading = false;

  @observable
  AppUser currentUser = AppUser(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    userImage: '',
    userBio: '',
    userLatLng: GoogleMapsHelper().defaultGoogleMapsLocation,
  );

  @action
  void toggleIsLoading() {
    isLoading = !isLoading;
  }

  @action
  void updateUserAddress(String address) {
    currentUser = AppUser(
      id: currentUser.id,
      name: currentUser.name,
      email: currentUser.email,
      password: currentUser.password,
      address: address,
      userImage: currentUser.userImage,
      userBio: currentUser.userBio,
      userLatLng: currentUser.userLatLng,
    );
  }

  @action
  void updateUserName(String name) {
    currentUser = AppUser(
      id: currentUser.id,
      name: name,
      email: currentUser.email,
      password: currentUser.password,
      address: currentUser.address,
      userImage: currentUser.userImage,
      userBio: currentUser.userBio,
      userLatLng: currentUser.userLatLng,
    );
  }

  @action
  void updateUserImage(String image) {
    currentUser = AppUser(
      id: currentUser.id,
      name: currentUser.name,
      email: currentUser.email,
      password: currentUser.password,
      address: currentUser.address,
      userImage: image,
      userBio: currentUser.userBio,
      userLatLng: currentUser.userLatLng,
    );
  }

  @action
  void updateUserLocation(LatLng location) {
    currentUser = AppUser(
      id: currentUser.id,
      name: currentUser.name,
      email: currentUser.email,
      password: currentUser.password,
      address: currentUser.address,
      userImage: currentUser.userImage,
      userBio: currentUser.userBio,
      userLatLng: location,
    );
  }

  @action
  void updateUserBio(String newBio) {
    currentUser = AppUser(
      id: currentUser.id,
      name: currentUser.name,
      email: currentUser.email,
      password: currentUser.password,
      address: currentUser.address,
      userImage: currentUser.userImage,
      userBio: newBio,
      userLatLng: currentUser.userLatLng,
    );
  }

  @action
  Future<FunctionResponse> loadProfile() async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    print('inside load profile');
    toggleIsLoading();
    try {
      final User? user = firebaseAuth.currentUser;
      if (user != null) {
        print('before query');
        DocumentSnapshot doc =
            await firestoreUsersCollection.doc(user.uid).get();
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          print('before data parse');
          print(' Data from FireBase ${data.toString()}');
          LatLng newUserLatLng = GoogleMapsHelper().defaultGoogleMapsLocation;
          if (data['userLatLng'] == null) {
            final GeoPoint? dbLocation = data['userLatLng'] as GeoPoint;
            if (dbLocation != null) {
              newUserLatLng = LatLng(dbLocation.latitude, dbLocation.longitude);
            }
          }
          print('after getting location');
          currentUser = AppUser(
            id: user.uid,
            name: data['name'],
            email: data['email'],
            password: data['password'],
            address: data['address'],
            userImage: data['userImage'],
            userBio: data['userBio'],
            userLatLng: newUserLatLng,
          );
          fResponse.passed(message: 'Profile Loaded from database');
        } else {
          fResponse.failed(message: 'data not found');
        }
      } else {
        fResponse.failed(message: 'Current user not found');
      }
    } catch (e) {
      fResponse.failed(message: 'Error loading profile : $e');
    }
    toggleIsLoading();

    return fResponse;
  }

  @action
  Future<FunctionResponse> updateProfile() async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    try {
      final User? user = firebaseAuth.currentUser;
      if (user != null) {
        fResponse = await _customImageHelper.uploadPicture(
            (currentUser.userImage), serviceShopImagesDirectory);
        if (fResponse.success) {
          updateUserImage(fResponse.data);
          log('new name : ${currentUser.name}');
          log('new address : ${currentUser.address}');
          log('new location : ${currentUser.userLatLng.latitude.toStringAsFixed(4)} ${currentUser.userLatLng.longitude.toStringAsFixed(4)}');

          await firestoreShopsCollection.doc(user.uid).update({
            'name': currentUser.name,
            'address': currentUser.address,
            'userImage': currentUser.userImage,
            'userBio': currentUser.userBio,
            'userLatLng': GeoPoint(
              currentUser.userLatLng.latitude,
              currentUser.userLatLng.longitude,
            ),
          });

          fResponse.passed(message: 'Profile Updated');
        }
      } else {
        fResponse.failed(message: 'Current user not found');
      }
    } catch (e) {
      fResponse.failed(message: 'Error updating profile : $e');
    }

    return fResponse;
  }
}
