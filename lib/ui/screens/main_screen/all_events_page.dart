import 'package:afisha/ui/screens/main_screen/widgets/events_area.dart';
import 'package:afisha/ui/screens/main_screen/widgets/main_app_bar.dart';
import 'package:afisha/ui/screens/main_screen/widgets/offline_indicator.dart';
import 'package:flutter/material.dart';

class AllEventsPage extends StatelessWidget {
  const AllEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MainAppBar(),
        titleSpacing: 0,
      ),
      body: const Column(
        children: [
          OfflineIndicator(),
          Expanded(
            child: EventsArea(),
          )
        ],
      ),
    );
  }
}
