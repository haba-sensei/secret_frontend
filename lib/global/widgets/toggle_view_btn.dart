import 'package:flutter/material.dart';

class ToggleViewButtons extends StatelessWidget {
  final VoidCallback onMapPressed;
  final VoidCallback onListPressed;

  const ToggleViewButtons({
    super.key,
    required this.onMapPressed,
    required this.onListPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onMapPressed,
            child: Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_pin_circle_outlined, size: 18),
                  SizedBox(width: 6),
                  Text(
                    'Ver mapa',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: onListPressed,
            child: Container(
              color: Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.filter_list, size: 18),
                  SizedBox(width: 6),
                  Text(
                    'Ver lista',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
