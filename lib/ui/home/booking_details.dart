import 'package:app_30_car_service_app/repo/review_repo.dart';
import 'package:app_30_car_service_app/repo/shop_repo.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../custom_utils/connectivity_helper.dart';
import '../../custom_utils/custom_alerts.dart';
import '../../custom_utils/function_response.dart';
import '../../custom_widgets/custom_wrappers.dart';
import '../../models/review_model.dart';
import '../../models/service_request.dart';
import 'package:flutter/material.dart';

import '../../custom_utils/general_helper.dart';
import '../../service_locator.dart';
import '../../stores/book_service_store.dart';

class BookingDetailsScreen extends StatelessWidget {
  BookingDetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/booking-details-screen';

  //Custom Utils
  final CustomAlerts _customAlerts = getIt<CustomAlerts>();
  final ConnectivityHelper _connectivityHelper = getIt<ConnectivityHelper>();

  //Stores
  final BookServiceStore _bookServiceStore = getIt<BookServiceStore>();

  //Functions
  Future<void> updateRequestStatus(
      BuildContext context,
      String serviceRequestId,
      ServiceRequestStatus serviceRequestStatus) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    _customAlerts.showLoaderDialog(context);
    fResponse = await _connectivityHelper.checkInternetConnection();
    if (fResponse.success) {
      fResponse = await _bookServiceStore.updateRequsetStatus(
          serviceRequestId, serviceRequestStatus);
      _bookServiceStore.loadAllServiceRequests();
    }
    _customAlerts.popLoader(context);

    fResponse.printResponse();
    //show snackbar
    _customAlerts.showSnackBar(context, fResponse.message,
        success: fResponse.success);
    if (fResponse.success) {
      //Go back
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    int rating = 3;
    //ThemeData & constraints
    ThemeData theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    //route Data handeling
    dynamic routeData = modalRouteHandler(context);
    final ServiceRequest serviceRequest = routeData['serviceRequest'];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                customCard(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _customListItem(
                          theme,
                          'Date',
                          DateFormat('kk:mm a - d M y')
                              .format(serviceRequest.dateTime)),
                      _customListItem(
                          theme,
                          'Type',
                          serviceRequest.isMobile
                              ? 'Mobile Service'
                              : ' Normal Booking'),
                      _customListItem(theme, 'Shop Name',
                          serviceRequest.vehicleService.shopName),
                      _customListItem(theme, 'Cost',
                          serviceRequest.vehicleService.cost.toString()),
                      _customListItem(theme, 'Status',
                          serviceRequest.serviceRequestStatus.getName()),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                (serviceRequest.serviceRequestStatus ==
                            ServiceRequestStatus.idle ||
                        serviceRequest.serviceRequestStatus ==
                            ServiceRequestStatus.completed)
                    ? Column(
                        children: [
                          RatingBar.builder(
                            initialRating: rating.toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) async {
                              rating = rating;

                              print(rating);

                              // Navigator.of(ctx).pop();
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    ServiceRequestStatus? nextStatus;

                                    if (serviceRequest.serviceRequestStatus ==
                                        ServiceRequestStatus.idle) {
                                      nextStatus =
                                          ServiceRequestStatus.canceled;
                                    } else if (serviceRequest
                                            .serviceRequestStatus ==
                                        ServiceRequestStatus.completed) {
                                      nextStatus = ServiceRequestStatus.done;
                                    }
                                    // await showDialog(
                                    //     context: context,
                                    //     builder: (ctx) => Center(
                                    //           child: RatingBar.builder(
                                    //             initialRating: 3,
                                    //             minRating: 1,
                                    //             direction: Axis.horizontal,
                                    //             allowHalfRating: true,
                                    //             itemCount: 5,
                                    //             itemPadding:
                                    //                 EdgeInsets.symmetric(
                                    //                     horizontal: 4.0),
                                    //             itemBuilder: (context, _) =>
                                    //                 Icon(
                                    //               Icons.star,
                                    //               color: Colors.amber,
                                    //             ),
                                    //             onRatingUpdate: (rating) async {
                                    //               await ReviewRepo.instance
                                    //                   .addReview(ReviewModel(
                                    //                       id: '',
                                    //                       shopId: serviceRequest
                                    //                           .shopId,
                                    //                       userId: serviceRequest
                                    //                           .userId,
                                    //                       rating: rating));

                                    //               print(rating);

                                    //               Navigator.of(ctx).pop();
                                    //             },
                                    //           ),
                                    //         ));

                                    assert(nextStatus != null);
                                    await updateRequestStatus(context,
                                        serviceRequest.id, nextStatus!);
                                    await ShopRepo.instance
                                        .incrementTotalEarning(
                                            serviceRequest.shopId,
                                            serviceRequest.vehicleService.cost);

                                    await ReviewRepo.instance.addReview(
                                        ReviewModel(
                                            id: '',
                                            shopId: serviceRequest.shopId,
                                            userId: serviceRequest.userId,
                                            rating: rating.toDouble()));
                                  },
                                  child: Text(serviceRequest
                                      .serviceRequestStatus
                                      .getButtonTextName()),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customListItem(ThemeData theme, String key, String value) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      key,
                      style: theme.textTheme.headline5,
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      value,

                      softWrap: true,
                      style: theme.textTheme.headline5,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
