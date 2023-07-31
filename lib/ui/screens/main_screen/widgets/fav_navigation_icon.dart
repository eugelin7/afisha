import 'package:afisha/ui/screens/main_screen/widgets/fav_events_count_indicator.dart';
import 'package:flutter/material.dart';

class FavNavigationIcon extends StatelessWidget {
  final IconData icon;
  const FavNavigationIcon({super.key, required this.icon});

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
