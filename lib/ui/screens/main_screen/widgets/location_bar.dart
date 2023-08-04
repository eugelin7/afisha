import 'package:afisha/=common=/classes/x_status.dart';
import 'package:afisha/app/theme/app_theme.dart';
import 'package:afisha/logic/location_provider.dart';
import 'package:afisha/ui/screens/main_screen/screen_logic/main_screen_provider.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationBar extends StatelessWidget {
  const LocationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final locationStatus = context.select<LocationProvider, XStatus>((pr) => pr.locationStatus);
    if (locationStatus != XStatus.success) return const SizedBox.shrink();

    final locationStr = context.read<LocationProvider>().locationString ?? '';
    if (locationStr.isEmpty) return const SizedBox.shrink();

    final isLocationBarVisible = context.read<MainScreenProvider>().isLocationBarVisible;

    return _AnimatedLocationBar(locationStr: locationStr, animate: !isLocationBarVisible);
  }
}

//==============

class _AnimatedLocationBar extends StatefulWidget {
  final String locationStr;
  final bool animate;
  const _AnimatedLocationBar({required this.locationStr, required this.animate});

  @override
  State<_AnimatedLocationBar> createState() => __AnimatedLocationBarState();
}

class __AnimatedLocationBarState extends State<_AnimatedLocationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  bool _isTextVisible = false;

  @override
  void initState() {
    super.initState();
    final mainScreenProv = Provider.of<MainScreenProvider>(context, listen: false);
    _isTextVisible = mainScreenProv.isLocationBarVisible;
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.addListener(() {
      setState(() {});
    });
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isTextVisible = true;
        setState(() {});
        mainScreenProv.setLocationBarVisibility(true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate) {
      _controller.forward();
    }

    return Container(
      width: double.infinity,
      height: widget.animate ? _animation.value * 68 : 68,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primary.withOpacity(0.07),
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: context.theme.colorScheme.primary.withOpacity(0.25),
          ),
        ),
      ),
      child: Visibility(
        visible: _isTextVisible,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextOneLine('yourCurrentLocation'.tr(), style: context.theme.textTheme.labelLarge),
              const SizedBox(height: 2.5),
              TextOneLine(widget.locationStr,
                  style:
                      context.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              //const SizedBox(height: 1),
            ],
          ),
        ),
      ),
    );
  }
}
