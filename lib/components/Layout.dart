import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget child;
  const Layout({required this.child});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [Padding(padding: EdgeInsets.all(12), child: child)],
    );
  }
}
