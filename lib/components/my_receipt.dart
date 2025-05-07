import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/features/catalog/presentation/cubits/restaurant_cubit.dart';
import 'package:myapp/features/catalog/presentation/cubits/restaurant_states.dart';

class MyReceipt extends StatelessWidget {
  const MyReceipt({super.key});

  String _formatPrice(double price) => "\$${price.toStringAsFixed(2)}";

  String _formatAddons(List addons) {
    return addons
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(", ");
  }

  String buildReceipt(RestaurantLoaded state) {
    final buffer = StringBuffer();
    final date = DateTime.now();
    buffer.writeln("Aquí está tu recibo\n");
    buffer.writeln("${date.toString().substring(0, 19)}\n");
    buffer.writeln("-------------");

    for (final item in state.cart) {
      buffer.writeln(
        "${item.quantity} x ${item.food.name} - ${_formatPrice(item.food.price)}",
      );
      if (item.selectedAddons.isNotEmpty) {
        buffer.writeln("   Add-ons: ${_formatAddons(item.selectedAddons)}");
      }
      buffer.writeln();
    }

    final itemCount = state.cart.fold(0, (sum, i) => sum + i.quantity);
    final total = state.cart.fold(0.0, (sum, i) {
      double itemTotal = i.food.price;
      for (final addon in i.selectedAddons) {
        itemTotal += addon.price;
      }
      return sum + itemTotal * i.quantity;
    });

    buffer.writeln("-------------\n");
    buffer.writeln("Número de artículos: $itemCount");
    buffer.writeln("Total: ${_formatPrice(total)}\n");

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/orderConfirmed.json", width: 100, height: 100),
            const Text("Gracias por tu orden!"),
            const SizedBox(height: 25),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(25),
              child: BlocBuilder<RestaurantCubit, RestaurantState>(
                builder: (context, state) {
                  if (state is! RestaurantLoaded)
                    return const Text("Cargando...");
                  return Text(buildReceipt(state));
                },
              ),
            ),
            const SizedBox(height: 25),
            const Text("Thank you for your order!"),
            const Text("Te contactaremos pronto"),
          ],
        ),
      ),
    );
  }
}
