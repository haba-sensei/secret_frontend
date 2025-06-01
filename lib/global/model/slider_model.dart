import 'package:tu_agenda_ya/global/model/store_model.dart';

class SliderModel {
  final int position;
  final String title;
  List<StoreModel> stores;

  SliderModel({
    required this.position,
    required this.title,
    required this.stores,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      position: json['slider_position'] as int,
      title: json['slider_titulo'] as String,
      stores: (json['stores'] as List<dynamic>)
          .map((e) => StoreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
