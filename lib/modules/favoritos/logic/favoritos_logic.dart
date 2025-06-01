import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tu_agenda_ya/modules/favoritos/controller/favoritos_controller.dart';

class FavoritosLogic extends StatelessWidget {
  const FavoritosLogic({super.key});

  @override
  Widget build(BuildContext context) {
    var logger = Logger();

    return GetX<FavoritosController>(
      init: FavoritosController(),
      builder: (controller) {
        if (controller.errorMessage.isNotEmpty) {
          logger.e("Error: ${controller.errorMessage.value}");
          return SafeArea(
            child: Center(child: Text(controller.errorMessage.value)),
          );
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: controller.favoritos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final store = controller.favoritos[index];
                final imageUrl = store.images.isNotEmpty
                    ? Supabase.instance.client.storage
                        .from('store.images')
                        .getPublicUrl(store.images.first)
                    : null;

                return Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: imageUrl != null
                                  ? Image.network(
                                      imageUrl,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : const Placeholder(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    store.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on, size: 14),
                                      const SizedBox(width: 4),
                                      Text(
                                          '${store.distance?.toStringAsFixed(1) ?? '0'} km'),
                                      const SizedBox(width: 10),
                                      const Icon(Icons.access_time, size: 14),
                                      const SizedBox(width: 4),
                                      Text(store.estimatedTime ?? '0 min'),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          right: -3,
                          top: -3,
                          child: IconButton(
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              await controller.removeFavorite(store);
                              await controller.loadFavoritos();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
