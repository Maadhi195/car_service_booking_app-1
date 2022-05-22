import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
//Models
import '../constants/firebase_constants.dart';
import '../custom_utils/google_maps_helper.dart';
import '../models/app_user.dart';
//Custom Utilities
import '../../custom_utils/general_helper.dart';
import '../../custom_utils/function_response.dart';
import '../service_locator.dart';
part 'user_profile_screen_store.g.dart';

class UserProfileScreenStore = _UserProfileScreenStore
    with _$UserProfileScreenStore;

abstract class _UserProfileScreenStore with Store {
  @observable
  // AppUser currentUser = AppUser(
  //   id: '1',
  //   firstName: 'Hammad',
  //   lastName: 'Khalid',
  //   email: 'hammad123@gmail.com',
  //   password: '12345678',
  //   userImage:
  //       'https://image.shutterstock.com/image-vector/businessman-profile-icon-male-portrait-600w-231829399.jpg',
  //   address: 'Burewala, Punjab, Pakistan',
  //   userBio:
  //       'Lorem Ipsum Dolor Set Amet Delet Lorem Ipsum Dolor Set Amet Delet Lorem Ipsum Dolor Set Amet Delet Lorem Ipsum Dolor Set Amet Delet',
  //   userLatLng: const LatLng(30.5116, 74.3333),
  //   // userLatLng: '',
  // );
  AppUser currentUser = AppUser(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    address: '',
    userImage: '',
    userBio: '',
    userLatLng: GoogleMapsHelper().defaultGoogleMapsLocation,
  );

  Future<FunctionResponse> updateUserName(
      String firstName, String lastName) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    await delayFunction();
    try {
      print('before update');
      currentUser = AppUser(
        id: currentUser.id,
        firstName: firstName,
        lastName: lastName,
        email: currentUser.email,
        password: currentUser.password,
        userImage: currentUser.userImage,
        address: currentUser.address,
        userBio: currentUser.userBio,
        userLatLng: currentUser.userLatLng,
      );

      fResponse.passed(message: 'Name Updated');
      print('after update');
      fResponse.printResponse();
    } catch (e) {
      fResponse.failed(message: 'Unable to update name : $e');
    }
    // fResponse.printResponse();
    return fResponse;
  }

  Future<FunctionResponse> updateUserAddress(String address) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    await delayFunction();
    try {
      print('before update');
      currentUser = AppUser(
        id: currentUser.id,
        firstName: currentUser.firstName,
        lastName: currentUser.lastName,
        email: currentUser.email,
        password: currentUser.password,
        userImage: currentUser.userImage,
        address: address,
        userBio: currentUser.userBio,
        userLatLng: currentUser.userLatLng,
      );

      fResponse.passed(message: 'Address Updated');
      print('after update');
      fResponse.printResponse();
    } catch (e) {
      fResponse.failed(message: 'Unable to update address : $e');
    }
    // fResponse.printResponse();
    return fResponse;
  }

  Future<FunctionResponse> updateUserBio(String userBio) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    await delayFunction();
    try {
      print('before update');
      currentUser = AppUser(
        id: currentUser.id,
        firstName: currentUser.firstName,
        lastName: currentUser.lastName,
        email: currentUser.email,
        password: currentUser.password,
        userImage: currentUser.userImage,
        address: currentUser.address,
        userBio: userBio,
        userLatLng: currentUser.userLatLng,
      );

      fResponse.passed(message: 'User Bio Updated');
      print('after update');
      fResponse.printResponse();
    } catch (e) {
      fResponse.failed(message: 'Unable to update address : $e');
    }
    // fResponse.printResponse();
    return fResponse;
  }

  Future<FunctionResponse> updateUserImage(String userImage) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    await delayFunction();
    try {
      print('before update');
      currentUser = AppUser(
        id: currentUser.id,
        firstName: currentUser.firstName,
        lastName: currentUser.lastName,
        email: currentUser.email,
        password: currentUser.password,
        userImage: userImage,
        address: currentUser.address,
        userBio: currentUser.userBio,
        userLatLng: currentUser.userLatLng,
      );

      fResponse.passed(message: 'User Image Updated');
      print('after update');
      fResponse.printResponse();
    } catch (e) {
      fResponse.failed(message: 'Unable to update Image : $e');
    }
    // fResponse.printResponse();
    return fResponse;
  }

  Future<FunctionResponse> updateUserLatLng(LatLng newLocation) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    await delayFunction();

    try {
      print('before update');
      currentUser = AppUser(
        id: currentUser.id,
        firstName: currentUser.firstName,
        lastName: currentUser.lastName,
        email: currentUser.email,
        password: currentUser.password,
        userImage: currentUser.userImage,
        address: currentUser.address,
        userBio: currentUser.userBio,
        userLatLng: newLocation,
      );

      fResponse.passed(message: 'User LatLng Updated');
      print('after update');
      fResponse.printResponse();
    } catch (e) {
      fResponse.failed(message: 'Unable to update address : $e');
    }
    // fResponse.printResponse();
    return fResponse;
  }

  @action
  Future<FunctionResponse> loadProfile() async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    try {
      var data;
      final User? user = firebaseAuth.currentUser;
      if (user != null) {
        DocumentSnapshot doc =
            await firestoreUsersCollection.doc(user.uid).get();
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

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
            firstName: data['firstName'],
            lastName: data['lastName'],
            email: data['email'],
            password: data['password'],
            address: data['address'],
            userImage: data['userImage'],
            userBio: data['userBio'],
            userLatLng: newUserLatLng,
          );
          fResponse.passed(message: 'Profile Loaded from database');
        }
      } else {
        fResponse.failed(message: 'Current user not found');
      }
    } catch (e) {
      fResponse.failed(message: 'Error loading profile : $e');
    }

    return fResponse;
  }
}
