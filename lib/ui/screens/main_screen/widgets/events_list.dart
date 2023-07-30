import 'package:afisha/=models=/event.dart';
import 'package:afisha/logic/app_provider.dart';
import 'package:afisha/ui/screens/main_screen/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsList extends StatelessWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context) {
    final events = context.select<AppProvider, List<Event>>((pr) => pr.events);

    // TODO: if events.length == 0  текст: "Ничего не найдено"

    return RefreshIndicator(
      onRefresh: () async {
        final appProv = Provider.of<AppProvider>(context, listen: false);
        appProv.getAllEvents();
      },
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (_, i) => EventItem(event: events[i]),
      ),
    );
  }
}
