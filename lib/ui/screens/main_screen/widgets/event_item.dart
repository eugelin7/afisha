import 'package:afisha/=models=/event.dart';
import 'package:afisha/ui/common_widgets/price_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  final Event event;
  const EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 176,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                  imageUrl: event.image.toString(),
                  fit: BoxFit.fitWidth,
                  errorWidget: (_, __, ___) => Image.asset(
                      'assets/images/image_event_placeholder.png',
                      fit: BoxFit.fitWidth),
                ),
                Positioned(
                  top: 12,
                  left: 10,
                  child: PriceWidget(price: event.price),
                ),
                const Positioned(
                  top: 12,
                  right: 16,
                  // child: FavoriteIconButton(
                  //   selected: favorite,
                  //   onPressed: onAddToFavorite,
                  // ),
                  child: Icon(Icons.heart_broken),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text(
                    event.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.fade,
                    maxLines: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Text(
                    event.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Text(
                  //TimeUtils.formatDateTime(eventData.date),
                  event.date.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 44),
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      '${event.location.country}, ${event.location.city}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
