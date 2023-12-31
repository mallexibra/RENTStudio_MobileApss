import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rent_mobileapps/sevices/AuthServices.dart';

class BarNavigation extends StatefulWidget {
  final int index;
  const BarNavigation({required this.index});

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
        selectedIndex: widget.index,
        color: Colors.deepPurple[200],
        activeColor: Colors.white,
        tabBackgroundColor: Color.fromARGB(255, 124, 86, 192),
        tabs: [
          GButton(
            icon: Icons.home_rounded,
            text: "Home",
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          GButton(
            icon: Icons.payments_rounded,
            text: "Payments",
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
          ),
          GButton(
            icon: Icons.star_outline_rounded,
            text: "Review",
            onPressed: () {
              Navigator.pushNamed(context, '/review');
            },
          ),
          GButton(
            icon: Icons.logout_rounded,
            text: "Logout",
            onPressed: () async {
              bool status = await AuthServices().logout();
              if (status) {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Success'),
                    content: Text('Logout Successfully'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
                Navigator.pushNamed(context, '/login');
              }
            },
          ),
        ],
      ),
    );
  }
}
