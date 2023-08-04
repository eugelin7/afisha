import 'package:afisha/=common=/utils.dart';
import 'package:afisha/app/theme/app_theme.dart';
import 'package:afisha/logic/app_provider.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OfflineModeBar extends StatelessWidget {
  const OfflineModeBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bool? isOnline = context.select<AppProvider, bool?>((pr) => pr.loadedFromServer);
    if ((isOnline == null) || isOnline) return const SizedBox.shrink();
    //-----
    final appProv = Provider.of<AppProvider>(context, listen: false);
    final offlineStr = 'offlineMode'.tr();
    final dateTimeStr = formatDateTime(appProv.dateOfLastSaving, context.locale.languageCode);
    return Container(
      width: double.infinity,
      color: context.theme.colorScheme.errorContainer,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Center(
        child: TextOneLine("$offlineStr  $dateTimeStr",
            style: context.theme.textTheme.titleSmall?.copyWith(
              color: context.theme.colorScheme.onErrorContainer,
              letterSpacing: -0.5,
            )),
      ),
    );
  }
}
