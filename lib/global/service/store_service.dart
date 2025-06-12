import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/filtered_store_model.dart';
import '../model/slider_model.dart';

class StoreService {
  var logger = Logger();
  final _supabase = Supabase.instance.client;

  Future<List<SliderModel>> fetchSliders({
    required double latitude,
    required double longitude,
  }) async {
    final data = await _supabase.rpc(
      'fn_obtener_sliders',
      params: {
        'p_latitud': latitude,
        'p_longitud': longitude,
      },
    );
    if (data == null) return [];
    return (data as List<dynamic>)
        .map((e) => SliderModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<FilteredStoreModel>> getStoresByFilter(
      {required double latitude,
      required double longitude,
      required int servicioId,
      required double kilometros}) async {
    final response = await _supabase.rpc(
      'get_stores_by_filter',
      params: {
        'p_latitud': latitude,
        'p_longitud': longitude,
        'p_servicio_id': servicioId,
        'p_kilometros': kilometros
      },
    );
    if (response == null) return [];
    return (response as List<dynamic>)
        .map((e) => FilteredStoreModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Map<String, dynamic>>> getStoresMap({
    Map<String, double>? bounds,
    List<int>? typeStoreIds,
    List<Map<String, double>>? coords,
  }) async {
    final response = await _supabase.rpc('get_stores_map3', params: {
      if (bounds != null) ...{
        'min_lat': bounds['min_lat'],
        'max_lat': bounds['max_lat'],
        'min_lng': bounds['min_lng'],
        'max_lng': bounds['max_lng'],
      },
      if (typeStoreIds != null) 'type_store_ids': typeStoreIds,
      if (coords != null) '_coords': coords,
    });
    if (response == null) return [];
    return List<Map<String, dynamic>>.from(response as List);
  }

  Future<List<Map<String, dynamic>>> getTypeStores() async {
    final response = await _supabase
        .from('type_stores')
        .select('id, name, icon, color')
        .order('name', ascending: true);
    return List<Map<String, dynamic>>.from(response);
  }
}
