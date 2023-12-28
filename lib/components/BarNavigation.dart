import 'package:flutter/material.dart';

class BarNavigation extends StatefulWidget {
  const BarNavigation({super.key});

  @override
  State<BarNavigation> createState() => _BarNavigationState();
}

class _BarNavigationState extends State<BarNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Hello"));
  }
}
