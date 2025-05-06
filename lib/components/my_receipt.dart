import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/features/kiosk/domain/entities/restaurant.dart';
import 'package:provider/provider.dart';

class MyReceipt extends StatelessWidget {
  const MyReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 25),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/orderConfirmed.json", width: 100, height: 100),

            Text("Gracias por tu orden!"),
            SizedBox(height: 25),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(25),
              child: Consumer<Restaurant>(
                builder:
                    (context, restaurant, child) =>
                        Text(restaurant.displayCartReceipt()),
              ),
            ),
            SizedBox(height: 25),
            Text("Thank you for your order!"),
            const Text("Te contactaremos pronto"),
          ],
        ),
      ),
    );
  }
}
