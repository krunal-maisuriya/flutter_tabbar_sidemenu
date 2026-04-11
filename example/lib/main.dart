import 'dart:ui';
import 'package:example/src/tabbar/dashboard_view.dart';
import 'package:example/src/tabbar/profile_view.dart';
import 'package:example/src/tabbar/search_view.dart';
import 'package:flutter/material.dart';
import 'package:my_tabbar_sidebar_library/my_tabbar_sidebar_library.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  int index = 0;
  bool isOpenDrawer = false;

  late final pages = [
    DashboardView(tapAction: (value) {
      setState(() => isOpenDrawer = value);
    }),
    SearchView(tapAction: (value) {
      setState(() => isOpenDrawer = value);
    }),
    ProfileView(tapAction: (value) {
      setState(() => isOpenDrawer = value);
    }),
  ];

  final List<IconData> icons = [Icons.home, Icons.search, Icons.person];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            pages[index],

            Positioned(
              bottom: 20, left: 0, right: 0,
              child: CustomMainTabbarView(
                currentIndex: index,
                icons: icons,
                onTap: (i) => setState(() => index = i),
              ),
            ),

            if (isOpenDrawer)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: GestureDetector(
                    onTap: () => { setState(() => isOpenDrawer = false ),},
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ),

            SideDrawerMenuView(isOpenDrawer: isOpenDrawer),
          ],
        ),
      ),
    );
  }
}
