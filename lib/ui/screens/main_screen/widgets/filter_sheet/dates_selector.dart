import 'package:afisha/=common=/utils.dart';
import 'package:afisha/ui/screens/main_screen/screen_logic/action_handlers.dart';
import 'package:afisha/ui/screens/main_screen/screen_logic/filter_provider.dart';
import 'package:afisha/ui/screens/main_screen/widgets/filter_sheet/styles_filter_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatesSelector extends StatelessWidget {
  const DatesSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateStart = context.select<FilterProvider, DateTime?>((pr) => pr.dateStart);
    final dateEnd = context.select<FilterProvider, DateTime?>((pr) => pr.dateEnd);

    String datesStr = '';
    if ((dateStart != null) && (dateEnd != null)) {
      const format = 'd MMMM yyyy';
      final locale = context.locale.languageCode;
      if (dateEnd.isSameDay(dateStart)) {
        datesStr = formatDateTime(dateStart, locale, format);
      } else {
        final d1 = formatDateTime(dateStart, locale, format);
        final d2 = formatDateTime(dateEnd, locale, format);
        datesStr = '$d1  \u{2013}  $d2';
      }
    }

    return Stack(
      children: [
        InputDecorator(
          decoration: getInputDecoration(context),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              isDense: true,
              hint: (datesStr == '')
                  ? Text('filterSelectDatesHint'.tr(), style: getHintTextStyle(context))
                  : const Text(''),
              style: getTextStyle(context),
              iconEnabledColor: Colors.transparent,
              iconDisabledColor: Colors.transparent,
              iconSize: kDropDownIconSize,
              value: null,
              items: const [],
              onChanged: (value) {},
            ),
          ),
        ),
        Positioned.fill(
          child: GestureDetector(
            onTap: () => ActionHandlers.onDatesFieldTap(context),
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(left: 9),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(datesStr, style: getTextStyle(context)?.copyWith(letterSpacing: -0.2)),
              ),
            ),
          ),
        )
      ],
    );
  }
}
