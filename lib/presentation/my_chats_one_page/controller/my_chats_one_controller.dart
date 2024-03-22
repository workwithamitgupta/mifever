import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/my_chats_one_page/models/my_chats_one_model.dart';

class MyChatsOneController extends GetxController {
  MyChatsOneController(this.myChatsOneModelObj);

  Rx<MyChatsOneModel> myChatsOneModelObj;
  final searchController = TextEditingController();
  var query = ''.obs;
  var isSelected = false.obs;
  var isSearch = false.obs;
  RxList selectedUser = [].obs;

  void onDeleteChat() async {
    ProgressDialogUtils.showProgressDialog();
    for (var user in selectedUser) {
      await FirebaseServices.deleteChats(user);
    }
    ProgressDialogUtils.hideProgressDialog();
    selectedUser.clear();
    isSelected.value = false;
  }

  bool isVisible(String name) {
    if (query.value.isEmpty) {
      return true;
    }
    if (name.toLowerCase().contains(query.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }
}
