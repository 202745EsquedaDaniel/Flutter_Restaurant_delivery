import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/catalog/presentation/cubits/restaurant_cubit.dart';
import 'package:myapp/features/catalog/presentation/cubits/restaurant_states.dart';

class MyCurrentLocation extends StatelessWidget {
  MyCurrentLocation({super.key});

  final TextEditingController textController = TextEditingController();

  void openLocationSearchBox(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Your location"),
            content: TextField(
              controller: textController,
              decoration: const InputDecoration(hintText: "Enter address..."),
            ),
            actions: [
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              MaterialButton(
                onPressed: () {
                  final newAddress = textController.text.trim();
                  if (newAddress.isNotEmpty) {
                    context.read<RestaurantCubit>().updateDeliveryAddress(
                      newAddress,
                    );
                  }
                  Navigator.pop(context);
                  textController.clear();
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deliver now",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          GestureDetector(
            onTap: () => openLocationSearchBox(context),
            child: Row(
              children: [
                // address from cubit
                BlocBuilder<RestaurantCubit, RestaurantState>(
                  builder: (context, state) {
                    if (state is! RestaurantLoaded) return const Text("...");
                    return Text(
                      state.deliveryAddress,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                const Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
