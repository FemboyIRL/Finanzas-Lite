import 'package:finanzas_lite/models/nav_item.dart';
import 'package:finanzas_lite/screens/home_screen/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Navbar extends StatelessWidget {
  final List<NavItem> navItems;

  const Navbar({super.key, required this.navItems});

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(color: const Color(0xFF141326)),
      child: Stack(
        children: [
          // Línea dorada centrada
          Positioned(
            bottom: 0,
            left: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: 3,
              decoration: BoxDecoration(
                color: const Color(0xFFE3B53C),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Contenido de la navbar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(navItems[0]),
              _buildNavItem(navItems[1]),
              SizedBox(
                width: 50,
                height: 50,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF6A66FF), Color(0xFF8B86FF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF6A66FF).withOpacity(0.5),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.add, color: Colors.white, size: 28),
                  ],
                ),
              ),
              _buildNavItem(navItems[2]),
              _buildNavItem(navItems[3]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(NavItem navItem) {
    return GestureDetector(
      onTap: () => Navigator.of(Get.context!).push(
        MaterialPageRoute(
          builder: (context) => _getPageFromRoute(navItem.route),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: SvgPicture.asset(
          navItem.iconPath,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }

  Widget _getPageFromRoute(String route) {
    switch (route) {
      case '/home':
        return HomeScreen();
      case '/wallet':
      // return WalletScreen();
      case '/stats':
      // return StatsScreen();
      case '/profile':
      // return ProfileScreen();
      default:
        return HomeScreen();
    }
  }
}
