import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/components/my_current_location.dart';
import 'package:myapp/components/my_description_box.dart';
import 'package:myapp/components/my_drawer.dart';
import 'package:myapp/components/my_food_tile.dart';
import 'package:myapp/components/my_silver_app_bar.dart';
import 'package:myapp/components/my_tab_bar.dart';
import 'package:myapp/features/catalog/presentation/cubits/restaurant_cubit.dart';
import 'package:myapp/features/catalog/presentation/cubits/restaurant_states.dart';
import 'package:myapp/features/kiosk/domain/entities/food.dart';
import 'package:myapp/features/kiosk/presentation/pages/food_page.dart';

class HomeKioskPage extends StatefulWidget {
  const HomeKioskPage({super.key});

  @override
  State<HomeKioskPage> createState() => _HomeKioskPageState();
}

class _HomeKioskPageState extends State<HomeKioskPage>
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
      body: BlocBuilder<RestaurantCubit, RestaurantState>(
        builder: (context, state) {
          if (state is RestaurantLoaded) {
            return Row(
              children: [
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
                Expanded(
                  child: CustomScrollView(
                    slivers: [
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
                      SliverFillRemaining(
                        child: TabBarView(
                          controller: _tabController,
                          children: getFoodInThisCategory(state.menu), // ✅ AQUI
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is RestaurantError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
