import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tu_agenda_ya/modules/stores/controller/stores_controller.dart';

class MapPoligonLayer extends StatelessWidget {
  const MapPoligonLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<StoresController>(
        init: StoresController(),
        builder: (cntrl) {
          return PolygonLayer(
            polygons: [
              if (cntrl.distritoSeleccionado.isNotEmpty &&
                  cntrl.distritoSeleccionado['coordenadas'] != null)
                Polygon(
                  points: (cntrl.distritoSeleccionado['coordenadas']
                          as List<dynamic>)
                      .map((coord) => LatLng((coord['lat'] as num).toDouble(),
                          (coord['lng'] as num).toDouble()))
                      .toList(),
                  color: Colors.orange.withAlpha(51),
                  borderColor: Colors.orange,
                  borderStrokeWidth: 2,
                )
            ],
          );
        });
  }
}
