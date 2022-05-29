import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

//Custom Utilities
import '../../custom_utils/connectivity_helper.dart';
import '../../custom_utils/custom_alerts.dart';
import '../../custom_utils/custom_form_helper.dart';
import '../../custom_utils/custom_validator.dart';
import '../../custom_utils/function_response.dart';
import '../../custom_utils/general_helper.dart';
import '../../custom_utils/image_helper.dart';
import '../../custom_widgets/custom_wrappers.dart';
import '../../service_locator.dart';
//Models
import '../../models/vehicle.dart';
import '../../stores/manage_vehicle_store.dart';

class AddNewVehicleScreen extends StatelessWidget {
  AddNewVehicleScreen({Key? key}) : super(key: key);
  static const routeName = '/add-new-vehicle-screen';

  //Form
  final _formKey = GlobalKey<FormState>();
  Vehicle vehicle = Vehicle(
      id: '',
      userId: '',
      vehicleCompany: '',
      vehicleDescription: '',
      vehicleImages: [],
      vehicleModel: '',
      vehicleType: VehicleType.bike);

  //Custom Utilities
  final CustomValidator _customValidator = getIt<CustomValidator>();
  final CustomAlerts _customAlerts = getIt<CustomAlerts>();
  final ConnectivityHelper _connectivityHelper = getIt<ConnectivityHelper>();
  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();
  final CustomImageHelper _customImageHelper = getIt<CustomImageHelper>();

  //Stores
  final ManageVehicleStore _manageVehicleStore = getIt<ManageVehicleStore>();

  //Functions
  Future<void> addNewVehicleImage(BuildContext context) async {
    print('Adding new image');
    FunctionResponse fResponse = getIt<FunctionResponse>();
    _customAlerts.showLoaderDialog(context);
    fResponse = await _customImageHelper.pickUserImage(context);
    if (fResponse.success) {
      _manageVehicleStore.addNewVehicleImage(fResponse.data);
    }
    _customAlerts.popLoader(context);
  }

  void removeVehicleImage(String image) {
    print('asked to remove : $image');
    _manageVehicleStore.removeVehicleImage(image);
  }

  Future<void> addNewVehicle(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    if (!_formKey.currentState!.validate()) {
      fResponse.failed(message: 'Please enter valid inputs');
    } else if (_manageVehicleStore.vehicleImageList.isEmpty) {
      fResponse.failed(message: 'Please add atleast 1 vehicle image');
    } else {
      _customFormHelper.unfocusFormFields(context);
      _formKey.currentState!.save();
      await delayFunction();
      _customAlerts.showLoaderDialog(context);
      fResponse = await _connectivityHelper.checkInternetConnection();
      if (fResponse.success) {
        fResponse = await _manageVehicleStore.addNewVehicleToList(vehicle);
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
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Add New Vehicle',
                  style: theme.textTheme.headline3,
                ),
                const SizedBox(height: 20),
                customCard(
                    child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          vehicleNameField(),
                          const SizedBox(height: 20),
                          vehicleCompanyField(),
                          const SizedBox(height: 20),
                          vehicleDescriptionField(),
                          const SizedBox(height: 20),
                          vehicleTypeDropdown(theme),
                          const SizedBox(height: 20),
                          Observer(builder: (_) {
                            return imageGalleryWidget(
                                context, theme, _manageVehicleStore);
                          }),
                          // imageGalleryWidget(theme, _manageVehicleStore),
                          const SizedBox(height: 20),
                          saveButton(context),
                        ]),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageGalleryWidget(BuildContext context, ThemeData theme,
      ManageVehicleStore manageVehicleStore) {
    List<Widget> wrapItems = manageVehicleStore.vehicleImageList
        .map(
          (element) => SingleImageItem(
            element: element,
            removeVehicleImage: removeVehicleImage,
          ),
        )
        .toList();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text('Images', style: theme.textTheme.headline3),
            const SizedBox(),
            Observer(builder: (_) {
              return TextButton.icon(
                onPressed: manageVehicleStore.vehicleImageList.length >= 5
                    ? null
                    : () {
                        addNewVehicleImage(context);
                      },
                icon: const Icon(Icons.add),
                label: const Text('Add Image'),
              );
            }),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                runSpacing: 10,
                spacing: 5,
                children: wrapItems,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget vehicleDescriptionField() {
    return TextFormField(
      validator: _customValidator.nonNullableString,
      onSaved: (String? val) {
        if (val == null) {
          return;
        }
        vehicle.vehicleDescription = val;
      },
      // initialValue: _profileStore.user.address,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Vehicle Description',
      ),
    );
  }

  Widget vehicleCompanyField() {
    return TextFormField(
      validator: _customValidator.nonNullableString,
      onSaved: (String? val) {
        if (val == null) {
          return;
        }
        vehicle.vehicleCompany = val;
      },
      // initialValue: _profileStore.user.address,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Vehicle Company',
      ),
    );
  }

  Widget vehicleNameField() {
    return TextFormField(
      validator: _customValidator.nonNullableString,
      onSaved: (String? val) {
        if (val == null) {
          return;
        }
        vehicle.vehicleModel = val;
      },
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Vehicle Name/ Model',
      ),
    );
  }

  Widget saveButton(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: 320,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              await addNewVehicle(context);
            },
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ));
  }

  Widget vehicleTypeDropdown(ThemeData theme) {
    return Observer(builder: (_) {
      return Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DropdownButton<String>(
                  isExpanded: true,
                  value: _manageVehicleStore.selectedVehicleType,
                  onChanged: (String? newValue) {
                    _manageVehicleStore.changeSelectedVehicleType(
                        newValue ?? VehicleType.bike.getName());
                  },
                  items: VehicleType.values.map((VehicleType classType) {
                    return DropdownMenuItem<String>(
                      value: classType.getName(),
                      child: Text(
                        classType.getName(),
                        style: theme.textTheme.headline4,
                      ),
                    );
                  }).toList()),
            ),
          ),
        ],
      );
    });
  }
}

class SingleImageItem extends StatelessWidget {
  const SingleImageItem({
    Key? key,
    required this.element,
    required this.removeVehicleImage,
  }) : super(key: key);
  final String element;
  final Function removeVehicleImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          Container(
            height: 70,
            width: 70,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Image.file(
              File(element),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: InkWell(
                onTap: () {
                  removeVehicleImage(element);
                },
                child: const Icon(Icons.close)),
            alignment: Alignment.topRight,
          ),
          // Container(
          //     alignment: Alignment.center,
          //     child: Text(
          //       element.substring(6),
          //       style: Theme.of(context).textTheme.headline4,
          //     )),
        ],
      ),
    );
  }
}
