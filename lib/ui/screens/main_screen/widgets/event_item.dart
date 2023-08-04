import 'package:afisha/=common=/utils.dart';
import 'package:afisha/=models=/event.dart';
import 'package:afisha/app/theme/app_theme.dart';
import 'package:afisha/ui/common_widgets/cached_event_image.dart';
import 'package:afisha/ui/common_widgets/price_widget.dart';
import 'package:afisha/ui/screens/event_screen/event_screen.dart';
import 'package:afisha/ui/screens/main_screen/widgets/fav_icon_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventItem extends StatelessWidget {
  final Event event;
  const EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(EventScreen.name, pathParameters: {'id': event.id});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 176,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedEventImage(imageUrl: event.image.toString()),
                Positioned(
                  top: 12,
                  left: 11,
                  child: PriceWidget(price: event.price),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: FavIconButton(eventId: event.id),
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
                    style: context.theme.textTheme.bodyMedium,
                    overflow: TextOverflow.fade,
                    maxLines: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Text(
                    event.title,
                    style: context.theme.textTheme.bodyLarge,
                  ),
                ),
                Text(
                  formatDateTime(event.date, context.locale.languageCode),
                  style: context.theme.textTheme.bodyMedium,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 44),
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      '${event.location.country}, ${event.location.city}',
                      style: context.theme.textTheme.labelMedium?.copyWith(
                        color: context.theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
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
