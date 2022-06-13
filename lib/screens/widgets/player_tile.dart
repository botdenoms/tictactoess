import 'package:flutter/material.dart';

class PlayerTile extends StatelessWidget {
  const PlayerTile({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          index == 0 ? 'O' : 'X',
          style: const TextStyle(
            fontSize: 20.0,
            fontFamily: 'Imprima',
            color: Color(0xFF4F4242),
          ),
        ),
        Container(
          height: 2.0,
          width: 30.0,
          color: const Color(0xFF4F4242),
        ),
      ],
    );
  }
}
