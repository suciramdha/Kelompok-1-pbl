import 'package:flutter/material.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/theme_context.dart';
import '../../../../core/constants/remote_images.dart';
import '../../../../core/ui/app_network_image.dart';
import '../../../../core/ui/app_quantity_stepper.dart';
import '../../../../core/utils/rupiah.dart';
import '../mock/customize_mock.dart';

class CustomizeToppingRow extends StatelessWidget {
  const CustomizeToppingRow({
    super.key,
    required this.topping,
    required this.quantity,
    required this.onQuantityChanged,
  });

  final CustomizeTopping topping;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;

    final image = AppNetworkImage(
      url: RemoteImages.topping(topping.imageSeed),
      width: 80,
      height: 80,
      borderRadius: context.radius.baseRadius,
      semanticLabel: 'Foto ${topping.name}',
    );

    final price = Text(
      formatRupiah(topping.price),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: AppTypography.price.copyWith(color: scheme.primary),
    );

    return Container(
      padding: EdgeInsets.all(context.spacing.md),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: context.radius.mdRadius,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stacked = constraints.maxWidth < 300 || largeText;
          final stepper = AppQuantityStepper(
            value: quantity,
            min: 0,
            max: topping.maxQty,
            collapseAtMin: true,
            emphasizeIncrease: true,
            semanticItemName: topping.name,
            onChanged: onQuantityChanged,
          );

          // Harga dan counter selalu berada di parent yang sama.
          final priceAndCounter = stacked
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    price,
                    SizedBox(height: context.spacing.xs),
                    Align(alignment: Alignment.centerRight, child: stepper),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: price,
                      ),
                    ),
                    SizedBox(width: context.spacing.sm),
                    stepper,
                  ],
                );

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image,
              SizedBox(width: context.spacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      topping.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      topping.description,
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: context.spacing.xs),
                    priceAndCounter,
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
