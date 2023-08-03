import 'package:afisha/=common=/classes/x_status.dart';
import 'package:afisha/logic/location_provider.dart';
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

    return _AnimatedLocationBar(locationStr: locationStr);
  }
}

//==============

class _AnimatedLocationBar extends StatefulWidget {
  final String locationStr;
  const _AnimatedLocationBar({required this.locationStr});

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
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.addListener(() {
      setState(() {});
    });
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isTextVisible = true;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();

    return Container(
      width: double.infinity,
      height: _animation.value * 68,
      color: Theme.of(context).colorScheme.surface,
      child: Visibility(
        visible: _isTextVisible,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextOneLine('yourCurrentLocation'.tr(),
                  style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 2.5),
              TextOneLine(widget.locationStr,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
            ],
          ),
        ),
      ),
    );
  }
}
