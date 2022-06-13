import 'package:flutter/material.dart';

class ScoreTile extends StatelessWidget {
  const ScoreTile({Key? key, required this.x, required this.y})
      : super(key: key);

  final int x, y;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          x.toString(),
          style: const TextStyle(
            color: Color(0xFF000000),
            fontFamily: 'Imprima',
            fontSize: 22.0,
          ),
        ),
        const SizedBox(width: 10.0),
        const Text(
          ':',
          style: TextStyle(
            color: Color(0xFF4F4242),
            fontFamily: 'Imprima',
            fontSize: 22.0,
          ),
        ),
        const SizedBox(width: 10.0),
        Text(
          y.toString(),
          style: const TextStyle(
            color: Color(0xFF000000),
            fontFamily: 'Imprima',
            fontSize: 22.0,
          ),
        ),
      ],
    );
  }
}
