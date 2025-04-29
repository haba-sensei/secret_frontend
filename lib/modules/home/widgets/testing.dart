// import 'package:flutter/material.dart';
// import 'package:maplibre_gl/maplibre_gl.dart';

// class MapParentWidgetState extends State<MapParentWidget> {
//   final Completer<MapLibreMapController> mapController = Completer();
//   bool canInteractWithMap = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonLocation:
//           FloatingActionButtonLocation.miniCenterFloat,
//       floatingActionButton: canInteractWithMap
//           ? FloatingActionButton(
//               onPressed: _moveCameraToNullIsland,
//               mini: true,
//               child: const Icon(Icons.restore),
//             )
//           : null,
//       body: MapLibreMap(
//         onMapCreated: (controller) => mapController.complete(controller),
//         initialCameraPosition: _nullIsland,
//         onStyleLoadedCallback: () => setState(() => canInteractWithMap = true),
//       ),
//     );
//   }

//   void _moveCameraToNullIsland() => mapController.future.then(
//       (c) => c.animateCamera(CameraUpdate.newCameraPosition(_nullIsland)));
// }
