class Food {
  final String name; //  cheese burger
  final String description; //  a burger full of cheese
  final String imagePath; //  lib/images/cheese_burger.png
  final double price; //  10.99
  final FoodCategory category; //  burger
  final List<Addon> availableAddons; //  [ cheese, lettuce, tomato ]

  Food({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.availableAddons,
  });
}

enum FoodCategory {
  burgers,
  salads,
  sides,
  desserts,
  drinks, //
}

//  food addons
class Addon {
  String name;
  double price;

  Addon({
    required this.name,
    required this.price, //
  });
}
