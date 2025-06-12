import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MapAnimateStore extends StatefulWidget {
  final LatLng point;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;
  final int delayMs;
  final bool shouldAnimate;

  const MapAnimateStore({
    super.key,
    required this.point,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
    required this.delayMs,
    required this.shouldAnimate,
  });

  @override
  State<MapAnimateStore> createState() => _MapAnimateStoreState();
}

class _MapAnimateStoreState extends State<MapAnimateStore>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    if (widget.shouldAnimate) {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );

      _offsetAnimation = Tween<Offset>(
        begin: const Offset(0, -0.3),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      );

      _scaleAnimation = Tween<double>(
        begin: 0.7,
        end: 1.0,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
      );

      Future.delayed(Duration(milliseconds: widget.delayMs), () {
        if (mounted) _controller.forward();
      });
    } else {
      _controller = AnimationController(
        vsync: this,
        duration: Duration.zero,
      )..value = 1.0;

      _offsetAnimation = AlwaysStoppedAnimation(Offset.zero);
      _scaleAnimation = AlwaysStoppedAnimation(1.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Icon(
            widget.icon,
            color: widget.isSelected ? Colors.black : widget.color,
            size: widget.isSelected ? 40 : 30,
          ),
        ),
      ),
    );
  }
}
