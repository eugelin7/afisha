import 'package:afisha/=common=/utils.dart';
import 'package:afisha/logic/app_provider.dart';
import 'package:afisha/ui/screens/main_screen/screen_logic/filter_provider.dart';
import 'package:afisha/ui/screens/main_screen/widgets/filter_sheet/styles_filter_sheet.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatesSelector extends StatefulWidget {
  const DatesSelector({Key? key}) : super(key: key);

  @override
  State<DatesSelector> createState() => _DatesSelectorState();
}

class _DatesSelectorState extends State<DatesSelector> {
  late final FilterProvider _filterProv;
  late final AppProvider _appProv;

  @override
  void initState() {
    super.initState();
    _filterProv = Provider.of<FilterProvider>(context, listen: false);
    _appProv = Provider.of<AppProvider>(context, listen: false);
  }

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
        datesStr = '$d1  --  $d2';
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
                  ? Text('<Select dates>', style: getHintTextStyle(context))
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
            onTap: () async {
              var dates = await showCalendarDatePicker2Dialog(
                context: context,
                config: getCalendarConfig(context),
                dialogSize: const Size(320, 0),
                value: [],
                borderRadius: BorderRadius.circular(15),
              );
              if (dates == null) return;
              if (dates.length == 1) {
                _filterProv.setDates(
                    dates[0]!, dates[0]!.add(const Duration(seconds: 24 * 60 * 60 - 1)));
                _appProv.setFilterParams(_filterProv.getFilterParams());
                return;
              }
              if (dates.length == 2) {
                _filterProv.setDates(
                    dates[0]!, dates[1]!.add(const Duration(seconds: 24 * 60 * 60 - 1)));
                _appProv.setFilterParams(_filterProv.getFilterParams());
                return;
              }
            },
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
