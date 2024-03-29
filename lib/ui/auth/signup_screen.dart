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
import '../../stores/auth_store.dart';
import '../../theme/my_app_colors.dart';
//UI
import '../custom_widgets/get_location_screen.dart';
import 'login_screen.dart';
import '../../ui/home/home_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  static const routeName = '/signup-screen';

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
  final AuthStore _authStore = getIt<AuthStore>();

  //Functions
  Future<void> changeUserImage(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      _customAlerts.showLoaderDialog(context);

      fResponse = await _customImageHelper.pickUserImage(context);

      if (fResponse.success) {
        _authStore.updateUserImage(fResponse.data);
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
        final LatLng? newLocation = await Navigator.of(context).pushNamed(
            GetLocationScreen.routeName,
            arguments: {'startLocation': null}) as LatLng;
        print('recieved : $newLocation');
        if (newLocation != null) {
          _authStore.updateUserLocation(newLocation);
          _locationController.text =
              '${_authStore.newUser.userLatLng.latitude.toStringAsFixed(5)},  ${_authStore.newUser.userLatLng.longitude.toStringAsFixed(5)}';
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

  Future<void> signup(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    if (!_formKey.currentState!.validate()) {
      fResponse.failed(message: 'Please enter valid inputs');
    } else if (_authStore.newUser.userImage.isEmpty) {
      fResponse.failed(message: 'Please add a cover image');
    } else {
      _customFormHelper.unfocusFormFields(context);
      _formKey.currentState!.save();
      _customAlerts.showLoaderDialog(context);
      fResponse = await _connectivityHelper.checkInternetConnection();
      if (fResponse.success) {
        fResponse = await _authStore.trySignup();
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
                                        'Sign Up',
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
                                              backgroundColor: _authStore
                                                      .newUser.userImage.isEmpty
                                                  ? null
                                                  : Colors.transparent,
                                              child: _authStore
                                                      .newUser.userImage.isEmpty
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
                                                        _authStore
                                                            .newUser.userImage,
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
                                    validator:
                                        _customValidator.nonNullableString,
                                    onSaved: (String? val) {
                                      if (val == null) {
                                        return;
                                      }

                                      _authStore.newUser.name = val;
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      label: Text('Name'),
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),

                                  const SizedBox(height: 20),
                                  TextFormField(
                                    validator: _customValidator.validateEmail,
                                    onSaved: (String? val) {
                                      if (val == null) {
                                        return;
                                      }
                                      _authStore.newUser.email = val;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      label: Text('Email'),
                                      prefixIcon: Icon(Icons.email),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    validator:
                                        _customValidator.nonNullableString,
                                    onSaved: (String? val) {
                                      if (val == null) {
                                        return;
                                      }
                                      _authStore.newUser.password = val;
                                    },
                                    obscureText: true,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      label: Text('Password'),
                                      prefixIcon: Icon(Icons.lock),
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  TextFormField(
                                    validator:
                                        _customValidator.nonNullableString,
                                    onSaved: (String? val) {
                                      if (val == null) {
                                        return;
                                      }
                                      _authStore.newUser.address = val;
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      label: Text('Address'),
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  TextFormField(
                                    validator:
                                        _customValidator.nonNullableString,
                                    onSaved: (String? val) {
                                      if (val == null) {
                                        return;
                                      }
                                      _authStore.updateCnic(val);
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      label: Text('cnic'),
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                    maxLength: 13,
                                  ),
                                  const SizedBox(height: 20),

                                  TextFormField(
                                    validator:
                                        _customValidator.nonNullableString,
                                    onSaved: (String? val) {
                                      if (val == null) {
                                        return;
                                      }
                                      _authStore.newUser.userBio = val;
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      label: Text('User Bio'),
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  Observer(builder: (_) {
                                    print(_authStore.newUser.userLatLng);
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
                                              await signup(context);
                                            },
                                            child: const Text('Register')),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Or',
                                    style: theme.textTheme.headline5,
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    LoginScreen.routeName);
                                          },
                                          child: const Text('Login'),
                                          style: theme
                                              .elevatedButtonTheme.style!
                                              .copyWith(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    _appColors
                                                        .accentColorLight),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    theme.colorScheme.primary),
                                            side: MaterialStateProperty.all(
                                                BorderSide(
                                                    color: theme.primaryColor)),
                                          ),
                                        ),
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
