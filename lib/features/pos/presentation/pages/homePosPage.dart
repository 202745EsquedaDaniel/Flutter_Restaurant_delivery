import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:myapp/features/catalog/presentation/cubits/cart_cubit.dart';
import 'package:myapp/features/catalog/presentation/cubits/cart_states.dart';
import 'package:myapp/features/catalog/presentation/cubits/catalog_cubit.dart';
import 'package:myapp/features/catalog/presentation/cubits/catalog_states.dart';
import 'package:myapp/features/pos/presentation/components/cash_dialog.dart';
import 'package:myapp/features/pos/presentation/components/items_POS_order.dart';
import 'package:myapp/features/pos/presentation/components/pos_header.dart';
import 'package:myapp/features/pos/presentation/components/pos_search_box.dart';
import 'package:myapp/features/pos/presentation/components/product_POS_tile.dart';
import 'package:myapp/features/sales/domain/entities/cashBreakdown.dart';
import 'package:myapp/features/sales/domain/entities/sale.dart';
import 'package:myapp/features/sales/presentation/cubits/sales_cubit.dart';

class HomePosPage extends StatefulWidget {
  const HomePosPage({Key? key}) : super(key: key);

  @override
  State<HomePosPage> createState() => _HomePosPageState();
}

class _HomePosPageState extends State<HomePosPage> {
  late final authCubit = context.read<AuthCubit>();
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    final orgId = authCubit.currentUser?.orgId;
    if (orgId != null) {
      context.read<CatalogCubit>().fetchProductsByOrgId(orgId);
    }
  }

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

  void _handleCreateSale(
    BuildContext context, {
    required String type,
    required double total,
    CashBreakdown? cashBreakdown,
  }) {
    final cartCubit = context.read<CartCubit>();
    final salesCubit = context.read<SalesCubit>();
    final authCubit = context.read<AuthCubit>();

    final products = cartCubit.state.items;
    final orgId = authCubit.currentUser?.orgId ?? '';
    final clientId = "POS";

    final sale = Sale(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      orgId: orgId,
      clientId: clientId,
      type: type,
      products: products,
      total: total,
      totalPaid: total,
      timestamp: DateTime.now(),
      cashBreakdown: cashBreakdown, // Agregado
    );

    salesCubit.createSale(sale);
    cartCubit.clearCart();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Venta enviada correctamente ✅")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Carrito
        Expanded(
          flex: 5,
          child: Column(
            children: [
              PosHeader(
                title: 'Hola ${authCubit.currentUser?.name ?? ''}!',
                subTitle: 'Sucursal ${authCubit.currentUser?.branchId ?? ''}',
                child: Container(),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return ListView(
                      children:
                          state.items.map((product) {
                            return OrderPosItem(
                              image: product.imageUrl,
                              title: product.name,
                              qty: '1',
                              price: '\$${product.price.toStringAsFixed(2)}',
                            );
                          }).toList(),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color(0xff1f2029),
                ),
                child: Column(
                  children: [
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        final total = state.items.fold<double>(
                          0.0,
                          (sum, item) => sum + item.price,
                        );
                        return _row('Total', total);
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CartCubit>().clearCart();
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
            ],
          ),
        ),

        // Separador
        Expanded(flex: 1, child: Container()),

        // Catálogo
        Expanded(
          flex: 15,
          child: Column(
            children: [
              PosHeader(
                title: 'Lorem Restaurant',
                subTitle: 'POS',
                child: const PosSearchBox(),
              ),
              // Categorías
              SizedBox(
                height: 100,
                child: BlocBuilder<CatalogCubit, CatalogState>(
                  builder: (context, state) {
                    if (state is! CatalogLoaded) return const SizedBox();
                    final categories =
                        state.products.map((p) => p.categoria).toSet().toList();
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (_, i) {
                        final cat = categories[i];
                        final isActive = cat == selectedCategory;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: GestureDetector(
                            onTap: () => setState(() => selectedCategory = cat),
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    isActive ? Colors.orange : Colors.grey[850],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                      isActive
                                          ? Colors.orangeAccent
                                          : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: Center(
                                child: Text(
                                  cat,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight:
                                        isActive
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              // Productos
              Expanded(
                child: BlocBuilder<CatalogCubit, CatalogState>(
                  builder: (context, state) {
                    if (state is! CatalogLoaded) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final products =
                        state.products
                            .where(
                              (p) =>
                                  selectedCategory.isEmpty ||
                                  p.categoria == selectedCategory,
                            )
                            .toList();
                    return GridView.count(
                      crossAxisCount: 4,
                      childAspectRatio: (1 / 1.2),
                      children:
                          products.map((product) {
                            return GestureDetector(
                              onTap: () {
                                print('🖼️ image URL: ${product.imageUrl}');

                                context.read<CartCubit>().addToCart(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${product.name} añadido al carrito',
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              },
                              child: ProductPosTile(
                                image: product.imageUrl,
                                title: product.name,
                                price: '\$${product.price.toStringAsFixed(2)}',
                                item: product.unidad,
                              ),
                            );
                          }).toList(),
                    );
                  },
                ),
              ),
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                color: const Color(0xff1f2029),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _ActionButton(
                      icon: Icons.credit_card,
                      label: "Tarjeta",
                      onTap: () {
                        final cartCubit = context.read<CartCubit>();
                        final total = cartCubit.state.items.fold<double>(
                          0.0,
                          (sum, p) => sum + p.price,
                        );

                        _handleCreateSale(
                          context,
                          type: 'Tarjeta',
                          total: total,
                          cashBreakdown: null, // explícitamente nulo
                        );
                      },
                    ),

                    _ActionButton(
                      icon: Icons.attach_money,
                      label: "Efectivo",
                      onTap: () async {
                        final cartCubit = context.read<CartCubit>();
                        final salesCubit = context.read<SalesCubit>();
                        final authCubit = context.read<AuthCubit>();
                        final products = cartCubit.state.items;
                        final orgId = authCubit.currentUser?.orgId ?? '';
                        final clientId = "POS";

                        if (products.isEmpty || orgId.isEmpty) return;

                        final total = products.fold<double>(
                          0.0,
                          (sum, p) => sum + p.price,
                        );
                        final breakdown = await showCashBreakdownDialog(
                          context,
                          total,
                        );

                        if (breakdown == null) return;

                        final totalPaid = breakdown
                            .toJson()
                            .entries
                            .fold<double>(
                              0.0,
                              (sum, e) =>
                                  sum +
                                  (int.parse(
                                        e.key
                                            .replaceAll('bill', '')
                                            .replaceAll('coin', ''),
                                      ) *
                                      e.value),
                            );

                        final sale = Sale(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          orgId: orgId,
                          clientId: clientId,
                          cajaId: "3",
                          type: 'Efectivo',
                          products: products,
                          total: total,
                          totalPaid: totalPaid,
                          timestamp: DateTime.now(),
                          cashBreakdown: breakdown,
                        );

                        salesCubit.createSale(sale);
                        cartCubit.clearCart();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Venta en efectivo registrada por \$${totalPaid.toStringAsFixed(2)}",
                            ),
                          ),
                        );
                      },
                    ),

                    _ActionButton(icon: Icons.receipt_long, label: "Imprimir"),
                    _ActionButton(icon: Icons.person, label: "Cliente"),
                    _ActionButton(icon: Icons.point_of_sale, label: "Corte"),
                    _ActionButton(
                      icon: Icons.local_shipping,
                      label: "Para llevar",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ActionButton({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: Colors.white),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
