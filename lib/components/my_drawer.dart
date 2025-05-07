import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/components/my_drawer_tile.dart';
import 'package:myapp/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:myapp/features/kiosk/presentation/pages/settings_page.dart';
import 'package:myapp/features/pos/presentation/pages/POS_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // final authCubit = context.read<AuthCubit>(); // Not used directly here, but might be needed elsewhere

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // app logo or user info
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30.0,
                ), // Adjusted vertical padding
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              Divider(color: Theme.of(context).colorScheme.secondary),

              //home list time
              MyDrawerTile(
                title: "H O M E ",
                icon: Icons.home,
                onTap: () => Navigator.of(context).pop(),
              ),

              MyDrawerTile(
                title: "K I O S K O",
                icon: Icons.drive_eta,
                onTap: () => Navigator.pop(context),
              ),
              // POS VIEW
              MyDrawerTile(
                title: "P O S",
                icon: Icons.point_of_sale,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const POSPage()),
                  );
                },
              ),
              MyDrawerTile(
                title: "S E T T I N G S",
                icon: Icons.settings,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
              ),

              // Use Spacer only if using Column, not needed with ListView
              // const Spacer(),
              Divider(
                color: Theme.of(context).colorScheme.secondary,
              ), // Divider before logout
              // logout list tile
              MyDrawerTile(
                title: "L O G O U T",
                icon: Icons.logout,
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  context.read<AuthCubit>().logout();
                },
              ),

              const SizedBox(height: 25), // Add some padding at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
