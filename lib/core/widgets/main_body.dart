import 'package:flutter/material.dart';
import 'package:tu_agenda_ya/global/widgets/custom_appbar.dart';
import 'package:tu_agenda_ya/global/widgets/custom_bottom_appbar.dart';

class MainBody extends StatelessWidget {
  final Widget body;

  const MainBody({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: CustomAppbar(),
      body: body,
      bottomNavigationBar: CustomBottomAppbar(),
    );
  }
}
