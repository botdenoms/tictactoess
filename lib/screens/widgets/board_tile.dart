import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  const Tile(
      {Key? key,
      required this.position,
      required this.owner,
      required this.trigger})
      : super(key: key);
  final int position;
  final String owner;
  final Function trigger;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    if (widget.owner == "o" || widget.owner == 'x') {
      setState(() {
        _pressed = true;
      });
    } else {
      setState(() {
        _pressed = false;
      });
    }
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: Color(0xFF4F4242),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Center(
          child: Text(
            widget.owner,
            style: const TextStyle(fontSize: 28.0),
          ),
        ),
      ),
      onTap: () {
        // if pressed do nothing
        if (_pressed) return;
        setState(() {
          _pressed = !_pressed;
        });
        widget.trigger('x', widget.position);
      },
    );
  }
}
