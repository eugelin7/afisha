import 'package:afisha/logic/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavEventsCountIndicator extends StatelessWidget {
  const FavEventsCountIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final favEventsCount = context.select<AppProvider, int>((pr) => pr.favEvents.length);

    if (favEventsCount == 0) return const SizedBox.shrink();

    final countText = (favEventsCount > 9) ? '9+' : favEventsCount.toString();

    return Transform.translate(
      offset: Offset((favEventsCount > 9) ? 6 : 0, 0),
      child: Container(
        width: (favEventsCount > 9) ? 20 : 14,
        height: 14,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            countText,
            maxLines: 1,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
          ),
        ),
      ),
    );
  }
}
