import 'package:app_30_car_service_app/ui/shop/shop_screen.dart';

import '../../custom_widgets/custom_wrappers.dart';
import '../../models/vehicle_service.dart';
import '../../resources/app_images.dart';
import 'package:flutter/material.dart';

import '../../service_locator.dart';
import '../../stores/available_shops_store.dart';
import '../book_service/service_details.dart';

class AvailableShopsScreen extends StatelessWidget {
  AvailableShopsScreen({Key? key}) : super(key: key);

  static const routeName = '/available-shops-screen';

  //Stores
  final AvailableShopeStore _availableShopeStore = getIt<AvailableShopeStore>();

  @override
  Widget build(BuildContext context) {
    //ThemeData & constraints
    ThemeData _theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Available Service Shops'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _availableShopeStore.availableShopsList.isEmpty
                      ? 1
                      : _availableShopeStore.availableShopsList.length,
                  itemBuilder: (ctx, index) => _availableShopItem(
                      context, _theme, index, _availableShopeStore),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _availableShopItem(BuildContext context, ThemeData _theme, int index,
      AvailableShopeStore availableShopeStore) {
    if (_availableShopeStore.availableShopsList.isEmpty) {
      return Center(
        child: Text(
          'No Shop Found Nearby :(',
          style: _theme.textTheme.headline4,
        ),
      );
    } else {
      VehicleService currentItem =
          availableShopeStore.availableShopsList[index];
      return Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ServiceDetails.routeName, arguments: {
                'vehicleService': currentItem,
              });
            },
            child: customContainer(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          currentItem.coverImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                          flex: 2,
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      currentItem.shopName,
                                      style: _theme.textTheme.headline4,
                                    ),
                                    Text(
                                      '${currentItem.cost} PKR',
                                      style: _theme.textTheme.headline5,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  currentItem.description,
                                  softWrap: true,
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // ListView.builder(
                                    //   itemCount: currentItem.rating,
                                    //   // scrollDirection: Axis.horizontal,
                                    //   shrinkWrap: true,
                                    //   physics:
                                    //       const NeverScrollableScrollPhysics(),
                                    //   itemBuilder:
                                    //       (BuildContext context, int index) {
                                    //     return const Icon(Icons.star);
                                    //   },
                                    // ),
                                    Row(
                                      children: [
                                        const Icon(Icons.star),
                                        Text(
                                          currentItem.rating.toStringAsFixed(1),
                                          style: _theme.textTheme.headline5,
                                        )
                                      ],
                                    ),
                                    Text(
                                        '${currentItem.distance.toStringAsFixed(1)} km'),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                              ],
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      );
    }
  }
}
