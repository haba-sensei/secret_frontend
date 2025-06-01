import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tu_agenda_ya/global/widgets/sticky_toggle_view_header.dart';
import 'package:tu_agenda_ya/modules/home/controller/home_controller.dart';
import 'package:tu_agenda_ya/modules/home/widgets/service_section.dart';
import 'package:tu_agenda_ya/modules/home/widgets/slider_section.dart';

class HomeLogic extends StatelessWidget {
  const HomeLogic({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return SafeArea(
      child: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              StickyToggleViewHeaderWidget(),
              const SizedBox(height: 20),
              ServicesSection(),
              const SizedBox(height: 20),
              ...controller.sliders.map(
                (slider) => StoreSlider(
                  title: slider.title,
                  stores: slider.stores,
                  isLoading: controller.isLoading.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
