import 'dart:async';

import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/models/subscriptions/subscription_model.dart';
import 'package:mifever/data/models/thermometer_model/thermometer_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/profile_screen/models/profile_model.dart';

class ProfileController extends GetxController {
  Rx<ProfileModel> profileModelObj = ProfileModel().obs;
  RxBool isWayAlbum = true.obs;
  Rx<int> sliderIndex = 0.obs;
  RxDouble progress = 0.0.obs;
  RxBool isPlaying = false.obs;
  RxString planName = ''.obs;

  void addThemometerValue({required int value, required String id}) async {
    ThermometerModel thermometerModel = ThermometerModel(
      roomId: FirebaseServices.createChatRoomId(id),
      percentageValue: value,
    );
    await FirebaseServices.addThermometerValue(thermometerModel);
  }

  late Timer _timer;
  RxInt _elapsedSeconds = 0.obs;

  void addThermometer(String userId) async {
    int _value = 0;
    await FirebaseServices.getThermometerValue(userId).then((value) {
      _value = value.round();
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (isPlaying.value) {
        if (progress.value < 1) {
          print(progress.value);
          progress.value = progress.value + 0.2;
        } else {
          isPlaying.value = false;
        }
      }
      _elapsedSeconds.value++;
      //print(_elapsedSeconds.value);
      if (_elapsedSeconds.value == 15) {
        if (_value == 0) {
          addThemometerValue(value: 20, id: userId);
        }
      } else if (_elapsedSeconds.value == 30) {
        FirebaseServices.getThermometerValue(userId).then((value) {
          _value = value.round();
        });
        if (_value == 20) {
          addThemometerValue(value: 30, id: userId);
        }
      } else if (_elapsedSeconds.value == 60) {
        FirebaseServices.getThermometerValue(userId).then((value) {
          _value = value.round();
        });
        if (_value == 30) {
          addThemometerValue(value: 50, id: userId);
        }
      }
    });
  }

  getSubscription() async {
    SubscriptionModel? subscriptionModel =
        await FirebaseServices.getSubscription();
    if (subscriptionModel != null) {
      planName.value = subscriptionModel.plan.id!.value;
      print('plan==>${planName.value}');
    }
  }

  @override
  void onInit() {
    getSubscription();
    super.onInit();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
