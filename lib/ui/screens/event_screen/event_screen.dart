import 'package:afisha/=models=/event.dart';
import 'package:afisha/logic/app_provider.dart';
import 'package:afisha/ui/common_widgets/cached_event_image.dart';
import 'package:afisha/ui/common_widgets/price_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class EventScreen extends StatelessWidget {
  static const name = 'event_screen';
  static const path = '/event/:id';

  final String id;

  const EventScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final Event event =
        context.select<AppProvider, Event>((pr) => pr.allEvents.firstWhere((el) => el.id == id));

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.ios_share),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 220,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedEventImage(imageUrl: event.image.toString()),
                Positioned(
                  top: 12,
                  left: 11,
                  child: PriceWidget(price: event.price),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //TimeUtils.formatDateTime(eventData.date),
                    event.date.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${event.location.country}, ${event.location.city}',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 16),
                  ReadMoreText(
                    event.description * 10,
                    trimLines: 5,
                    trimCollapsedText: 'trimCollapsedText',
                    trimExpandedText: 'trimExpandedText',
                    style: Theme.of(context).textTheme.bodyLarge,
                    moreStyle: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Theme.of(context).colorScheme.primary),
                    lessStyle: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
