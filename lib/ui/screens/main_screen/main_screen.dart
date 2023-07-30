import 'package:afisha/ui/screens/main_screen/all_events_page.dart';
import 'package:afisha/ui/screens/main_screen/fav_events_page.dart';
import 'package:afisha/ui/screens/main_screen/widgets/fav_events_count_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController();
  int _selIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          AllEventsPage(),
          FavEventsPage(),
        ],
        onPageChanged: (index) {
          _selIndex = index;
          setState(() {});
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selIndex,
        onDestinationSelected: (int index) {
          _selIndex = index;
          setState(() {});
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
          );
        },
        destinations: [
          NavigationDestination(
            selectedIcon: const Icon(Icons.local_activity),
            icon: const Icon(Icons.local_activity_outlined),
            label: 'billboardTab'.tr(),
          ),
          NavigationDestination(
            selectedIcon: const _FavIcon(icon: Icons.favorite),
            icon: const _FavIcon(icon: Icons.favorite_outline),
            label: 'favoritesTab'.tr(),
          ),
        ],
      ),
    );
  }
}

//--------

class _FavIcon extends StatelessWidget {
  final IconData icon;
  const _FavIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon),
        const Positioned(right: -8, top: -2, child: FavEventsCountIndicator()),
      ],
    );
  }
}
