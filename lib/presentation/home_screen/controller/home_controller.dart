// ignore_for_file: sdk_version_since

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/models/notification/notification.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/data/sevices/location_service.dart';
import 'package:mifever/presentation/home_screen/models/home_model.dart';

import '../../../data/models/filter/filter_model.dart';
import '../../../data/models/user/user_model.dart';
import '../../../data/sevices/firebase_messageing_service.dart';

class HomeController extends GetxController {
  Rx<HomeModel> homeModelObj = HomeModel().obs;

  var userList = <UserModel>[].obs;

  RxInt thermoValue = 0.obs;

  RxInt userLength = 0.obs;

  void onSwipe(
      {required String type,
      required String notificationTo,
      required String token}) async {
    NotificationModel notificationModel = NotificationModel(
      type: type,
      notificationTo: notificationTo,
      notificationBy: PrefUtils.getId(),
      createdAt: DateTime.now().toString(),
    );
    await FirebaseServices.addNotification(notificationModel);
  }

  void sendNotification({required UserModel user, required String type}) async {
    await FirebaseMessagingService.sendNotification(
      token: user.token!,
      title: type == NotificationType.Like.name
          ? '${user.name} ' + "lbl_liked_your_profile".tr
          : '${user.name} ' + "lbl_viewed_your_profile".tr,
      body: '',
      payload: "${user.id}",
    );
  }

  Future<List<UserModel>> getUser() async {
    PreferenceFilter? filter = await PrefUtils.getFilter();
    try {
      return getUsersFiltered(
        minAge: filter?.ageRangeStart.round() ?? 0,
        maxAge: filter?.ageRangeEnd.round() ?? 0,
        maxDistance: filter?.distance ?? 960,
        gender: filter?.interestedIn ?? 'Female',
        currentUserLocation: GeoPoint(filter?.lat ?? 0, filter?.lng ?? 0),
      ).then((value) {
        userList.addAll(value);

        return userList;
      });
    } catch (e) {
      print('error===>$e');
      return <UserModel>[];
    }
  }

  Future<List<UserModel>> getUsersFiltered({
    required int minAge,
    required int maxAge,
    required double maxDistance,
    required String gender,
    required GeoPoint currentUserLocation,
  }) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('id', isNotEqualTo: PrefUtils.getId())
        .where('isProfileComplete', isEqualTo: true)
        .get();
    List<UserModel> users = [];
    List<String> _disLikeUsersId = [];
    List<NotificationModel> _dislikeNotifications =
        await FirebaseServices.allDisLikedUserByMe();
    for (var user in _dislikeNotifications) {
      _disLikeUsersId.add(user.notificationTo);
    }
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
      UserModel user = UserModel.fromJson(userData);
      GeoPoint userLocation = user.location!;
      var distance = calculateDistance(userLocation, currentUserLocation);
      if (!_disLikeUsersId.contains(user.id) &&
          (calculateAgeFromString(user.dob!) >= minAge) &&
          (calculateAgeFromString(user.dob!) <= maxAge) &&
          (user.gender == gender) &&
          (distance <= maxDistance)) {
        users.add(UserModel.fromJson(userData));
      }
    });
    userList.clear();
    userList.addAll(users);
    return users;
  }

  double calculateDistance(GeoPoint point1, GeoPoint point2) {
    final lat1 = point1.latitude;
    final lon1 = point1.longitude;
    final lat2 = point2.latitude;
    final lon2 = point2.longitude;

    final p = 0.017453292519943295;
    final c = cos;

    final a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    final distance = 12742 * asin(sqrt(a));

    return distance;
  }

  void getThemometerValue(String receiverId) async {
    thermoValue.value = await FirebaseServices.getThermometerValue(receiverId);
  }

  setUserLength(int length) {
    userLength.value = length;
  }

  @override
  void onInit() {
    super.onInit();
    LocationService.getLocationAndSave();
    FirebaseServices.listenToFieldChanges();
    getUser();
  }
}
