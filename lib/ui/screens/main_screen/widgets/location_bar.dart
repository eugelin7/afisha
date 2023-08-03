import 'package:afisha/=common=/classes/x_status.dart';
import 'package:afisha/logic/location_provider.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationBar extends StatelessWidget {
  const LocationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final locationStatus = context.select<LocationProvider, XStatus>((pr) => pr.locationStatus);
    if (locationStatus != XStatus.success) return const SizedBox.shrink();

    final locationStr = context.read<LocationProvider>().locationString ?? '';
    if (locationStr.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 13),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextOneLine('yourCurrentLocation'.tr(), style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 3),
            TextOneLine(locationStr,
                style:
                    Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );

    /*
    Widget content;
    switch (locationStatus) {
      case XStatus.initial:
      // content = const SizedBox.shrink();
      // break;
      case XStatus.inProgress:
        content = const SizedBox.shrink();
        break;
      case XStatus.failure:
        final errorMsg = context.read<LocationProvider>().errorMsg;
        content = Text(errorMsg ?? 'Location error');
        break;
      case XStatus.success:
        final locationStr = context.read<LocationProvider>().locationString;
        content = Text(locationStr ?? '', style: Theme.of(context).textTheme.titleMedium);
        break;
    }
    return Container(
      width: double.infinity,
      height: 50,
      color: Theme.of(context).colorScheme.surface,
      child: Center(child: content),
    );
    */
  }
}
