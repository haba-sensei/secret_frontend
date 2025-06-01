import 'package:tu_agenda_ya/core/widgets/main_body.dart';
import 'package:flutter/material.dart';
import 'package:tu_agenda_ya/modules/stores/logic/stores_list_logic.dart';

class StoresListPage extends StatelessWidget {
  const StoresListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainBody(
      body: StoresListLogic(),
    );
  }
}
