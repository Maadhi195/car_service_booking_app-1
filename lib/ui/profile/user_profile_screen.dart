import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import '../../custom_utils/connectivity_helper.dart';
import '../../custom_utils/custom_alerts.dart';
import '../../custom_utils/custom_form_helper.dart';
import '../../custom_utils/custom_validator.dart';
import '../../custom_utils/function_response.dart';
import '../../custom_utils/image_helper.dart';
import '../../custom_widgets/custom_wrappers.dart';
import '../../resources/app_images.dart';
import '../../service_locator.dart';
import '../../stores/profile_store.dart';
import '../../theme/my_app_colors.dart';
//UI
import '../custom_widgets/get_location_screen.dart';
import '../../ui/home/home_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile-screen';

  final AppColors _appColors = getIt<AppColors>();

  //Form
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();

  //Custom Utils
  final CustomValidator _customValidator = getIt<CustomValidator>();
  final CustomAlerts _customAlerts = getIt<CustomAlerts>();
  final CustomImageHelper _customImageHelper = getIt<CustomImageHelper>();
  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();
  final ConnectivityHelper _connectivityHelper = getIt<ConnectivityHelper>();

  //Stores
  final ProfileStore _profileStore = getIt<ProfileStore>();

  //Functions
  Future<void> changeUserImage(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      _customAlerts.showLoaderDialog(context);

      fResponse = await _customImageHelper.pickUserImage(context);

      if (fResponse.success) {
        _profileStore.updateUserImage(fResponse.data);
        fResponse.passed(message: 'Added new Image');
      }
      _customAlerts.popLoader(context);
    } catch (e) {
      fResponse.failed(message: 'Unable to add cover Image : $e');
    }
  }

  Future<void> getLocation(context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      _customAlerts.showLoaderDialog(context);
      fResponse = await _connectivityHelper.checkInternetConnection();

      if (fResponse.success) {
        final LatLng? newLocation = await Navigator.of(context)
            .pushNamed(GetLocationScreen.routeName, arguments: {
          'startLocation': _profileStore.currentUser.userLatLng
        }) as LatLng;
        print('recieved : $newLocation');
        if (newLocation != null) {
          _profileStore.updateUserLocation(newLocation);
          _locationController.text =
              '${_profileStore.currentUser.userLatLng.latitude.toStringAsFixed(5)},  ${_profileStore.currentUser.userLatLng.longitude.toStringAsFixed(5)}';
          print('updated location');
          fResponse.passed(message: 'Location Updated');
        }
      }
    } catch (e) {
      print(e);
    }
    _customAlerts.popLoader(context);

    fResponse.printResponse();
    //show snackbar
    _customAlerts.showSnackBar(context, fResponse.message,
        success: fResponse.success);
  }

  Future<void> updateProfile(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    if (!_formKey.currentState!.validate()) {
      fResponse.failed(message: 'Please enter valid inputs');
    } else if (_profileStore.currentUser.userImage.isEmpty) {
      fResponse.failed(message: 'Please add a cover image');
    } else {
      _customFormHelper.unfocusFormFields(context);
      _formKey.currentState!.save();
      _customAlerts.showLoaderDialog(context);
      fResponse = await _connectivityHelper.checkInternetConnection();
      if (fResponse.success) {
        fResponse = await _profileStore.updateProfile();
      }
      _customAlerts.popLoader(context);
    }

    fResponse.printResponse();
    //show snackbar
    _customAlerts.showSnackBar(context, fResponse.message,
        success: fResponse.success);
    if (fResponse.success) {
      //Go to Home
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    //ThemeData & constraints
    ThemeData theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    const double topPadding = 200;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: _appColors.loginScaffoldColor,
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight * 1.5,
            width: screenWidth,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    height: screenHeight * 0.35,
                    width: screenWidth,
                    color: theme.colorScheme.primary,
                    child: Center(
                      child: Image.asset(
                        appLogo,
                        height: 100,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.20,
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth,
                        padding: const EdgeInsets.all(18.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: customCard(
                            padding: const EdgeInsets.all(15.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // const SizedBox(height: topPadding),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Update Profile',
                                        style:
                                            theme.textTheme.headline2?.copyWith(
                                          color: _appColors.primaryColorLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: InkWell(
                                        onTap: () async {
                                          await changeUserImage(context);
                                        },
                                        child: Observer(builder: (_) {
                                          return Container(
                                            clipBehavior: Clip.hardEdge,
                                            decoration: const BoxDecoration(),
                                            child: CircleAvatar(
                                              radius: 50,
                                              // clipBehavior: Clip.hardEdge,
                                              // borderRadius: BorderRadius.circular(100),
                                              backgroundColor: _profileStore
                                                      .currentUser
                                                      .userImage
                                                      .isEmpty
                                                  ? null
                                                  : Colors.transparent,
                                              child: _profileStore.currentUser
                                                      .userImage.isEmpty
                                                  ? const Center(
                                                      child: Icon(
                                                        Icons.image,
                                                        size: 40,
                                                      ),
                                                    )
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: buildImage(
                                                        theme,
                                                        _profileStore
                                                            .currentUser
                                                            .userImage,
                                                        height: 100,
                                                        width: 100,
                                                      ),
                                                    ),
                                            ),
                                          );
                                        }),
                                      )),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    initialValue:
                                        _profileStore.currentUser.name,
                                    validator:
                                        _customValidator.nonNullableString,
                                    onSaved: (String? val) {
                                      if (val == null) {
                                        return;
                                      }
                                      _profileStore.updateUserName(val);
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      label: Text('Name'),
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  TextFormField(
                                    initialValue:
                                        _profileStore.currentUser.address,
                                    validator:
                                        _customValidator.nonNullableString,
                                    onSaved: (String? val) {
                                      if (val == null) {
                                        return;
                                      }
                                      _profileStore.updateUserAddress(val);
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      label: Text('Address'),
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  TextFormField(
                                    initialValue:
                                        _profileStore.currentUser.userBio,
                                    validator:
                                        _customValidator.nonNullableString,
                                    onSaved: (String? val) {
                                      if (val == null) {
                                        return;
                                      }
                                      _profileStore.updateUserBio(val);
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      label: Text('User Bio'),
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  Observer(builder: (_) {
                                    return TextFormField(
                                      readOnly: true,
                                      validator:
                                          _customValidator.nonNullableString,
                                      controller: _locationController,
                                      decoration: InputDecoration(
                                          label: const Text('Location'),
                                          prefixIcon:
                                              const Icon(Icons.location_on),
                                          suffixIcon: IconButton(
                                              onPressed: () async {
                                                await getLocation(context);
                                              },
                                              icon: const Icon(
                                                  Icons.map_outlined))),
                                    );
                                  }),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              await updateProfile(context);
                                            },
                                            child: const Text('Update')),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
