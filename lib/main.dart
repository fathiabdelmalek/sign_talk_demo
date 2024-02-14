import 'package:flutter/material.dart';
import 'package:takalem_sign_talk_demo/pages/account.dart';
import 'package:takalem_sign_talk_demo/pages/store.dart';
import 'package:takalem_sign_talk_demo/pages/translate.dart';
import 'package:takalem_sign_talk_demo/widgets/navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TAKALEM Sign Talk Demo'),
        ),
        bottomNavigationBar: MainNav(
          onDestinationSelected: (int index) {
            setState(() {
              pageIndex = index;
            });
          },
          selectedIndex: pageIndex,
        ),
        body: <Widget>[
          const TranslatePage(),
          const StorePage(),
          const AccountPage(),
        ][pageIndex],
      ),
    );
  }
}
