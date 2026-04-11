import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  final Function(bool) tapAction;

  const DashboardView({
    super.key,
    required this.tapAction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent.shade100,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => tapAction(true),
          child: Icon(Icons.menu, size: 35,),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(child: Text("Home")),
    );
  }
}
