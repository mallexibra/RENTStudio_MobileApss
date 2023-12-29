import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BarNavigation extends StatefulWidget {
  const BarNavigation({super.key});

  @override
  State<BarNavigation> createState() => _BarNavigationState();
}

class _BarNavigationState extends State<BarNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.deepPurple,
      child: GNav(
        backgroundColor: Colors.deepPurple,
        padding: EdgeInsets.all(8),
        gap: 8,
        color: Colors.deepPurple[200],
        activeColor: Colors.white,
        tabBackgroundColor: Color.fromARGB(255, 124, 86, 192),
        tabs: [
          GButton(
            icon: Icons.home_rounded,
            text: "Home",
          ),
          GButton(
            icon: Icons.payments_rounded,
            text: "Payments",
          ),
          GButton(
            icon: Icons.star_outline_rounded,
            text: "Review",
          ),
          GButton(
            icon: Icons.logout_rounded,
            text: "Logout",
          ),
        ],
      ),
    );
  }
}
