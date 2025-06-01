import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tu_agenda_ya/core/utils/funtions.dart';
import 'package:tu_agenda_ya/modules/stores/controller/stores_controller.dart';

class MapMarkerLayer extends StatelessWidget {
  const MapMarkerLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<StoresController>(
        init: StoresController(),
        builder: (cntrl) {
          return MarkerLayer(
            markers: [
              Marker(
                point: cntrl.userLocation.value,
                width: 30,
                height: 30,
                child: const Icon(
                  Icons.my_location,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
              ...cntrl.stores.map((store) {
                final typeId = store['type_store_id'] as int?;
                final icon = typeStoreIconsById[typeId] ?? Icons.store;
                final color = parseColor(store['color']) ?? Colors.red;

                return Marker(
                  point: LatLng(store['lat'], store['lng']),
                  width: 30,
                  height: 30,
                  child: Icon(
                    icon,
                    color: color,
                    size: 30,
                  ),
                );
              }),
            ],
          );
        });
  }
}
