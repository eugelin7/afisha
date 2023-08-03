import 'package:afisha/data/i_geocoding_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';

class EventMap extends StatefulWidget {
  final String address;
  const EventMap({super.key, required this.address});

  @override
  State<EventMap> createState() => _EventMapState();
}

class _EventMapState extends State<EventMap> {
  late final MapController _controller;

  bool _isMapReady = false;
  bool _isMapError = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 70), () async {
      final location = await GetIt.I<IGeocodingService>().addressToLocation(widget.address);
      if (location != null) {
        _controller = MapController.withPosition(
          initPosition: GeoPoint(latitude: location.latitude, longitude: location.longitude),
        );
        _isMapReady = true;
        _isMapError = false;
        setState(() {});
      } else {
        debugPrint('Geocoding failure');
        _isMapReady = true;
        _isMapError = true;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    try {
      _controller.dispose();
    } catch (_) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isMapReady) {
      return Center(
        child: SpinKitThreeBounce(
          size: 40,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
        ),
      );
    }

    if (_isMapError) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        OSMFlutter(
          controller: _controller,
          mapIsLoading: SpinKitThreeBounce(
            size: 40,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
          ),
          showZoomController: true,
          initZoom: 11,
          markerOption: MarkerOption(
            defaultMarker: MarkerIcon(
              icon: Icon(
                Icons.pin_drop_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 56,
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Row(children: [
            IconButton(
                onPressed: () => _controller.setZoom(stepZoom: 1), icon: const Icon(Icons.add)),
            IconButton(
                onPressed: () => _controller.setZoom(stepZoom: -1), icon: const Icon(Icons.remove))
          ]),
        )
      ],
    );
  }
}
