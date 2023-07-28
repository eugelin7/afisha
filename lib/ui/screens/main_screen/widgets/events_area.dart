import 'package:afisha/logic/app_privider.dart';
import 'package:afisha/logic/x_status.dart';
import 'package:afisha/ui/screens/main_screen/widgets/event_item.dart';
import 'package:afisha/ui/screens/main_screen/widgets/events_loading_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsArea extends StatelessWidget {
  const EventsArea({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select<AppProvider, XStatus>((pr) => pr.eventsLoadingStatus);

    switch (status) {
      case XStatus.initial:
        return const SizedBox.shrink();
      case XStatus.inProgress:
        return const Center(child: CircularProgressIndicator());
      case XStatus.failure:
        return const EventsLoadingError();
      case XStatus.success:
        final appProv = Provider.of<AppProvider>(context, listen: false);
        return ListView.builder(
          itemCount: appProv.events.length,
          itemBuilder: (_, i) => EventItem(event: appProv.events[i]),
        );
    }
  }
}
