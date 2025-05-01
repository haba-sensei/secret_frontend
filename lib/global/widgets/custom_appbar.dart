import 'package:flutter/material.dart';
import 'package:tu_agenda_ya/core/utils/colors_style.dart';
import 'package:get/get.dart';
import 'package:tu_agenda_ya/global/controller/global_controller.dart';
import 'package:tu_agenda_ya/routes/routes_names.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final int notificationCount;

  const CustomAppbar({
    super.key,
    this.notificationCount = 10,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(
        init: GlobalController(),
        builder: (GlobalController cntrl) {
          return AppBar(
            backgroundColor: MyColors.primaryColor,
            elevation: 0,
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: Obx(() {
              final user = cntrl.userLoad.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() {
                    final avatarUrl = cntrl.userLoad.value.avatarUrl;

                    return CircleAvatar(
                      radius: 25,
                      backgroundImage: avatarUrl != null && avatarUrl.isNotEmpty
                          ? NetworkImage(avatarUrl)
                          : const AssetImage('assets/240-1.png')
                              as ImageProvider,
                    );
                  }),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      cntrl.toTitleCase(user.fullName.toString()),
                      style: TextStyle(
                        color: MyColors.baseTextColorWhite,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
              );
            }),
            actions: [
              IconButton(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: MyColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    if (notificationCount > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Center(
                            child: Text(
                              notificationCount > 9
                                  ? '9+'
                                  : notificationCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () => {
                  cntrl.updatePageIndex(9),
                  Get.toNamed(Routes.notifications)
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () =>
                    {cntrl.updatePageIndex(9), Get.toNamed(Routes.settings)},
              ),
            ],
          );
        });
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
