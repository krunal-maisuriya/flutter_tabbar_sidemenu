import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  final Function(bool) tapAction;

  const SearchView({
    super.key,
    required this.tapAction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade600,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => tapAction(true),
          child: Icon(Icons.menu, size: 35,),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(child: Text("Search")),
    );
  }
}
