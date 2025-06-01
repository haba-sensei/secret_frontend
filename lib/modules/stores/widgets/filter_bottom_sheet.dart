import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tu_agenda_ya/core/utils/colors_style.dart';
import 'package:tu_agenda_ya/core/utils/funtions.dart';
import 'package:tu_agenda_ya/modules/stores/controller/stores_controller.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final controller = Get.find<StoresController>();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      controller.filtrarDistritos(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> applyFilters() async {
    if (controller.departamentoSeleccionado.value.isEmpty ||
        controller.distritoSeleccionado.isEmpty ||
        controller.serviciosSeleccionados.isEmpty) {
      Get.snackbar(
          "Error", "Selecciona departamento, distrito y al menos un servicio.");
      return;
    }

    final rawCoords =
        controller.distritoSeleccionado['coordenadas'] as List<dynamic>?;

    if (rawCoords == null || rawCoords.isEmpty) {
      Get.snackbar("Error", "No se encontraron coordenadas del distrito.");
      return;
    }

    final coords = rawCoords.map((c) {
      final lat = (c['lat'] as num).toDouble();
      final lng = (c['lng'] as num).toDouble();
      return LatLng(lat, lng);
    }).toList();

    if (coords.first != coords.last) {
      coords.add(coords.first);
    }

    await controller.aplicarFiltro(
      coordenadas: coords,
      serviceIds: controller.serviciosSeleccionados,
    );

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: MediaQuery.of(context).size.height * 0.95,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 80),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text("Filtro",
                            style: TextStyle(
                                color: MyColors.primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: controller.departamentoSeleccionado.value.isEmpty
                            ? null
                            : controller.departamentoSeleccionado.value,
                        hint: const Text('Selecciona un departamento'),
                        items: controller.departamentos.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.seleccionarDepartamento(value);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: controller.provinciaSeleccionada.value.isEmpty
                            ? null
                            : controller.provinciaSeleccionada.value,
                        hint: const Text('Selecciona una provincia'),
                        items: controller.provinciasPorDepartamento[
                                    controller.departamentoSeleccionado.value]
                                ?.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList() ??
                            [],
                        onChanged: (value) {
                          if (value != null) {
                            controller.seleccionarProvincia(value);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: controller.distritoSeleccionado['distrito'],
                        hint: const Text('Selecciona un distrito'),
                        items: controller.distritosFiltrados.map((distrito) {
                          return DropdownMenuItem<String>(
                            value: distrito['distrito'],
                            child: Text(distrito['distrito']),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            final selected = controller.distritosFiltrados
                                .firstWhere((d) => d['distrito'] == value);
                            controller.distritoSeleccionado.value = selected;
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text("Selecciona los servicios",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    Obx(() => Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          children: controller.tiposDeServicios.map((service) {
                            final id = service['id'] as int;
                            final isSelected =
                                controller.serviciosSeleccionados.contains(id);
                            final icon = typeStoreIconsById[id] ?? Icons.store;

                            return FilterChip(
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    icon,
                                    size: 18,
                                    color: isSelected
                                        ? MyColors.baseTextColorWhite
                                        : MyColors.baseTextColorBlack,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    service['name'] as String,
                                    style: TextStyle(
                                      color: isSelected
                                          ? MyColors.baseTextColorWhite
                                          : MyColors.baseTextColorBlack,
                                    ),
                                  ),
                                ],
                              ),
                              selected: isSelected,
                              onSelected: (_) {
                                controller.toggleServicioSeleccionado(id);
                              },
                              selectedColor: MyColors.primaryColor,
                              showCheckmark: false,
                            );
                          }).toList(),
                        ))
                  ],
                ),
              ),
            ),
            bottomSheet: SafeArea(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: applyFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Aplicar Filtro",
                      style: TextStyle(
                          color: MyColors.baseTextColorWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
        ));
  }
}
