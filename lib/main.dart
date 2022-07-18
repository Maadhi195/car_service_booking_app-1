import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:logging/logging.dart';

//Theme
import 'constants/firebase_constants.dart';
import 'theme/light_theme.dart';
//Screens
import 'ui/auth/login_screen.dart';
import 'ui/auth/signup_screen.dart';
import 'ui/book_service/service_details_screen.dart';
import 'ui/custom_widgets/get_location_screen.dart';
import 'ui/home/booking_details.dart';
import 'ui/home/bookings_screen.dart';
import 'ui/home/home_screen.dart';
import 'ui/home/available_shops_screen.dart';
import 'ui/chatbox/chat_screen.dart';
import 'ui/manage_vehicle/add_vehicle_screen.dart';
import 'ui/manage_vehicle/user_vehicle_list_screen.dart';
import 'ui/profile/edit_user_address_screen.dart';
import 'ui/profile/edit_user_bio_screen.dart';
import 'ui/profile/edit_user_name_screen.dart';
import 'ui/profile/user_profile_screen.dart';
import 'ui/shop/shop_screen.dart';
import 'ui/shop/service_booking_screen.dart';

//misc
import 'service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await setupLocator();
  // _setupLogging();
  // debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (ctx) => HomeScreen()),
      home: StreamBuilder(
        stream: firebaseAuth.authStateChanges(),
        builder: (ctx, userSnapshot) {
          print('user found');
          if (userSnapshot.hasData) {
            return HomeScreen();
          }
          print('user lost');

          return LoginScreen();
        },
      ),
      routes: {
        // '/': (ctx) => LoginScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignupScreen.routeName: (ctx) => SignupScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        AvailableShopsScreen.routeName: (ctx) => AvailableShopsScreen(),
        // ChatScreen.routeName: (ctx) => const ChatScreen(),
        ShopScreen.routeName: (ctx) => const ShopScreen(),
        ServiceBookingScreen.routeName: (ctx) => const ServiceBookingScreen(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
        // EditUserAddressScreen.routeName: (ctx) => EditUserAddressScreen(),
        // EditUserNameScreen.routeName: (ctx) => EditUserNameScreen(),
        // EditUserBioScreen.routeName: (ctx) => EditUserBioScreen(),
        AddNewVehicleScreen.routeName: (ctx) => AddNewVehicleScreen(),
        UserVehicleListScreen.routeName: (ctx) => UserVehicleListScreen(),
        ServiceDetails.routeName: (ctx) => ServiceDetails(),
        // PaymentScreen.routeName: (ctx) => PaymentScreen(),
        BookingsScreen.routeName: (ctx) => BookingsScreen(),
        GetLocationScreen.routeName: (ctx) => GetLocationScreen(),
        BookingDetailsScreen.routeName: (ctx) => BookingDetailsScreen(),
        // ChatScreen.routeName: (ctx) => const ChatScreen(),
      },
    );
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
