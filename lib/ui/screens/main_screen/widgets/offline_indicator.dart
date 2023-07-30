import 'package:afisha/logic/app_provider.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
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
    final offlineStr = 'offlineMode'.tr();
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.errorContainer,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Center(
        child: TextOneLine("$offlineStr ${appProv.dateOfLastSaving}",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                  letterSpacing: -0.5,
                )),
      ),
    );
  }
}
