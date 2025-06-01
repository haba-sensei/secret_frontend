import 'package:tu_agenda_ya/core/widgets/main_body.dart';
import 'package:flutter/material.dart';
import 'package:tu_agenda_ya/modules/stores/logic/stores_map_logic.dart';

class StoresMapPage extends StatelessWidget {
  const StoresMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainBody(
      body: StoresMapLogic(),
    );
  }
}
