import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tu_agenda_ya/global/controller/global_controller.dart';
import 'package:tu_agenda_ya/global/model/store_model.dart';

class StoreSlider extends StatefulWidget {
  final String title;
  final List<StoreModel> stores;
  final bool isLoading;

  const StoreSlider({
    super.key,
    required this.title,
    required this.stores,
    required this.isLoading,
  });

  @override
  State<StoreSlider> createState() => _StoreSliderState();
}

class _StoreSliderState extends State<StoreSlider> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 1);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 225,
          width: double.infinity,
          child: widget.isLoading
              ? _buildShimmerLoader()
              : widget.stores.isEmpty
                  ? const Center(child: Text('No hay tiendas disponibles'))
                  : _buildPageView(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildShimmerLoader() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
          left: index == 0 ? 16 : 8,
          right: 8,
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 16),
      itemCount: widget.stores.length,
      itemBuilder: (context, index) {
        return Container(
          width: 168,
          margin: const EdgeInsets.only(right: 12),
          child: _buildStoreCard(widget.stores[index]),
        );
      },
    );
  }

  Widget _buildStoreCard(StoreModel store) {
    final imageUrl = store.images.isNotEmpty
        ? Supabase.instance.client.storage
            .from('store.images')
            .getPublicUrl(store.images.first)
        : null;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  imageUrl ?? '',
                  height: 130,
                  width: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image, size: 60),
                ),
              ),
              Positioned(
                right: -3,
                top: -3,
                child: IconButton(
                  icon: FutureBuilder<bool>(
                    future: Get.find<GlobalController>().isFavorite(store),
                    builder: (context, snapshot) {
                      final isFav = snapshot.data ?? false;
                      return Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.white,
                      );
                    },
                  ),
                  onPressed: () async {
                    await Get.find<GlobalController>().toggleFavorite(store);
                    setState(() {});
                  },
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14),
                    const SizedBox(width: 4),
                    Text('${store.distance?.toStringAsFixed(1)} km'),
                    const SizedBox(width: 10),
                    const Icon(Icons.access_time, size: 14),
                    const SizedBox(width: 4),
                    Text(store.estimatedTime ?? '0 min'),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '${store.rating!.toStringAsFixed(1)}/5 (${store.reviewCount})',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
