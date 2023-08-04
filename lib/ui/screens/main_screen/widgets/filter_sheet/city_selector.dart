import 'package:afisha/app/theme/app_theme.dart';
import 'package:afisha/logic/app_provider.dart';
import 'package:afisha/ui/screens/main_screen/screen_logic/filter_provider.dart';
import 'package:afisha/ui/screens/main_screen/widgets/filter_sheet/styles_filter_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CitySelector extends StatelessWidget {
  const CitySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final cities = context.select<FilterProvider, List<String>>((pr) => pr.cities);
    final selectedCity = context.select<FilterProvider, String?>((pr) => pr.selectedCity);

    return InputDecorator(
      decoration:
          (cities.isEmpty) ? getInputDecorationDisabled(context) : getInputDecoration(context),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          isDense: true,
          hint: Text('<Select city>',
              style: (cities.isEmpty)
                  ? getHintTextStyle(context)
                      ?.copyWith(color: getHintTextStyle(context)?.color?.withOpacity(0.35))
                  : getHintTextStyle(context)),
          style: getTextStyle(context),
          dropdownColor: context.theme.colorScheme.primary.withOpacity(0.95),
          iconEnabledColor: context.theme.colorScheme.onPrimary,
          iconDisabledColor: context.theme.colorScheme.onPrimary.withOpacity(0.3),
          iconSize: kDropDownIconSize,
          value: selectedCity,
          items: cities.isEmpty
              ? null
              : cities.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
          onChanged: (value) {
            final filterProv = Provider.of<FilterProvider>(context, listen: false);
            final appProv = Provider.of<AppProvider>(context, listen: false);
            filterProv.setSelectedCity(value);
            appProv.setFilterParams(filterProv.getFilterParams());
          },
        ),
      ),
    );
  }
}
