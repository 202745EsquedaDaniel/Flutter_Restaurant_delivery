import 'package:flutter/material.dart';
import 'package:myapp/features/sales/domain/entities/cashBreakdown.dart';

Future<CashBreakdown?> showCashBreakdownDialog(
  BuildContext context,
  double total,
) {
  final values = {
    '1000': 0,
    '500': 0,
    '200': 0,
    '100': 0,
    '50': 0,
    '20': 0,
    '10': 0,
    '5': 0,
    '2': 0,
    '1': 0,
  };

  int calculateTotal() {
    return values.entries.fold(
      0,
      (sum, e) => sum + (int.parse(e.key) * e.value),
    );
  }

  return showDialog<CashBreakdown>(
    context: context,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          final currentTotal = calculateTotal();
          return AlertDialog(
            title: const Text("Selecciona los billetes y monedas"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Total a pagar: \$${total.toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Total ingresado: \$${currentTotal.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: currentTotal >= total ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    currentTotal >= total
                        ? "Cambio: \$${(currentTotal - total).toStringAsFixed(2)}"
                        : "Faltan: \$${(total - currentTotal).toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  ...values.keys.map((key) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$$key'),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed:
                                  () => setState(() {
                                    if (values[key]! > 0)
                                      values[key] = values[key]! - 1;
                                  }),
                            ),
                            Text(values[key].toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed:
                                  () => setState(() {
                                    values[key] = values[key]! + 1;
                                  }),
                            ),
                          ],
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, null),
                child: const Text("Cancelar"),
              ),
              ElevatedButton(
                onPressed:
                    currentTotal >= total
                        ? () {
                          final breakdown = CashBreakdown(
                            bill1000: values['1000']!,
                            bill500: values['500']!,
                            bill200: values['200']!,
                            bill100: values['100']!,
                            bill50: values['50']!,
                            bill20: values['20']!,
                            coin10: values['10']!,
                            coin5: values['5']!,
                            coin2: values['2']!,
                            coin1: values['1']!,
                          );
                          Navigator.pop(context, breakdown);
                        }
                        : null, // ❌ deshabilita si no alcanza
                child: const Text("Aceptar"),
              ),
            ],
          );
        },
      );
    },
  );
}
