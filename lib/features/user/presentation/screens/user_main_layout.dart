import 'package:flutter/material.dart';
import 'package:weam/features/user/presentation/screens/profile_screen.dart';
import 'package:weam/features/user/presentation/screens/user_orders/user_order_screen.dart';
import 'package:weam/features/user/presentation/widgets/user_bottom_nav_bar_widget.dart';

import 'home_screen.dart';

class UserMainLayoutScreen extends StatefulWidget {
  const UserMainLayoutScreen({
    super.key,
  });

  @override
  State<UserMainLayoutScreen> createState() => _UserMainLayoutScreenState();
}

class _UserMainLayoutScreenState extends State<UserMainLayoutScreen> {
  int currentIndex = 0;

  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      const UserHomeScreen(),
      const UserOrdersScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: UserBottomNavBarWidget(
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
