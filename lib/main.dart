import 'package:flutter/material.dart';
import 'package:takalem_sign_talk_demo/screens/account.dart';
import 'package:takalem_sign_talk_demo/screens/store.dart';
import 'package:takalem_sign_talk_demo/screens/translate.dart';
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
      title: 'TAKALEM Sign Talk Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TAKALEM Sign Talk'),
        ),
        bottomNavigationBar: MainNav(
          onDestinationSelected: (int index) {
            setState(() {
              pageIndex = index;
            });
          },
          selectedIndex: pageIndex,
        ),
        body: SafeArea(
          child: <Widget>[
            const TranslatePage(),
            const StorePage(),
            const AccountPage(),
          ][pageIndex],
        ),
      ),
    );
  }
}
