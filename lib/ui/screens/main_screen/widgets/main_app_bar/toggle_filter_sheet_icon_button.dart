import 'package:afisha/=models=/filter_params.dart';
import 'package:afisha/app/theme/app_theme.dart';
import 'package:afisha/logic/app_provider.dart';
import 'package:afisha/ui/screens/main_screen/screen_logic/main_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToggleFilterSheetIconButton extends StatelessWidget {
  const ToggleFilterSheetIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    final filterParams = context.select<AppProvider, FilterParams?>((pr) => pr.filterParams);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: () => context.read<MainScreenProvider>().toggleFilterSheetVisibility(),
          icon: const Icon(Icons.filter_list),
        ),
        if (filterParams != null)
          Positioned(
            top: 11,
            right: 7,
            child: CircleAvatar(
              radius: 4.5,
              backgroundColor: context.theme.colorScheme.errorContainer,
            ),
          )
      ],
    );
  }
}
