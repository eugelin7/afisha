import 'package:afisha/logic/app_provider.dart';
import 'package:afisha/ui/screens/main_screen/local_logic/filter_provider.dart';
import 'package:afisha/ui/screens/main_screen/local_logic/main_screen_provider.dart';
import 'package:afisha/ui/screens/main_screen/widgets/filter_sheet/city_selector.dart';
import 'package:afisha/ui/screens/main_screen/widgets/filter_sheet/country_selector.dart';
import 'package:afisha/ui/screens/main_screen/widgets/filter_sheet/dates_selector.dart';
import 'package:afisha/ui/screens/main_screen/widgets/filter_sheet/styles_filter_sheet.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late bool _countriesLoaded;
  late final FilterProvider _filterProv;
  late final AppProvider _appProv;
  late final MainScreenProvider _mainScrProv;

  @override
  void initState() {
    super.initState();
    _filterProv = Provider.of<FilterProvider>(context, listen: false);
    _appProv = Provider.of<AppProvider>(context, listen: false);
    _mainScrProv = Provider.of<MainScreenProvider>(context, listen: false);
    _countriesLoaded = _filterProv.cities.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final isVisible = context.select<MainScreenProvider, bool>((pr) => pr.isFilterSheetVisible);
    if (!isVisible) return const SizedBox.shrink();

    //------
    if (!_countriesLoaded) {
      Future.delayed(const Duration(milliseconds: 100), () async {
        await _filterProv.getCountries();
        _countriesLoaded = true;
        setState(() {});
      });
      return Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.95),
        child: Center(
          child: SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary)),
        ),
      );
    }
    //------

    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).colorScheme.primary.withOpacity(0.95),
      padding: const EdgeInsets.fromLTRB(20, 27, 20, 10),
      child: Column(
        children: [
          //-----------
          Row(
            children: [
              SizedBox(
                  width: kFieldTitleWidth,
                  child: TextOneLine('Country :', style: getTextStyle(context))),
              const SizedBox(width: 10),
              const Expanded(child: CountrySelector()),
            ],
          ),
          const SizedBox(height: 14),
          //-----------
          Row(
            children: [
              SizedBox(
                  width: kFieldTitleWidth,
                  child: TextOneLine('City :', style: getTextStyle(context))),
              const SizedBox(width: 10),
              const Expanded(child: CitySelector()),
            ],
          ),
          const SizedBox(height: 14),
          //-----------
          Row(
            children: [
              SizedBox(
                  width: kFieldTitleWidth,
                  child: TextOneLine('Dates :', style: getTextStyle(context))),
              const SizedBox(width: 10),
              const Expanded(child: DatesSelector()),
            ],
          ),
          const SizedBox(height: 18),
          //-----------
          Row(
            children: [
              const Spacer(),
              IconButton(
                onPressed: () {
                  if (_appProv.filterParams == null) {
                    _mainScrProv.setFilterSheetVisibility(false);
                  }
                  _filterProv.clearAllFields();
                  _appProv.setFilterParams(null);
                },
                icon: Icon(
                  Icons.close,
                  size: 27,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => _mainScrProv.setFilterSheetVisibility(false),
                icon: Transform.translate(
                  offset: const Offset(0, -1),
                  child: Icon(
                    Icons.check,
                    size: 32,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
