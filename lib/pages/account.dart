import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
      shadowColor: Colors.transparent,
      margin: EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: Center(
          child: Text('Account page'),
        ),
      ),
    );
  }
}
