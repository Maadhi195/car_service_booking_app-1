import 'package:app_30_car_service_app/ui/shop/shop_screen.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../custom_widgets/custom_wrappers.dart';
import '../../models/vehicle_service.dart';
import '../../repo/shop_repo.dart';
import '../../resources/app_images.dart';
import 'package:flutter/material.dart';

import '../../service_locator.dart';
import '../../stores/available_shops_store.dart';
import '../../stores/profile_store.dart';
import '../book_service/service_details_screen.dart';

class AvailableShopsScreen extends StatefulWidget {
  AvailableShopsScreen({Key? key}) : super(key: key);

  static const routeName = '/available-shops-screen';

  @override
  State<AvailableShopsScreen> createState() => _AvailableShopsScreenState();
}

class _AvailableShopsScreenState extends State<AvailableShopsScreen> {
  //Stores
  final AvailableShopStore _availableShopStore = getIt<AvailableShopStore>();
  final ProfileStore _profileStore = getIt<ProfileStore>();

  @override
  void initState() {
    _availableShopStore
        .loadAvailableServices(_profileStore.currentUser.userLatLng);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //ThemeData & constraints
    ThemeData theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Observer(builder: (_) {
        return _availableShopStore.isLoadingServices
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              )
            : Scaffold(
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
                          itemCount:
                              _availableShopStore.availableServicesList.isEmpty
                                  ? 1
                                  : _availableShopStore
                                      .availableServicesList.length,
                          itemBuilder: (ctx, index) => _availableShopItem(
                              context, theme, index, _availableShopStore),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
      }),
    );
  }

  Widget _availableShopItem(BuildContext context, ThemeData theme, int index,
      AvailableShopStore availableShopStore) {
    if (_availableShopStore.availableServicesList.isEmpty) {
      return Center(
        child: Text(
          'No Shop Found Nearby :(',
          style: theme.textTheme.headline4,
        ),
      );
    } else {
      VehicleService currentItem =
          availableShopStore.availableServicesList[index];
      return Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ServiceDetails.routeName, arguments: {
                'vehicleService': currentItem,
              });
            },
            child: customCard(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: buildImage(
                          theme,
                          currentItem.coverImage,
                          height: 80,
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
                                      style: theme.textTheme.headline5,
                                    ),
                                    Text(
                                      '${currentItem.cost} PKR',
                                      style: theme.textTheme.headline6,
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
                                          style: theme.textTheme.headline5,
                                        )
                                      ],
                                    ),
                                    FutureBuilder<double>(
                                        future: ShopRepo.instance
                                            .getDistance(currentItem.shopId),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              '${snapshot.data!.toStringAsFixed(1)} km',
                                              style: theme.textTheme.headline5,
                                            );
                                          } else {
                                            return const Text('');
                                          }
                                        }),
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
