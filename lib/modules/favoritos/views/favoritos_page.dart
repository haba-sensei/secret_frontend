import 'package:tu_agenda_ya/core/widgets/main_body.dart';
import 'package:tu_agenda_ya/modules/favoritos/logic/favoritos_logic.dart';
import 'package:flutter/material.dart';

class FavoritosPage extends StatelessWidget {
  const FavoritosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainBody(
      body: FavoritosLogic(),
    );
  }
}
