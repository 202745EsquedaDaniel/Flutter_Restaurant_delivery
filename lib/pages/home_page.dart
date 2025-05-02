import 'package:flutter/material.dart';
import 'package:myapp/components/my_current_location.dart';
import 'package:myapp/components/my_description_box.dart';
import 'package:myapp/components/my_drawer.dart';
import 'package:myapp/components/my_food_tile.dart';
import 'package:myapp/components/my_silver_app_bar.dart';
import 'package:myapp/components/my_tab_bar.dart';
import 'package:myapp/models/food.dart';
import 'package:myapp/models/restaurant.dart';
import 'package:myapp/pages/food_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: FoodCategory.values.length,
      vsync: this,
    )..addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      final items = fullMenu.where((f) => f.category == category).toList();
      return ListView.builder(
        itemCount: items.length,
        padding: EdgeInsets.zero,
        itemBuilder: (_, i) {
          return FoodTile(
            food: items[i],
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FoodPage(food: items[i])),
                ),
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: Consumer<Restaurant>(
        builder:
            (context, restaurant, _) => Row(
              children: [
                // barra vertical de categorías
                NavigationRail(
                  selectedIndex: _tabController.index,
                  onDestinationSelected: _tabController.animateTo,
                  labelType: NavigationRailLabelType.all,
                  destinations:
                      FoodCategory.values.map((cat) {
                        final name = cat.toString().split('.').last;
                        return NavigationRailDestination(
                          icon: const Icon(Icons.fastfood_outlined),
                          selectedIcon: const Icon(Icons.fastfood),
                          label: Text(name),
                        );
                      }).toList(),
                ),
                const VerticalDivider(thickness: 1, width: 1),
                // la parte derecha: slivers
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      // tu app bar con carrito y descripción
                      MySilverAppBar(
                        title: const SizedBox.shrink(),
                        child: Builder(
                          builder: (context) {
                            final isPhone =
                                MediaQuery.of(context).size.shortestSide < 600;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [if (isPhone) MyDescriptionBox()],
                            );
                          },
                        ),
                      ),
                      // aquí va el TabBarView llenando el resto
                      SliverFillRemaining(
                        child: TabBarView(
                          controller: _tabController,
                          children: getFoodInThisCategory(restaurant.menu),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
