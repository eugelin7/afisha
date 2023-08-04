import 'package:afisha/app/theme/app_theme.dart';
import 'package:afisha/ui/screens/main_screen/screen_logic/action_handlers.dart';
import 'package:afisha/ui/screens/main_screen/screen_logic/filter_provider.dart';
import 'package:afisha/ui/screens/main_screen/screen_logic/main_screen_provider.dart';
import 'package:afisha/ui/screens/main_screen/widgets/filter_sheet/city_selector.dart';
import 'package:afisha/ui/screens/main_screen/widgets/filter_sheet/country_selector.dart';
import 'package:afisha/ui/screens/main_screen/widgets/filter_sheet/dates_selector.dart';
import 'package:afisha/ui/screens/main_screen/widgets/filter_sheet/styles_filter_sheet.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
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
  late final MainScreenProvider _mainScrProv;

  @override
  void initState() {
    super.initState();
    _filterProv = Provider.of<FilterProvider>(context, listen: false);
    _mainScrProv = Provider.of<MainScreenProvider>(context, listen: false);
    _countriesLoaded = _filterProv.countries.isNotEmpty;
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
        color: context.theme.colorScheme.primary.withOpacity(0.95),
        child: Center(
          child: SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(color: context.theme.colorScheme.onPrimary)),
        ),
      );
    }
    //------

    return Container(
      width: MediaQuery.of(context).size.width,
      color: context.theme.colorScheme.primary.withOpacity(0.95),
      padding: const EdgeInsets.fromLTRB(20, 27, 20, 9),
      child: Column(
        children: [
          //-----
          Row(
            children: [
              SizedBox(
                  width: kFieldTitleWidth,
                  child: TextOneLine('filterLabelCountry'.tr(), style: getTextStyle(context))),
              const SizedBox(width: 10),
              const Expanded(child: CountrySelector()),
            ],
          ),
          const SizedBox(height: 14),
          //-----
          Row(
            children: [
              SizedBox(
                  width: kFieldTitleWidth,
                  child: TextOneLine('filterLabelCity'.tr(), style: getTextStyle(context))),
              const SizedBox(width: 10),
              const Expanded(child: CitySelector()),
            ],
          ),
          const SizedBox(height: 14),
          //-----
          Row(
            children: [
              SizedBox(
                  width: kFieldTitleWidth,
                  child: TextOneLine('filterLabelDates'.tr(), style: getTextStyle(context))),
              const SizedBox(width: 10),
              const Expanded(child: DatesSelector()),
            ],
          ),
          const SizedBox(height: 15),
          //-----
          Row(
            children: [
              const Spacer(),
              IconButton(
                onPressed: () => ActionHandlers.onCancelFilterTap(context),
                icon: Icon(
                  Icons.close,
                  size: 27,
                  color: context.theme.colorScheme.onPrimary,
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
                    color: context.theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
          //-----
        ],
      ),
    );
  }
}
