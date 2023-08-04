import 'package:afisha/app/theme/app_theme.dart';
import 'package:afisha/ui/screens/main_screen/screen_logic/action_handlers.dart';
import 'package:afisha/ui/screens/main_screen/screen_logic/filter_provider.dart';
import 'package:afisha/ui/screens/main_screen/widgets/filter_sheet/styles_filter_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountrySelector extends StatelessWidget {
  const CountrySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final countries = context.select<FilterProvider, List<String>>((pr) => pr.countries);
    final selectedCountry = context.select<FilterProvider, String?>((pr) => pr.selectedCountry);

    return InputDecorator(
      decoration: getInputDecoration(context),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          isDense: true,
          hint: Text('filterSelectCountryHint'.tr(), style: getHintTextStyle(context)),
          style: getTextStyle(context),
          dropdownColor: context.theme.colorScheme.primary.withOpacity(0.95),
          iconEnabledColor: context.theme.colorScheme.onPrimary,
          iconDisabledColor: context.theme.colorScheme.onPrimary.withOpacity(0.3),
          iconSize: kDropDownIconSize,
          value: selectedCountry,
          items: countries.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
          onChanged: (value) => ActionHandlers.onCountrySelect(context, value),
        ),
      ),
    );
  }
}
