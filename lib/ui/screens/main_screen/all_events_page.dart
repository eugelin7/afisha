import 'package:afisha/ui/screens/main_screen/widgets/events_area.dart';
import 'package:afisha/ui/screens/main_screen/widgets/filter_sheet/filter_sheet.dart';
import 'package:afisha/ui/screens/main_screen/widgets/main_app_bar.dart';
import 'package:afisha/ui/screens/main_screen/widgets/offline_mode_bar.dart';
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
      body: const Stack(
        children: [
          //--------
          Column(
            children: [
              OfflineModeBar(),
              Expanded(
                child: EventsArea(),
              )
            ],
          ),
          //--------
          Positioned(
            top: 0,
            left: 0,
            child: FilterSheet(),
          ),
          //--------
        ],
      ),
    );
  }
}
