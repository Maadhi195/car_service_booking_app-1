// import 'package:flutter/material.dart';

// import '../../custom_utils/connectivity_helper.dart';
// import '../../custom_utils/custom_alerts.dart';
// import '../../custom_utils/custom_form_helper.dart';
// import '../../service_locator.dart';
// import '../../stores/profile_store.dart';
// import '../custom_widgets/appbar_widget.dart';

// //Custom Utilities
// import '../../custom_utils/function_response.dart';
// import '../../custom_utils/custom_validator.dart';

// class EditUserBioScreen extends StatelessWidget {
//   EditUserBioScreen({Key? key}) : super(key: key);
//   static const routeName = '/edit-user-bio-screen';

//   //Form
//   final _formKey = GlobalKey<FormState>();
//   Map<String, String> formData = {'bio': ''};

//   //Custom Utilities
//   final CustomValidator _customValidator = getIt<CustomValidator>();
//   final CustomAlerts _customAlerts = getIt<CustomAlerts>();
//   final ConnectivityHelper _connectivityHelper = getIt<ConnectivityHelper>();
//   final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();

//   //Stores
//   final ProfileStore _profileStore = getIt<ProfileStore>();

//   //Functions
//   Future<void> updateUserBio(BuildContext context) async {
//     FunctionResponse fResponse = getIt<FunctionResponse>();

//     if (!_formKey.currentState!.validate()) {
//       fResponse.failed(message: 'Please enter valid inputs');
//     } else {
//       _customFormHelper.unfocusFormFields(context);
//       _formKey.currentState!.save();
//       _customAlerts.showLoaderDialog(context);
//       fResponse = await _connectivityHelper.checkInternetConnection();
//       if (fResponse.success) {
//         fResponse = await _profileStore.updateUserBio(formData['bio'] ?? '');
//       }
//       _customAlerts.popLoader(context);
//     }

//     fResponse.printResponse();
//     //show snackbar
//     _customAlerts.showSnackBar(context, fResponse.message,
//         success: fResponse.success);
//     if (fResponse.success) {
//       //Pop edit screen
//       Navigator.of(context).pop();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     //ThemeData & constraints
//     ThemeData theme = Theme.of(context);
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double screenWidth = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//           appBar: buildAppBar(context),
//           body: Form(
//             key: _formKey,
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   const SizedBox(
//                       width: 320,
//                       child: Text(
//                         "Tell us about yourself",
//                         style: TextStyle(
//                             fontSize: 22, fontWeight: FontWeight.bold),
//                       )),
//                   Padding(
//                       padding: const EdgeInsets.only(top: 40),
//                       child: SizedBox(
//                           height: 100,
//                           width: 320,
//                           child: TextFormField(
//                             // Handles Form Validation
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your Bio';
//                               }
//                               //todo: validate
//                               // else if (isAlpha(value)) {
//                               //   return 'Only Numbers Please';
//                               // }
//                               // else if (value.length < 10) {
//                               //   return 'Please enter a VALID Address';
//                               // }
//                               return null;
//                             },
//                             // controller: phoneController,
//                             onSaved: (String? val) {
//                               if (val == null) {
//                                 return;
//                               }
//                               formData['bio'] = val;
//                             },
//                             initialValue: _profileStore.currentUser.userBio,
//                             keyboardType: TextInputType.text,
//                             decoration: const InputDecoration(
//                               labelText: 'Your Bio',
//                             ),
//                           ))),
//                   Align(
//                       alignment: Alignment.bottomCenter,
//                       child: SizedBox(
//                         width: 320,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             // Validate returns true if the form is valid, or false otherwise.
//                             // if (_formKey.currentState!.validate() &&
//                             //     isNumeric(phoneController.text)) {
//                             //   updateUserValue(phoneController.text);
//                             // }
//                             await updateUserBio(context);
//                           },
//                           child: const Text(
//                             'Update',
//                             style: TextStyle(fontSize: 15),
//                           ),
//                         ),
//                       ))
//                 ]),
//           )),
//     );
//   }
// }
