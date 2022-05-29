import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mobx/mobx.dart';

import '../constants/firebase_constants.dart';
import '../custom_utils/function_response.dart';
import '../custom_utils/google_maps_helper.dart';
import '../custom_utils/image_helper.dart';
import '../models/service_shop.dart';
import '../models/app_user.dart';
import '../service_locator.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  _AuthStore(this._customImageHelper);
  final CustomImageHelper _customImageHelper;

  @observable
  AppUser newUser = AppUser(
    id: '',
    email: '',
    address: '',
    name: '',
    password: '',
    cnic: '',
    userBio: '',
    userImage: '',
    userLatLng: GoogleMapsHelper().defaultGoogleMapsLocation,
  );

  @observable
  ServiceShop? currentUser;
  @observable
  ObservableList<ServiceShop> serviceShopeList =
      ObservableList<ServiceShop>.of([]);

  @action
  void updateUserImage(String image) {
    newUser = AppUser(
      id: newUser.id,
      name: newUser.name,
      email: newUser.email,
      password: newUser.password,
      address: newUser.address,
      userBio: newUser.userBio,
      cnic: newUser.cnic,
      userImage: image,
      userLatLng: newUser.userLatLng,
    );
  }

  @action
  void updateUserLocation(LatLng newLocation) {
    newUser = AppUser(
      id: newUser.id,
      name: newUser.name,
      email: newUser.email,
      password: newUser.password,
      address: newUser.address,
      userBio: newUser.userBio,
      cnic: newUser.cnic,
      userImage: newUser.userImage,
      userLatLng: newLocation,
    );
  }

  @action
  void updateCnic(String newCnic) {
    newUser = AppUser(
      id: newUser.id,
      name: newUser.name,
      email: newUser.email,
      password: newUser.password,
      address: newUser.address,
      userBio: newUser.userBio,
      cnic: newCnic,
      userImage: newUser.userImage,
      userLatLng: newUser.userLatLng,
    );
  }

  Future<FunctionResponse> tryLogin(String email, String password) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      fResponse.passed(message: 'Login Successful');
    } on FirebaseAuthException catch (e) {
      fResponse.failed(
          message:
              e.message ?? 'Error occurred, please check your credentials!');
    } catch (e) {
      fResponse.failed(message: 'Error logging in : $e');
    }

    return fResponse;
  }

  void resetSignupForm() {
    newUser = AppUser(
      id: '',
      email: '',
      address: '',
      name: '',
      password: '',
      cnic: '',
      userBio: '',
      userImage: '',
      userLatLng: GoogleMapsHelper().defaultGoogleMapsLocation,
    );
  }

  Future<FunctionResponse> trySignup() async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      final UserCredential _authResult =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: newUser.email, password: newUser.password);
      if (_authResult.user != null) {
        fResponse = await _customImageHelper.uploadPicture(
            (newUser.userImage), userImagesDirectory);
        if (fResponse.success) {
          updateUserImage(fResponse.data);

          await firestoreUsersCollection.doc(_authResult.user!.uid).set({
            'name': newUser.name,
            'email': newUser.email,
            'password': newUser.password,
            'userImage': newUser.userImage,
            'address': newUser.address,
            'cnic': newUser.cnic,
            'userBio': newUser.userBio,
            'userLatLng': GeoPoint(
                newUser.userLatLng.latitude, newUser.userLatLng.longitude),
          });
          fResponse.passed(message: 'Signup Successfull');
        }
      } else {
        fResponse.failed(message: 'Error Signing Up');
      }
    } catch (e) {
      fResponse.failed(message: 'Error signing up : $e');
    }

    resetSignupForm();

    return fResponse;
  }
}
