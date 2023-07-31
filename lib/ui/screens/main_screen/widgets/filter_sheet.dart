import 'package:afisha/=models=/filter_params.dart';
import 'package:afisha/logic/app_provider.dart';
import 'package:afisha/ui/screens/main_screen/local_logic/main_screen_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterSheet extends StatelessWidget {
  const FilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isVisible = context.select<MainScreenProvider, bool>((pr) => pr.isFilterSheetVisible);

    if (!isVisible) return const SizedBox.shrink();

    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).colorScheme.primary.withOpacity(0.95),
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 18),
      child: Column(
        children: [
          //-----------
          Row(
            children: [
              Text('Country'),
              Expanded(
                child: DropdownButton(
                  isExpanded: true,
                  //hint: Text('country'),
                  value: 'Georgia',
                  items: [
                    DropdownMenuItem<String>(
                      value: 'Georgia',
                      child: Text('Georgia'),
                    )
                  ],
                  onChanged: (value) {
                    context.read<AppProvider>().setFilterParams(FilterParams(country: value));
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          //-----------
          Row(
            children: [
              Text('City'),
            ],
          ),
          SizedBox(height: 24),
          //-----------
          Row(
            children: [
              Text('Dates'),
            ],
          ),
          //-----------
          Row(
            children: [
              Spacer(),
              ElevatedButton(
                onPressed: () => context.read<AppProvider>().clearFilterParams(),
                child: Text('clearFilterParams'.tr()),
              ),
              //Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
