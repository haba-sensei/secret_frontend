import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tu_agenda_ya/core/utils/colors_style.dart';
import 'package:tu_agenda_ya/global/controller/global_controller.dart';
import 'package:tu_agenda_ya/routes/routes_names.dart';

class CustomBottomAppbar extends StatelessWidget {
  const CustomBottomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(
        init: GlobalController(),
        builder: (GlobalController cntrl) {
          final bottomBarController = BottomBarWithSheetController(
              initialIndex: cntrl.selectedPageIndex.value);
          return SafeArea(
            child: BottomBarWithSheet(
              autoClose: true,
              controller: bottomBarController,
              sheetChild: Center(
                child: Text(
                  "Another content",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              bottomBarTheme: BottomBarTheme(
                  height: 80,
                  heightClosed: 80,
                  heightOpened: 500,
                  mainButtonPosition: MainButtonPosition.middle,
                  selectedItemIconColor: MyColors.primaryColor,
                  itemIconColor: Colors.grey[500],
                  decoration: BoxDecoration(
                    color: MyColors.baseTextColorWhite,
                  ),
                  itemIconSize: 28,
                  selectedItemIconSize: 28),
              mainActionButtonTheme: MainActionButtonTheme(
                size: 65,
                color: MyColors.primaryColor,
                splash: MyColors.secondaryColor,
                icon: const Icon(
                  Icons.calendar_month_rounded,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              items: [
                BottomBarWithSheetItem(icon: Icons.home_rounded, label: 'Home'),
                BottomBarWithSheetItem(
                    icon: Icons.message_rounded, label: 'Chat'),
                BottomBarWithSheetItem(
                    icon: Icons.favorite, label: 'Favoritos'),
                BottomBarWithSheetItem(
                    icon: Icons.logout_outlined, label: 'Logout'),
              ],
              onSelectItem: (index) {
                if (cntrl.selectedPageIndex.value == index) {
                  cntrl.updatePageIndex(cntrl.selectedPageIndex.value);
                }
                cntrl.updatePageIndex(index);
                Future.delayed(const Duration(milliseconds: 300), () {
                  switch (index) {
                    case 0:
                      Get.offNamed(Routes.home, preventDuplicates: true);
                      break;
                    case 1:
                      Get.toNamed(Routes.chat, preventDuplicates: true);
                      break;
                    case 2:
                      Get.offNamed(Routes.favoritos, preventDuplicates: true);
                      break;
                    case 3:
                      cntrl.userLogOut();
                      break;
                  }
                });
              },
            ),
          );
        });
  }
}
