import 'package:afisha/app/theme/app_theme.dart';
import 'package:afisha/logic/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavIconButton extends StatelessWidget {
  final String eventId;
  const FavIconButton({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final bool isFavorite =
        context.select<AppProvider, bool>((pr) => pr.favEventIds.contains(eventId));

    return GestureDetector(
      onTap: () {
        final appProv = Provider.of<AppProvider>(context, listen: false);
        if (isFavorite) {
          appProv.deleteEventFromFavList(eventId);
        } else {
          appProv.addEventToFavList(eventId);
        }
      },
      child: Container(
        width: 33,
        height: 33,
        decoration: BoxDecoration(
          color: isFavorite
              ? context.theme.colorScheme.primary
              : context.theme.colorScheme.primary.withOpacity(0.7),
          borderRadius: BorderRadius.circular(40),
          boxShadow: isFavorite
              ? [
                  BoxShadow(
                    color: context.theme.colorScheme.primary,
                    blurRadius: 0,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: Center(
          child: isFavorite
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.favorite, color: context.theme.colorScheme.onPrimary, size: 22),
                    Icon(Icons.favorite, color: Colors.red[600], size: 19),
                  ],
                )
              : Icon(Icons.favorite_border, color: context.theme.colorScheme.onPrimary, size: 18),
        ),
      ),
    );
  }
}
