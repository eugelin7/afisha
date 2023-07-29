import 'package:afisha/logic/app_provider.dart';
import 'package:afisha/ui/screens/main_screen/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsList extends StatelessWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context) {
    final appProv = Provider.of<AppProvider>(context, listen: false);
    return RefreshIndicator(
      onRefresh: () async {
        appProv.getAllEvents();
      },
      child: ListView.builder(
        itemCount: appProv.events.length,
        itemBuilder: (_, i) => EventItem(event: appProv.events[i]),
      ),
    );
  }
}
