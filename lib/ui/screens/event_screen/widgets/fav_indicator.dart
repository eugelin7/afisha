import 'package:afisha/logic/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavIndicator extends StatelessWidget {
  final String eventId;
  const FavIndicator({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final bool isFav = context.select<AppProvider, bool>((pr) => pr.favEventIds.contains(eventId));
    if (!isFav) return const SizedBox.shrink();
    return const Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.favorite, size: 28, color: Colors.white),
        Icon(Icons.favorite, size: 25, color: Color.fromRGBO(0xE5, 0x39, 0x35, 1))
      ],
    );
  }
}
