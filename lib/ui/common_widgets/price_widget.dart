import 'package:afisha/=models=/price.dart';
import 'package:afisha/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  final Price? price;

  const PriceWidget({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    if ((price == null) || (price!.currency.isEmpty)) return const SizedBox.shrink();

    final priceText =
        (price!.value == 0) ? 'Free' : '${price!.value.toStringAsFixed(0)} ${price!.currency}';

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 7, 8, 7),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(priceText,
          style: context.theme.textTheme.labelLarge?.copyWith(
            color: context.theme.colorScheme.onPrimary,
          )),
    );
  }
}
