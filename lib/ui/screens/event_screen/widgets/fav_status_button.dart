import 'package:afisha/logic/app_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavStatusButton extends StatelessWidget {
  final String eventId;
  const FavStatusButton({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final bool isFav = context.select<AppProvider, bool>((pr) => pr.favEventIds.contains(eventId));
    final appProv = Provider.of<AppProvider>(context, listen: false);

    if (isFav) {
      return OutlinedButton(
        onPressed: () => appProv.deleteEventFromFavList(eventId),
        child: Text('favoriteButtonDelete'.tr()),
      );
    }

    return ElevatedButton(
      onPressed: () => appProv.addEventToFavList(eventId),
      child: Text('favoriteButtonAdd'.tr()),
    );
  }
}
