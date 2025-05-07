import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/components/my_button.dart';
import 'package:myapp/components/my_cart_tile.dart';
import 'package:myapp/features/catalog/presentation/cubits/restaurant_cubit.dart';
import 'package:myapp/features/catalog/presentation/cubits/restaurant_states.dart';
import 'package:myapp/features/kiosk/presentation/pages/delivery_progress_page.dart';
import 'package:myapp/features/kiosk/presentation/pages/payment_page.dart';
import 'package:myapp/features/kiosk/presentation/components/constrained_scaffold.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantCubit, RestaurantState>(
      builder: (context, state) {
        if (state is! RestaurantLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        final userCart = state.cart;
        final totalPrice = state.cart
            .fold(0.0, (total, item) {
              double itemTotal = item.food.price;
              for (final addon in item.selectedAddons) {
                itemTotal += addon.price;
              }
              return total + (itemTotal * item.quantity);
            })
            .toStringAsFixed(2);

        return ConstrainedScaffold(
          appBar: AppBar(
            title: const Text("Carrito"),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          title: const Text(
                            "Are you sure you want to clear the cart?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.read<RestaurantCubit>().clearCart();
                              },
                              child: const Text("Yes"),
                            ),
                          ],
                        ),
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child:
                    userCart.isEmpty
                        ? const Center(child: Text("Cart is empty..."))
                        : ListView.builder(
                          itemCount: userCart.length,
                          itemBuilder: (context, index) {
                            return MyCartTile(cartItem: userCart[index]);
                          },
                        ),
              ),
              MyButton(
                text:
                    totalPrice == '0.00'
                        ? 'Ordenar'
                        : 'Ordenar \$${totalPrice}',
                onTap:
                    () =>
                        totalPrice != '0.00'
                            ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const DeliveryProgressPage(),
                              ),
                            )
                            : showDialog(
                              context: context,
                              builder:
                                  (_) => AlertDialog(
                                    title: const Text("Your cart is empty"),
                                    content: const Text(
                                      "Please add some items before checkout.",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("OK"),
                                      ),
                                    ],
                                  ),
                            ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }
}
