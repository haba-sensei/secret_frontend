import 'package:tu_agenda_ya/core/widgets/main_body.dart';
import 'package:tu_agenda_ya/modules/users/logic/settings_logic.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainBody(
      body: SettingsLogic(),
    );
  }
}
