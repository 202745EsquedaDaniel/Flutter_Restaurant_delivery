import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyDescriptionBox extends StatelessWidget {
  const MyDescriptionBox({super.key});

  @override
  Widget build(BuildContext context) {
    // textstyle
    var myPrimaryTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.inversePrimary,
    );
    var mySecondaryTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.primary,
    );

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // delivery fee
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the start
              children: [
                Text(
                  'Agrega tus productos al Carrito',
                  style: myPrimaryTextStyle,
                ),
                // Add secondary text if needed, like below
                // Text(
                //   'Delivery Fee',
                //   style: mySecondaryTextStyle,
                // ),
              ],
            ),
          ),
          // delivery time
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.end, // Align text to the end
              children: [
                Lottie.asset("assets/select.json"),

                // Add secondary text if needed, like below
                // Text(
                //   'Delivery time',
                //   style: mySecondaryTextStyle,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
