import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CachedEventImage extends StatelessWidget {
  final String imageUrl;
  const CachedEventImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (_, __) => Center(
        child: SpinKitThreeBounce(
          size: 40,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
        ),
      ),
      imageUrl: imageUrl,
      fit: BoxFit.fitWidth,
      errorWidget: (_, __, ___) => Image.asset(
        'assets/images/image_event_placeholder.png',
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
