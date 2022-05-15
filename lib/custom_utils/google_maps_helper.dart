import 'package:flutter/material.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../service_locator.dart';
import 'function_response.dart';

class GoogleMapsHelper {
  FunctionResponse showPlacePicker(BuildContext context,
      {LatLng? initialPosition}) {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    const apiKey = "AIzaSyBqbPKtyaIo4H85J5or0lCZ7Lyipc8nxSY";
    LatLng init = initialPosition ?? LatLng(31.5116835, 74.3330131);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey: apiKey,
          onPlacePicked: (result) {
            print('AAAAAAA :${result.formattedAddress}');
            print(result.geometry?.location.lat);
            print(result.geometry?.location.lat);
            fResponse.data = result;
            fResponse.passed(message: 'got location');
            Navigator.of(context).pop();
          },
          initialPosition: init,
          useCurrentLocation: true,
        ),
      ),
    );
    return fResponse;
  }
}
