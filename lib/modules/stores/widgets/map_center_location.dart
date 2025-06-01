import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tu_agenda_ya/core/utils/colors_style.dart';
import 'package:tu_agenda_ya/modules/stores/controller/stores_controller.dart';

class MapCenterLocation extends StatelessWidget {
  const MapCenterLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final cntrl = Get.find<StoresController>();
    return Positioned(
      top: MediaQuery.of(context).padding.top + 20,
      right: 16,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.baseTextColorWhite,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: const StadiumBorder(),
          elevation: 4,
        ),
        onPressed: () async {
          cntrl.centerMapOnUser();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_searching_rounded,
              size: 24,
              color: MyColors.primaryColor,
            ),
            const SizedBox(width: 8),
            Text(
              'Mi ubicación',
              style: TextStyle(
                fontSize: 17,
                color: MyColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
