import 'dart:math';
import 'package:tu_agenda_ya/core/utils/colors_style.dart';
import 'package:tu_agenda_ya/global/controller/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Drawer3D extends StatelessWidget {
  final Widget body;
  const Drawer3D({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(
      init: GlobalController(),
      builder: (GlobalController cntrl) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  width: 200.0,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Obx(() {
                        final user = cntrl.userLoad.value;
                        return DrawerHeader(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50.0,
                                backgroundImage: NetworkImage(
                                  user.avatarUrl.toString(),
                                ),
                              ),
                              const SizedBox(height: 10.0),
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
                            ],
                          ),
                        );
                      }),
                      Expanded(
                        child: ListView(
                          children: [
                            ListTile(
                              onTap: () {},
                              leading: const Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                              title: Text(
                                "Inicio",
                                style: TextStyle(
                                  color: MyColors.baseTextColorWhite,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            ListTile(
                              onTap: () {},
                              leading: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              title: Text(
                                "Perfil",
                                style: TextStyle(
                                  color: MyColors.baseTextColorWhite,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            ListTile(
                              onTap: () {},
                              leading: const Icon(
                                Icons.book_rounded,
                                color: Colors.white,
                              ),
                              title: Text(
                                "Ordenes",
                                style: TextStyle(
                                  color: MyColors.baseTextColorWhite,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            ListTile(
                              onTap: () => cntrl.userLogOut(),
                              leading: const Icon(
                                Icons.login_outlined,
                                color: Colors.white,
                              ),
                              title: Text(
                                "Logout",
                                style: TextStyle(
                                  color: MyColors.baseTextColorWhite,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: cntrl.drawerValue),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                builder: (_, double val, __) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..setEntry(0, 3, 200 * val)
                      ..rotateY((pi / 6) * val),
                    child: Scaffold(
                        // appBar: SimpleAppBar(
                        //   onMenuPressed: () {
                        //     cntrl.toggleDrawer();
                        //   },
                        // ),
                        // body: GestureDetector(
                        //   onTap: () {
                        //     cntrl.closeDrawer();
                        //   },
                        //   onHorizontalDragUpdate: (details) {
                        //     if (cntrl.drawerValue > 0 && details.delta.dx < 0) {
                        //       cntrl.closeDrawer();
                        //     }
                        //   },
                        //   child: Text('asdasd'),
                        // ),
                        ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
