import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  final Function(bool) tapAction;

  const ProfileView({
    super.key,
    required this.tapAction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent.shade700,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => tapAction(true),
          child: Icon(Icons.menu, size: 35,),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(child: Text("Profile")),
    );
  }
}
