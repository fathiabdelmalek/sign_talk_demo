import 'package:flutter/material.dart';

class MainNav extends StatelessWidget {
  final ValueChanged<int> onDestinationSelected;
  final int selectedIndex;

  const MainNav({
    Key? key,
    required this.onDestinationSelected,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      selectedIndex: selectedIndex,
      destinations: const <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.translate),
          label: "Translate",
        ),
        NavigationDestination(
          icon: Icon(Icons.store),
          label: "Store",
        ),
        NavigationDestination(
          icon: Icon(Icons.account_circle),
          label: "Circle",
        ),
      ],
    );
  }
}
