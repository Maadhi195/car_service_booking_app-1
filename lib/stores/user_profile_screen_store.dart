import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:mobx/mobx.dart';
//Models
import '../models/user.dart';
//Custom Utilities
import '../../custom_utils/general_helper.dart';
import '../../custom_utils/function_response.dart';
import '../service_locator.dart';
part 'user_profile_screen_store.g.dart';

class UserProfileScreenStore = _UserProfileScreenStore
    with _$UserProfileScreenStore;

abstract class _UserProfileScreenStore with Store {
  @observable
  User user = User(
    id: '1',
    firstName: 'Hammad',
    lastName: 'Khalid',
    email: 'hammad123@gmail.com',
    password: '12345678',
    userImage:
        'https://image.shutterstock.com/image-vector/businessman-profile-icon-male-portrait-600w-231829399.jpg',
    address: 'Burewala, Punjab, Pakistan',
    userBio:
        'Lorem Ipsum Dolor Set Amet Delet Lorem Ipsum Dolor Set Amet Delet Lorem Ipsum Dolor Set Amet Delet Lorem Ipsum Dolor Set Amet Delet',
    userLatLng: const LatLng(30.5116, 74.3333),
    // userLatLng: '',
  );

  Future<FunctionResponse> updateUserName(
      String firstName, String lastName) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    await delayFunction();
    try {
      print('before update');
      user = User(
        id: user.id,
        firstName: firstName,
        lastName: lastName,
        email: user.email,
        password: user.password,
        userImage: user.userImage,
        address: user.address,
        userBio: user.userBio,
        userLatLng: user.userLatLng,
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
      user = User(
        id: user.id,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        password: user.password,
        userImage: user.userImage,
        address: address,
        userBio: user.userBio,
        userLatLng: user.userLatLng,
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
      user = User(
        id: user.id,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        password: user.password,
        userImage: user.userImage,
        address: user.address,
        userBio: userBio,
        userLatLng: user.userLatLng,
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
      user = User(
        id: user.id,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        password: user.password,
        userImage: userImage,
        address: user.address,
        userBio: user.userBio,
        userLatLng: user.userLatLng,
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

  Future<FunctionResponse> updateUserLatLng(PickResult newLocation) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    await delayFunction();

    try {
      print('${newLocation.formattedAddress}');
      print('${newLocation.geometry?.location.lat}');
      print('${newLocation.geometry?.location.lng}');

      print('before update');
      user = User(
        id: user.id,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        password: user.password,
        userImage: user.userImage,
        address: user.address,
        userBio: user.userBio,
        userLatLng: LatLng(newLocation.geometry!.location.lat,
            newLocation.geometry!.location.lng),
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
}
