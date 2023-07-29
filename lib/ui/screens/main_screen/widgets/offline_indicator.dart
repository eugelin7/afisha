import 'package:afisha/logic/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OfflineIndicator extends StatelessWidget {
  const OfflineIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final bool? isOnline = context.select<AppProvider, bool?>((pr) => pr.loadedFromServer);
    if ((isOnline == null) || isOnline) return const SizedBox.shrink();
    //-----
    final appProv = Provider.of<AppProvider>(context, listen: false);
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.errorContainer,
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
      child: Center(
        child: Text('Offline mode. Actuality: ${appProv.dateOfLastSaving}',
            maxLines: 1,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                )),
      ),
    );
  }
}
