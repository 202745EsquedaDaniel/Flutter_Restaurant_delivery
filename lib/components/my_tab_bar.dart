import 'package:flutter/material.dart';
import 'package:myapp/models/food.dart';

class MyTabBar extends StatelessWidget {
  final TabController tabController;
  const MyTabBar({super.key, required this.tabController});

  List<Tab> _buildCategoryTabs() {
    return FoodCategory.values.map((category) {
      return Tab(text: category.toString().split(".").last);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        controller: tabController,
        tabs: [
          // 1st tab
          Tab(icon: Icon(Icons.home)),
          // second tab
          Tab(icon: Icon(Icons.settings)),
          // third tab
          Tab(icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
