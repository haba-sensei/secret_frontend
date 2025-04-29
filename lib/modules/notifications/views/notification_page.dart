import 'package:tu_agenda_ya/core/widgets/main_body.dart';
import 'package:flutter/material.dart';
import 'package:tu_agenda_ya/modules/notifications/logic/notification_logic.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainBody(
      body: NotificationLogic(),
    );
  }
}
