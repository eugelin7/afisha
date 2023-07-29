import 'package:afisha/logic/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavButton extends StatelessWidget {
  final String eventId;
  const FavButton({super.key, required this.eventId});

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
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primary.withOpacity(0.7),
          borderRadius: BorderRadius.circular(40),
          boxShadow: isFavorite
              ? [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary,
                    blurRadius: 0,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: Center(
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Theme.of(context).colorScheme.onPrimary,
            size: isFavorite ? 20 : 18,
          ),
        ),
      ),
    );
  }
}
