import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tu_agenda_ya/modules/stores/controller/stores_controller.dart';
import 'package:tu_agenda_ya/modules/stores/widgets/map_bottom_sheet.dart';
import 'package:tu_agenda_ya/modules/stores/widgets/map_center_location.dart';
import 'package:tu_agenda_ya/modules/stores/widgets/map_marker_layer.dart';
import 'package:tu_agenda_ya/modules/stores/widgets/map_poligon_layer.dart';
import 'package:tu_agenda_ya/modules/stores/widgets/map_store_detail.dart';
import 'package:tu_agenda_ya/modules/stores/widgets/map_tile_layer.dart';

class StoresMapLogic extends StatelessWidget {
  const StoresMapLogic({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<StoresController>(
      init: StoresController(),
      builder: (cntrl) {
        final LatLng location = cntrl.userLocation.value;

        final bool locationReady =
            location.latitude != 0.0 && location.longitude != 0.0;

        if (!locationReady) {
          return const SizedBox.shrink();
        }

        return Stack(
          children: [
            FlutterMap(
              mapController: cntrl.mapController,
              options: MapOptions(
                initialCenter: location,
                initialZoom: 16.0,
                minZoom: 10.0,
              ),
              children: const [
                MapTileLayer(),
                MapPoligonLayer(),
                MapMarkerLayer(),
                MapCenterLocation(),
                MapBottomSheet(),
                StoreDetailCard(),
              ],
            ),
          ],
        );
      },
    );
  }
}
