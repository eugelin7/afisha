import 'package:afisha/=models=/event.dart';
import 'package:afisha/logic/app_provider.dart';
import 'package:afisha/ui/screens/main_screen/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavEventsPage extends StatelessWidget {
  const FavEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favEvents = context.select<AppProvider, List<Event>>((pr) => pr.favEvents);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: (favEvents.isEmpty)
          ? const Center(child: Text('Nothing here...'))
          : ListView.builder(
              itemCount: favEvents.length,
              itemBuilder: (_, i) => EventItem(event: favEvents[i]),
            ),
    );
  }
}
