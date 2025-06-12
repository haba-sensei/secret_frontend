import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tu_agenda_ya/core/utils/colors_style.dart';
import 'package:tu_agenda_ya/modules/stores/controller/stores_controller.dart';
import 'package:tu_agenda_ya/modules/stores/widgets/filter_bottom_sheet.dart';

class MapBottomSheet extends StatelessWidget {
  const MapBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<StoresController>(builder: (cntrl) {
      final hasDetail = cntrl.detailStoreView.value != null;
      final bottomOffset = hasDetail
          ? MediaQuery.of(context).padding.bottom + 130
          : MediaQuery.of(context).padding.bottom + 20;

      return Positioned(
        bottom: bottomOffset,
        right: 16,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.baseTextColorWhite,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: const StadiumBorder(),
            elevation: 4,
          ),
          onPressed: () {
            if (Get.isBottomSheetOpen != true) {
              Get.bottomSheet(
                const FilterBottomSheet(),
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
              );
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search,
                size: 24,
                color: MyColors.primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                'Buscar',
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
    });
  }
}
