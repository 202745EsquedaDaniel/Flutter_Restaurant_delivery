import 'package:flutter/material.dart';
import 'package:myapp/components/my_drawer_tile.dart';
import 'package:myapp/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // app logo
          Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Icon(
              Icons.lock_clock_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary, //
            ),
          ),

          //home list time
          MyDrawerTile(
            text: "H O M E ",
            icon: Icons.home,
            onTap: () => Navigator.pop(context), //
          ),

          //settings list time
          MyDrawerTile(
            text: "S E T T I N G S",
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),

          const Spacer(),

          // logout list tile
          MyDrawerTile(
            text: "L O G O U T",
            icon: Icons.logout,
            onTap: () {}, //
          ),

          SizedBox(height: 25),
        ],
      ),
    );
  }
}
