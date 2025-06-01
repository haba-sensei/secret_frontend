import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tu_agenda_ya/core/utils/colors_style.dart';
import 'package:tu_agenda_ya/modules/home/controller/home_controller.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        final services = controller.servicios;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Servicios',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: services.isEmpty
                  ? _buildShimmerLoader()
                  : _buildServicesGrid(services),
            ),
          ],
        );
      },
    );
  }

  Widget _buildServicesGrid(List<Map<String, dynamic>> services) {
    final rows = <Widget>[];
    for (int i = 0; i < services.length; i += 4) {
      final rowItems = services.skip(i).take(4).map((service) {
        return ServiceItem(
          icon: service['icon'],
          label: service['label'],
        );
      }).toList();

      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: rowItems,
          ),
        ),
      );
    }

    return Column(children: rows);
  }

  Widget _buildShimmerLoader() {
    return Column(
      children: List.generate(2, (_) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (_) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Column(
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 12,
                      width: 50,
                      color: Colors.white,
                    )
                  ],
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}

class ServiceItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const ServiceItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: MyColors.primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 30, color: MyColors.baseTextColorWhite),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
