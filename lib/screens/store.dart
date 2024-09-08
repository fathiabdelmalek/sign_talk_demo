import 'package:flutter/material.dart';

class StorePage extends StatelessWidget {
  const StorePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
      shadowColor: Colors.transparent,
      margin: EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: Center(
          child: Text('Store page'),
        ),
      ),
    );
  }
}
