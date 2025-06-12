import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreDetailBottomSheet extends StatelessWidget {
  final Map<String, dynamic> store;

  const StoreDetailBottomSheet({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Get.back(),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store['name'] ?? 'Nombre desconocido',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text("ID: ${store['id']}"),
                    Text("Ubicación: ${store['location'] ?? 'No definida'}"),
                    Text("Rating: ${store['out_rating'] ?? 0}"),
                    Text("Tiempo estimado: ${store['estimatedTime']}"),
                    Text(
                        "Distancia: ${store['distance']?.toStringAsFixed(1)} km"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
