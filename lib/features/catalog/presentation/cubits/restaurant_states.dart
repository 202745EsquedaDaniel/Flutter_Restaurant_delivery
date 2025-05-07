import 'package:myapp/features/kiosk/domain/entities/cart_item.dart';
import 'package:myapp/features/kiosk/domain/entities/food.dart';

abstract class RestaurantState {}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final List<Food> menu;
  final List<CartItem> cart;
  final String deliveryAddress;

  RestaurantLoaded({
    required this.menu,
    required this.cart,
    required this.deliveryAddress,
  });
}

class RestaurantError extends RestaurantState {
  final String message;
  RestaurantError(this.message);
}
