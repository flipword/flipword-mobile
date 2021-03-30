import 'package:flutter/material.dart';

class NoWord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'No word',
            style: TextStyle(fontSize: 25),
          ),
          Text(
            'Click on "+" to add a word',
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
