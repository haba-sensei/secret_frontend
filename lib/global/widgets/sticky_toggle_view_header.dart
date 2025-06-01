import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tu_agenda_ya/global/controller/global_controller.dart';
import 'package:tu_agenda_ya/global/widgets/toggle_view_btn.dart';
import 'package:tu_agenda_ya/routes/routes_names.dart';

class StickyToggleViewHeaderWidget extends StatelessWidget {
  const StickyToggleViewHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cntrl = Get.find<GlobalController>();
    return Container(
      color: Colors.white,
      child: ToggleViewButtons(
        onMapPressed: () {
          cntrl.updatePageIndex(9);
          Get.toNamed(Routes.storesMap);
        },
        onListPressed: () {
          cntrl.updatePageIndex(9);
          Get.toNamed(Routes.storesList);
        },
      ),
    );
  }
}
