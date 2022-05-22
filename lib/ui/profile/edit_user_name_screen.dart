import 'package:flutter/material.dart';

import '../../custom_utils/connectivity_helper.dart';
import '../../custom_utils/custom_alerts.dart';
import '../../custom_utils/custom_form_helper.dart';
import '../../service_locator.dart';
import '../../stores/user_profile_screen_store.dart';
import '../custom_widgets/appbar_widget.dart';

//Custom Utilities
import '../../custom_utils/function_response.dart';
import '../../custom_utils/custom_validator.dart';

class FormData {
  String firstName;
  String lastName;
  FormData({
    required this.firstName,
    required this.lastName,
  });
}

class EditUserNameScreen extends StatelessWidget {
  EditUserNameScreen({Key? key}) : super(key: key);
  static const routeName = '/edit-user-name-screen';

  //Form
  final _formKey = GlobalKey<FormState>();
  FormData formData = FormData(firstName: '', lastName: '');

  //Custom Utilities
  final CustomValidator _customValidator = getIt<CustomValidator>();
  final CustomAlerts _customAlerts = getIt<CustomAlerts>();
  final ConnectivityHelper _connectivityHelper = getIt<ConnectivityHelper>();
  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();

  //Stores
  final UserProfileScreenStore _userProfileScreenStore =
      getIt<UserProfileScreenStore>();

  //Functions
  Future<void> updateUserName(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    if (!_formKey.currentState!.validate()) {
      fResponse.failed(message: 'Please enter valid inputs');
    } else {
      _customFormHelper.unfocusFormFields(context);
      _formKey.currentState!.save();
      _customAlerts.showLoaderDialog(context);
      fResponse = await _connectivityHelper.checkInternetConnection();
      if (fResponse.success) {
        fResponse = await _userProfileScreenStore.updateUserName(
            formData.firstName, formData.lastName);
      }
      _customAlerts.popLoader(context);
    }

    fResponse.printResponse();
    //show snackbar
    _customAlerts.showSnackBar(context, fResponse.message,
        success: fResponse.success);
    if (fResponse.success) {
      //Pop edit screen
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    //ThemeData & constraints
    ThemeData theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: buildAppBar(context),
          body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                    width: 330,
                    child: Text(
                      "What's Your Name?",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                        child: SizedBox(
                            height: 100,
                            width: 150,
                            child: TextFormField(
                              // Handles Form Validation for First Name
                              validator: _customValidator.validateName,
                              initialValue:
                                  _userProfileScreenStore.currentUser.firstName,
                              decoration: const InputDecoration(
                                  labelText: 'First Name'),
                              onSaved: (String? val) {
                                if (val == null) {
                                  return;
                                }
                                formData.firstName = val;
                              },
                            ))),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                        child: SizedBox(
                            height: 100,
                            width: 150,
                            child: TextFormField(
                              // Handles Form Validation for Last Name
                              validator: _customValidator.validateName,
                              initialValue:
                                  _userProfileScreenStore.currentUser.lastName,
                              decoration:
                                  const InputDecoration(labelText: 'Last Name'),
                              onSaved: (String? val) {
                                if (val == null) {
                                  return;
                                }
                                formData.lastName = val;
                              },
                              // controller: secondNameController,
                            )))
                  ],
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 330,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          await updateUserName(context);
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ))
              ],
            ),
          )),
    );
  }
}
