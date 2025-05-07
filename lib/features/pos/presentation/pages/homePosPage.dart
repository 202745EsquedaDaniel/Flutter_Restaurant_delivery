import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:myapp/features/catalog/presentation/cubits/restaurant_cubit.dart';
import 'package:myapp/features/catalog/presentation/cubits/restaurant_states.dart';
import 'package:myapp/features/pos/presentation/components/items_POS_order.dart';
import 'package:myapp/features/pos/presentation/components/pos_header.dart';
import 'package:myapp/features/pos/presentation/components/pos_search_box.dart';
import 'package:myapp/features/pos/presentation/components/product_POS_tile.dart';
import 'package:myapp/features/kiosk/domain/entities/food.dart';

class HomePosPage extends StatefulWidget {
  const HomePosPage({Key? key}) : super(key: key);

  @override
  State<HomePosPage> createState() => _HomePosPageState();
}

class _HomePosPageState extends State<HomePosPage> {
  // auth cubit
  late final authCubit = context.read<AuthCubit>();
  FoodCategory selectedCategory = FoodCategory.burgers;

  Widget _row(String label, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Carrito a la izquierda
        Expanded(
          flex: 5,
          child: Column(
            children: [
              PosHeader(
                title: 'Hola ${authCubit.currentUser?.name}!',
                subTitle: 'Table 8',
                child: Container(),
              ),

              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    BlocBuilder<RestaurantCubit, RestaurantState>(
                      builder: (context, state) {
                        if (state is! RestaurantLoaded)
                          return const SizedBox.shrink();
                        return Column(
                          children:
                              state.cart.map((item) {
                                return OrderPosItem(
                                  image: item.food.imagePath,
                                  title: item.food.name,
                                  qty: item.quantity.toString(),
                                  price:
                                      '\$${item.food.price.toStringAsFixed(2)}',
                                );
                              }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: const Color(0xff1f2029),
                  ),
                  child: Column(
                    children: [
                      BlocBuilder<RestaurantCubit, RestaurantState>(
                        builder: (context, state) {
                          if (state is! RestaurantLoaded)
                            return const SizedBox.shrink();
                          final subtotal = state.cart.fold(0.0, (total, item) {
                            double itemTotal = item.food.price;
                            for (final addon in item.selectedAddons) {
                              itemTotal += addon.price;
                            }
                            return total + (itemTotal * item.quantity);
                          });
                          return Column(children: [_row('Total', subtotal)]);
                        },
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          context.read<RestaurantCubit>().clearCart();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Carrito vaciado'),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.print, size: 16),
                            SizedBox(width: 6),
                            Text('Vaciar Carrito'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(flex: 1, child: Container()),
        // Catálogo a la derecha
        Expanded(
          flex: 14,
          child: Column(
            children: [
              PosHeader(
                title: 'Lorem Restaurant',
                subTitle: 'Hola 2!',
                child: const PosSearchBox(),
              ),

              Container(
                height: 100,
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:
                      FoodCategory.values.map((cat) {
                        final name = cat.toString().split('.').last;
                        final iconPath = 'icons/icon-${name.toLowerCase()}.png';
                        final isActive = selectedCategory == cat;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: GestureDetector(
                            onTap: () => setState(() => selectedCategory = cat),
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    isActive ? Colors.orange : Colors.grey[850],
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    isActive
                                        ? Border.all(
                                          color: Colors.orangeAccent,
                                          width: 2,
                                        )
                                        : Border.all(color: Colors.transparent),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    iconPath,
                                    width: 32,
                                    height: 32,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight:
                                          isActive
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
              Expanded(
                child: BlocBuilder<RestaurantCubit, RestaurantState>(
                  builder: (context, state) {
                    if (state is! RestaurantLoaded) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final products =
                        state.menu
                            .where((f) => f.category == selectedCategory)
                            .toList();
                    return GridView.count(
                      crossAxisCount: 4,
                      childAspectRatio: (1 / 1.2),
                      children:
                          products.map((food) {
                            return GestureDetector(
                              onTap: () {
                                context.read<RestaurantCubit>().addToCart(
                                  food,
                                  [],
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${food.name} añadido al carrito',
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              },
                              child: ProductPosTile(
                                image: food.imagePath,
                                title: food.name,
                                price: '\$${food.price.toStringAsFixed(2)}',
                                item: '${food.availableAddons.length} add-ons',
                              ),
                            );
                          }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
