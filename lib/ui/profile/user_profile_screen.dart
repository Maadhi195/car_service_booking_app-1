import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../custom_utils/custom_alerts.dart';
import '../../custom_utils/google_maps_helper.dart';
import '../../custom_utils/image_helper.dart';
import '../../custom_utils/function_response.dart';
import '../../service_locator.dart';
import '../../stores/user_profile_screen_store.dart';
import 'edit_user_address_screen.dart';
import 'edit_user_bio_screen.dart';
import 'edit_user_name_screen.dart';
import 'widget/display_image_widget.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/user-profile-screen';

  //Stores
  final UserProfileScreenStore _userProfileScreenStore =
      getIt<UserProfileScreenStore>();

  //Custom Utilities
  final CustomImageHelper _customImageHelper = getIt<CustomImageHelper>();
  final CustomAlerts _customAlerts = getIt<CustomAlerts>();
  final GoogleMapsHelper _googleMapsHelper = getIt<GoogleMapsHelper>();

  //Functions
  Future<void> changeUserImage(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      _customAlerts.showLoaderDialog(context);

      fResponse = await _customImageHelper.pickUserImage(context);

      if (fResponse.success) {
        fResponse =
            await _userProfileScreenStore.updateUserImage(fResponse.data);
      }
      _customAlerts.popLoader(context);
    } catch (e) {
      fResponse.failed(message: 'Unable to change user Image : $e');
    }
  }

  Future<void> changeUserLatLng(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      // _customAlerts.showLoaderDialog(context);

      // fResponse = _googleMapsHelper.showPlacePicker(context);

      if (fResponse.success) {
        // final PickResult pickResult = fResponse.data;
        fResponse =
            await _userProfileScreenStore.updateUserLatLng(fResponse.data);
      }
      // _customAlerts.popLoader(context);
    } catch (e) {
      fResponse.failed(message: 'Unable to change user LatLng : $e');
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
        appBar: AppBar(),
        body: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 10,
            ),
            const Center(
                child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(64, 105, 225, 1),
                      ),
                    ))),
            Observer(builder: (_) {
              return InkWell(
                  onTap: () async {
                    await changeUserImage(context);
                  },
                  child: DisplayImage(
                    imagePath: _userProfileScreenStore.currentUser.userImage,
                    onPressed: () {},
                  ));
            }),
            const SizedBox(height: 20),
            Observer(builder: (_) {
              return buildUserInfoDisplay(
                context,
                theme,
                '${_userProfileScreenStore.currentUser.firstName} ${_userProfileScreenStore.currentUser.lastName}',
                'Name',
                EditUserNameScreen.routeName,
              );
            }),
            Observer(builder: (_) {
              return buildUserInfoDisplay(
                  context,
                  theme,
                  _userProfileScreenStore.currentUser.address,
                  'Address',
                  EditUserAddressScreen.routeName);
            }),
            Observer(builder: (_) {
              return buildUserInfoDisplay(
                  context,
                  theme,
                  _userProfileScreenStore.currentUser.userBio,
                  'User Bio',
                  EditUserBioScreen.routeName);
            }),
            Observer(builder: (_) {
              return buildUserInfoDisplay(
                context,
                theme,
                _userProfileScreenStore.currentUser.userLatLng.toString(),
                'User Location',
                EditUserBioScreen.routeName,
                onPressed: () {
                  changeUserLatLng(context);
                },
              );
            }),
            // buildUserInfoDisplay(user.email, 'Email', EditEmailFormPage()),
          ],
        ),
      ),
    );
  }
}

Widget buildUserInfoDisplay(BuildContext context, ThemeData theme,
        String getValue, String title, String editPage,
        {VoidCallback? onPressed}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          // const SizedBox(
          //   height: 5.0,
          // ),
          Row(
            children: [
              Expanded(
                child: Text(getValue,
                    style: theme.textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.w500,
                    )),
              ),
              IconButton(
                onPressed: onPressed ??
                    () {
                      Navigator.of(context).pushNamed(editPage);
                    },
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
