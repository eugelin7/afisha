import 'package:afisha/data/i_afisha_api.dart';
import 'package:afisha/ui/screens/main_screen/all_events_page.dart';
import 'package:afisha/ui/screens/main_screen/fav_events_page.dart';
import 'package:afisha/ui/screens/main_screen/screen_logic/filter_provider.dart';
import 'package:afisha/ui/screens/main_screen/screen_logic/main_screen_provider.dart';
import 'package:afisha/ui/screens/main_screen/widgets/fav_navigation_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainScreenProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider(api: GetIt.I<IAfishaApi>())),
      ],
      child: Scaffold(
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
              selectedIcon: const FavNavigationIcon(icon: Icons.favorite),
              icon: const FavNavigationIcon(icon: Icons.favorite_outline),
              label: 'favoritesTab'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
