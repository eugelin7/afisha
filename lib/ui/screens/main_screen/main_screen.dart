import 'package:afisha/ui/screens/main_screen/widgets/events_area.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Afisha'),
      ),
      body: const EventsArea(),
    );
  }
}
