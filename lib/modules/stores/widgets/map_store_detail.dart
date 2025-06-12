import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tu_agenda_ya/modules/stores/controller/stores_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tu_agenda_ya/modules/stores/widgets/store_detail_bottom_sheet.dart';

class StoreDetailCard extends StatelessWidget {
  const StoreDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<StoresController>(
      builder: (cntrl) {
        final store = cntrl.detailStoreView.value;
        if (store == null) return const SizedBox.shrink();

        final supabase = Supabase.instance.client;

        final images = store['images'];
        if (images is List && images.isNotEmpty) {
          store['imageUrl'] = supabase.storage
              .from('store.images')
              .getPublicUrl(images.first as String);
        } else {
          store['imageUrl'] = null;
        }

        return Positioned(
          left: 0,
          right: 0,
          bottom: MediaQuery.of(context).padding.bottom + 10,
          child: GestureDetector(
            onTap: () {
              final storeData = Map<String, dynamic>.from(store);
              Get.bottomSheet(
                StoreDetailBottomSheet(store: storeData),
                isScrollControlled: true,
                isDismissible: false,
                enableDrag: false,
                backgroundColor: Colors.white,
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withAlpha(51),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Imagen
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      store['imageUrl'] ?? '',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image_not_supported),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                store['name'] ?? 'Nombre desconocido',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                cntrl.detailStoreView.value = null;
                                cntrl.selectedStoreId.value = null;
                              },
                              child: const Icon(Icons.close, size: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          store['location'] ?? 'Ubicación desconocida',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                size: 16, color: Colors.orange),
                            const SizedBox(width: 4),
                            Text(
                              "${store['out_rating'] ?? 0}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "(${store['reviewcount'] ?? 0})",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(width: 12),
                            const Icon(Icons.directions_run_rounded,
                                size: 17, color: Colors.orange),
                            const SizedBox(width: 4),
                            Text("(${store['estimatedTime'] ?? 0} aprox)",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(width: 12),
                            const Icon(Icons.location_on_outlined,
                                size: 16, color: Colors.orange),
                            const SizedBox(width: 4),
                            Text("${store['distance']?.toStringAsFixed(1)} km",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
