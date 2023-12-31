import 'package:afisha/=models=/event.dart';
import 'package:afisha/logic/app_provider.dart';
import 'package:afisha/ui/screens/main_screen/widgets/event_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavEventsPage extends StatelessWidget {
  const FavEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favEvents = context.select<AppProvider, List<Event>>((pr) => pr.favEvents);

    return Scaffold(
      appBar: AppBar(
        title: Text('favoritesTab'.tr()),
        centerTitle: true,
      ),
      body: (favEvents.isEmpty)
          ? Center(child: Text('favoritesIsEmpty'.tr()))
          : ListView.builder(
              itemCount: favEvents.length,
              itemBuilder: (_, i) => EventItem(event: favEvents[i]),
            ),
    );
  }
}
