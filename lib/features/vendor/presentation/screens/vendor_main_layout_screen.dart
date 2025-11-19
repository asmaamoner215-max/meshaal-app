import 'package:flutter/material.dart';
import 'package:weam/features/vendor/presentation/screens/vendor_home_screen.dart';
import 'package:weam/features/vendor/presentation/screens/vendor_profile_screen.dart';

import '../widgets/vendor_bottom_nav_bar_widget.dart';

class VendorMainLayoutScreen extends StatefulWidget {
  const VendorMainLayoutScreen({
    super.key,
  });

  @override
  State<VendorMainLayoutScreen> createState() => _VendorMainLayoutScreenState();
}

class _VendorMainLayoutScreenState extends State<VendorMainLayoutScreen> {
  int currentIndex = 0;

  late List<Widget> screens;
  @override
  void initState() {
    super.initState();
    screens = [
      const VendorHomeScreen(),
      const VendorProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: VendorBottomNavBarWidget(
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
