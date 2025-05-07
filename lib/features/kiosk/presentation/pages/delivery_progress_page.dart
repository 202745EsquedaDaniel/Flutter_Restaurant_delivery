import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/components/my_receipt.dart';
import 'package:myapp/features/catalog/presentation/cubits/restaurant_cubit.dart';
import 'package:myapp/features/catalog/presentation/cubits/restaurant_states.dart';
import 'package:myapp/services/database/firestore.dart';

class DeliveryProgressPage extends StatefulWidget {
  const DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  final FireStoreService db = FireStoreService();

  @override
  void initState() {
    super.initState();

    // save order to Firestore once widget is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<RestaurantCubit>().state;
      if (state is RestaurantLoaded) {
        final receipt = _buildReceiptFromState(state);
        db.saveOrderToDatabase(receipt);
      }
    });
  }

  String _buildReceiptFromState(RestaurantLoaded state) {
    final buffer = StringBuffer();
    final date = DateTime.now();
    buffer.writeln("Aquí está tu recibo\n");
    buffer.writeln("${date.toString().substring(0, 19)}\n");
    buffer.writeln("-------------");

    for (final item in state.cart) {
      buffer.writeln(
        "${item.quantity} x ${item.food.name} - \$${item.food.price.toStringAsFixed(2)}",
      );
      if (item.selectedAddons.isNotEmpty) {
        buffer.writeln(
          "   Add-ons: ${item.selectedAddons.map((a) => "${a.name} (\$${a.price.toStringAsFixed(2)})").join(', ')}",
        );
      }
      buffer.writeln();
    }

    final itemCount = state.cart.fold(0, (sum, item) => sum + item.quantity);
    final total = state.cart.fold(0.0, (sum, item) {
      double itemTotal = item.food.price;
      for (final addon in item.selectedAddons) {
        itemTotal += addon.price;
      }
      return sum + (itemTotal * item.quantity);
    });

    buffer.writeln("-------------\n");
    buffer.writeln("Número de artículos: $itemCount");
    buffer.writeln("Total: \$${total.toStringAsFixed(2)}\n");

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orden Confirmada"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(child: Column(children: const [MyReceipt()])),
    );
  }
}
