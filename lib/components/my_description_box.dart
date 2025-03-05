import 'package:flutter/material.dart';

class MyDescriptionBox extends StatelessWidget {
  const MyDescriptionBox({super.key});

  @override
  Widget build(BuildContext context) {
    var myPrimaryTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.inversePrimary,
    );

    var mySecondaryTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.inversePrimary,
    );

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // delivery free
          Column(
            children: [
              Text("\$0.25", style: myPrimaryTextStyle),
              Text("Vendido", style: mySecondaryTextStyle),
            ],
          ),

          //delivery time
          Column(
            children: [
              Text("10", style: myPrimaryTextStyle),
              Text("Pedidos Pendientes", style: mySecondaryTextStyle),
            ],
          ),
        ],
      ),
    );
  }
}
