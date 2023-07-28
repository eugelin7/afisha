import 'package:afisha/logic/app_privider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EventsLoadingError extends StatefulWidget {
  const EventsLoadingError({super.key});

  @override
  State<EventsLoadingError> createState() => _EventsLoadingErrorState();
}

class _EventsLoadingErrorState extends State<EventsLoadingError> {
  late final AppProvider _appProvider;

  @override
  void initState() {
    super.initState();
    _appProvider = Provider.of<AppProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(message: _appProvider.eventsLoadingErrorMsg),
          animationDuration: const Duration(milliseconds: 700),
          displayDuration: const Duration(milliseconds: 1700),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 0.75 * MediaQuery.of(context).size.width),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('\u{1F615}', style: TextStyle(fontSize: 50)),
            const SizedBox(height: 15),
            Text(
              _appProvider.eventsLoadingErrorMsg,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 15.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => _appProvider.getAllEvents(),
              child: const Text('Try again'),
            ),
            const SizedBox(height: 60)
          ],
        ),
      ),
    );
  }
}
