import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/firebase_options.dart';

import 'core/app_export.dart';
import 'data/sevices/firebase_messageing_service.dart';
import 'data/sevices/notification_service.dart';
import 'data/sevices/stripe_service.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessagingService.initialize();
  await FirebaseMessagingService.generateToken();
  await NotificationService.initialize();
  await PrefUtils().init();
  Stripe.publishableKey = StripePaymentHandle.PUBLISHABLE_KEY;
  Stripe.merchantIdentifier = 'any string works';
  await Stripe.instance.applySettings();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(MyApp(navigatorKey: navigationKey));
  });

  // update use status on every minutes
  Timer.periodic(const Duration(minutes: 1), (Timer timer) {
    if (PrefUtils.getId().isNotEmpty) {
      UserModel userModel = UserModel(lasOnline: Timestamp.now());
      FirebaseServices.updateUser(userModel);
    }
  });
}

class MyApp extends StatefulWidget {
  @override
  const MyApp({Key? key, required this.navigatorKey}) : super(key: key);
  final GlobalKey navigatorKey;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        navigatorKey: navigationKey,
        debugShowCheckedModeBanner: false,
        theme: theme,
        translations: LocalizationService(),
        locale: Locale(PrefUtils.getLang()), //for setting localization strings
        fallbackLocale: Locale('en', 'US'),
        title: 'mifever',
        initialBinding: InitialBindings(),
        initialRoute: AppRoutes.initialRoute,
        getPages: AppRoutes.pages,
      );
    });
  }
}

// void updateLastOnline() {
//   FIREBASE_FIRESTORE
//       .collection(USER_COLLECTION)
//       .doc(PrefUtils.getCurrentUserID())
//       .update({
//     'last_online': FieldValue.serverTimestamp(),
//   });
// }
// on App's user login initialize user in zegoCloud

// void onUserLogin() {
//   ZegoUIKitPrebuiltCallInvitationService().init(
//     notifyWhenAppRunningInBackgroundOrQuit: true,
//     appID: 205087729 /*input your AppID*/,
//     appSign:
//         'bc006c998c5b5fafcc21d32f67529d5dbb4e5b394c0598a6a9cf594dc249d1a2' /*input your AppSign*/,
//     userID: PrefUtils.getId(),
//     userName: PrefUtils.getUserName(),
//     plugins: [ZegoUIKitSignalingPlugin()],
//   );
// }

/// on App's user logout
// void onUserLogout() {
//   ZegoUIKitPrebuiltCallInvitationService().uninit();
// }
