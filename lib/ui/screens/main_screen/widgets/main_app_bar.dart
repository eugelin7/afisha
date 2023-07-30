import 'package:afisha/logic/app_provider.dart';
import 'package:afisha/ui/screens/main_screen/widgets/styles_main_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainAppBar extends StatefulWidget {
  const MainAppBar({super.key});

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  int _index = 0;
  final _searchTextController = TextEditingController();
  final _searchFocusNode = FocusNode();

  late final AppProvider _appProv;

  @override
  void initState() {
    super.initState();
    _appProv = Provider.of<AppProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _index,
      children: [
        //------------
        Container(
          width: double.infinity,
          height: kToolbarHeight,
          color: Theme.of(context).colorScheme.primary,
          child: Row(
            children: [
              const SizedBox(width: 48),
              Expanded(child: Center(child: Text('eventsScreenTitle'.tr()))),
              IconButton(
                onPressed: () {
                  _index = 1;
                  setState(() {});
                  _searchFocusNode.requestFocus();
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
        //------------
        Container(
          width: double.infinity,
          height: kToolbarHeight,
          color: Theme.of(context).colorScheme.primary,
          child: Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                child: TextField(
                  controller: _searchTextController,
                  focusNode: _searchFocusNode,
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  decoration: getTextFieldSearchDecoration(context),
                  style: getTextFieldSearchTextStyle(context),
                  onChanged: (value) => _appProv.setSearchEventString(value),
                ),
              ),
              IconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  _appProv.setSearchEventString('');
                  _searchTextController.text = '';
                  _index = 0;
                  setState(() {});
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
        //------------
      ],
    );
  }
}
