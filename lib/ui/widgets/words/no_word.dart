import 'package:flutter/material.dart';

class NoWord extends StatelessWidget {
  const NoWord({Key? key}) : super(key: key);
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
