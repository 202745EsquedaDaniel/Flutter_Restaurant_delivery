import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/catalog/domain/entities/product.dart';
import 'package:myapp/features/catalog/presentation/cubits/cart_states.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState([]));

  void addToCart(Product product) {
    final current = List<Product>.from(state.items);
    current.add(product); // puedes mejorar para manejar cantidades
    emit(CartState(current));
  }

  void clearCart() {
    emit(CartState([]));
  }
}
