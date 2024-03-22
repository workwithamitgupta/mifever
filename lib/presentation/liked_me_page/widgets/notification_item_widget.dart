import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../../../widgets/thermometer_widget.dart';
import '../controller/liked_me_controller.dart';
import '../models/notification_item_model.dart';

// ignore: must_be_immutable
class NotificationItemWidget extends StatelessWidget {
  NotificationItemWidget(
    this.notificationItemModelObj, {
    Key? key,
  }) : super(key: key);

  NotificationItemModel notificationItemModelObj;

  var controller = Get.find<LikedMeController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(
          () => CustomImageView(
            imagePath: notificationItemModelObj.notificationImage!.value,
            height: 40.h,
            width: 40.v,
            radius: BorderRadius.circular(
              20.h,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 8.h,
            top: 11.v,
            bottom: 8.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 210.v),
                child: Text(
                  notificationItemModelObj.notificationText!.value,
                  style: theme.textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                notificationItemModelObj.time == null
                    ? DateTime.now().toLocal().toString()
                    : getTimeAgo(DateTime.parse(
                        notificationItemModelObj.time?.value ?? '')),
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
        Spacer(),
        SizedBox(height: 40.v, width: 19.h, child: ThermoTest(value: 0.5)),
        Padding(
          padding: EdgeInsets.only(
            left: 4.h,
            top: 6.v,
            bottom: 16.v,
          ),
          child: Obx(
            () => Text(
              notificationItemModelObj.notificationText1!.value,
              style: theme.textTheme.labelLarge,
            ),
          ),
        ),
      ],
    );
  }
}
