// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:logger/logger.dart';
// import 'package:maplibre_gl/maplibre_gl.dart';
// import 'package:tu_agenda_ya/modules/home/controller/home_controller.dart';

// class HomeLogic extends StatefulWidget {
//   const HomeLogic({super.key});

//   @override
//   HomeLogicState createState() => HomeLogicState();
// }

// class HomeLogicState extends State<HomeLogic> {
//   late MapLibreMapController mapController;

//   @override
//   Widget build(BuildContext context) {
//     var logger = Logger();
//     return GetX<HomeController>(
//       init: HomeController(),
//       builder: (cntrl) {
//         if (cntrl.isLoading.value) {
//           return const SafeArea(
//             child: Center(
//               child: Text('Cargando Home...'),
//             ),
//           );
//         }

//         if (cntrl.errorMessage.isNotEmpty) {
//           logger.e("Error: ${cntrl.errorMessage.value}");
//           return Center(child: Text(cntrl.errorMessage.value));
//         }

//         return Scaffold(
//           body: SafeArea(
//             child: FutureBuilder<String>(
//               future: cntrl.loadMapStyle(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (snapshot.hasError) {
//                   return Center(
//                       child: Text('Error al cargar el estilo del mapa'));
//                 }

//                 if (!snapshot.hasData) {
//                   return Center(child: Text('Estilo no disponible'));
//                 }

//                 return MapLibreMap(
//                   styleString: snapshot.data!,
//                   initialCameraPosition: CameraPosition(
//                     target: LatLng(cntrl.latitude.value, cntrl.longitude.value),
//                     zoom: 18,
//                   ),
//                   onMapCreated: (MapLibreMapController controller) {
//                     mapController = controller;
//                     cntrl.updateMapPosition(mapController);
//                     cntrl.addMarker(mapController);
//                   },
//                   onStyleLoadedCallback: () {},
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:location/location.dart';
// import 'package:maplibre_gl/maplibre_gl.dart';

// class HomeController extends GetxController {
//   var isLoading = true.obs;
//   var errorMessage = ''.obs;
//   var latitude = 0.0.obs;
//   var longitude = 0.0.obs;

//   final Location _location = Location();

//   @override
//   void onInit() {
//     super.onInit();
//     _getUserLocation();
//   }

//   Future<String> loadMapStyle() async {
//     try {
//       return await rootBundle.loadString('assets/style_map.json');
//     } catch (e) {
//       errorMessage.value = 'Error al cargar el estilo del mapa: $e';
//       return '';
//     }
//   }

//   Future<void> _getUserLocation() async {
//     try {
//       bool serviceEnabled = await _location.serviceEnabled();
//       if (!serviceEnabled) {
//         serviceEnabled = await _location.requestService();
//         if (!serviceEnabled) {
//           errorMessage.value = 'Servicio de ubicación no habilitado.';
//           isLoading.value = false;
//           return;
//         }
//       }

//       PermissionStatus permissionGranted = await _location.hasPermission();
//       if (permissionGranted == PermissionStatus.denied) {
//         permissionGranted = await _location.requestPermission();
//         if (permissionGranted != PermissionStatus.granted) {
//           errorMessage.value = 'Permiso de ubicación denegado.';
//           isLoading.value = false;
//           return;
//         }
//       }

//       LocationData locationData = await _location.getLocation();
//       latitude.value = locationData.latitude ?? 0.0;
//       longitude.value = locationData.longitude ?? 0.0;
//     } catch (e) {
//       errorMessage.value = 'Error obteniendo ubicación: $e';
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void updateMapPosition(MapLibreMapController controller) {
//     if (latitude.value != 0.0 && longitude.value != 0.0) {
//       controller.animateCamera(
//         CameraUpdate.newLatLngZoom(
//           LatLng(latitude.value, longitude.value),
//           17.0,
//         ),
//       );
//     }
//   }

//   Future<void> addMarker(MapLibreMapController controller) async {
//     if (latitude.value != 0.0 && longitude.value != 0.0) {
//       // Registra la imagen del marcador antes de usarla
//       await controller.addImage(
//         'logo_sin_fondo', // Nombre que se usará para el icono
//         await _loadIconImage(),
//       );

//       // Luego, agrega el marcador usando la imagen registrada
//       controller.addSymbol(SymbolOptions(
//         geometry: LatLng(latitude.value, longitude.value),
//         iconImage: 'logo_sin_fondo', // Nombre registrado del icono
//       ));
//     }
//   }

//   // Método para cargar la imagen del marcador
//   Future<Uint8List> _loadIconImage() async {
//     final ByteData data = await rootBundle.load('assets/logo_sin_fondo.png');
//     return data.buffer.asUint8List();
//   }
// }
