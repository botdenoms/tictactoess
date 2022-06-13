import 'package:flutter/material.dart';
import 'package:tictactoess/screens/widgets/board_tile.dart';
import 'package:tictactoess/screens/widgets/helper_text.dart';
import 'package:tictactoess/screens/widgets/player_tile.dart';
import 'package:tictactoess/screens/widgets/score_tile.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final List<String> _board = List.filled(9, "O");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(0xFF4F4242),
                  ),
                ),
                const PlayerTile(index: 0),
                const ScoreTile(x: 0, y: 0),
                const PlayerTile(index: 1),
                const SizedBox(width: 10.0),
              ],
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Tile(owner: _board[index], position: index);
                },
                itemCount: _board.length,
              ),
            ),
            const HelperText(message: 'It`s your turn to play'),
          ],
        ),
      ),
    );
  }
}
