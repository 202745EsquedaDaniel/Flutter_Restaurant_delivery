import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/catalog/presentation/cubits/restaurant_cubit.dart';
import 'package:myapp/features/catalog/presentation/cubits/restaurant_states.dart';

import 'package:myapp/features/kiosk/presentation/pages/cart_page.dart';

class MySilverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;
  const MySilverAppBar({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 260,
      collapsedHeight: 120,
      floating: false,
      pinned: true,
      actions: [
        // cart button with badge
        Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartPage()),
                );
              },
              icon: const Icon(Icons.shopping_cart),
            ),

            // badge with item count
            Positioned(
              right: 0,
              top: 0,
              child: BlocBuilder<RestaurantCubit, RestaurantState>(
                builder: (context, state) {
                  final itemCount =
                      state is RestaurantLoaded
                          ? state.cart.fold(
                            0,
                            (sum, item) => sum + item.quantity,
                          )
                          : 0;

                  return CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      itemCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text("MyPocket Kiosko"),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: child,
        ),
        title: title,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 0, right: 0, top: 0),
      ),
    );
  }
}
