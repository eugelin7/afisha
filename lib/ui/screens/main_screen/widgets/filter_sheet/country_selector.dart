import 'package:afisha/logic/app_provider.dart';
import 'package:afisha/ui/screens/main_screen/local_logic/filter_provider.dart';
import 'package:afisha/ui/screens/main_screen/widgets/filter_sheet/styles_filter_sheet.dart';
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
          hint: Text('<Select country>', style: getHintTextStyle(context)),
          style: getTextStyle(context),
          dropdownColor: Theme.of(context).colorScheme.primary.withOpacity(0.95),
          iconEnabledColor: Theme.of(context).colorScheme.onPrimary,
          iconDisabledColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3),
          iconSize: kDropDownIconSize,
          value: selectedCountry,
          items: countries.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
          onChanged: (value) {
            final filterProv = Provider.of<FilterProvider>(context, listen: false);
            final appProv = Provider.of<AppProvider>(context, listen: false);
            filterProv.setSelectedCountry(value);
            appProv.setFilterParams(filterProv.getFilterParams());
          },
        ),
      ),
    );
  }
}
