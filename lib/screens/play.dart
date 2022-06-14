// ignore_for_file: avoid_print

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
  final List<String> _board = List.filled(9, "");
  List<int> _options = [];
  String _current = '';
  bool _loading = false;
  int _humanScore = 0, _aiScore = 0, _moves = 0;

  @override
  void initState() {
    super.initState();
    _initGame();
  }

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
                const PlayerTile(index: 1),
                ScoreTile(x: _humanScore, y: _aiScore),
                const PlayerTile(index: 0),
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
                  return Tile(
                    owner: _board[index],
                    position: index,
                    trigger: _playHandler,
                  );
                },
                itemCount: _board.length,
              ),
            ),
            HelperText(
              message: _loading ? 'A.I is playing' : 'It`s your turn to play',
            ),
          ],
        ),
      ),
    );
  }

  void _updateBoard(List<String> board, int pos, String owner) {
    _moves += 1;
    // set the board pos owner

    // remove the position in options list
    _options.removeWhere((element) => element == pos);
    //check for a winner
    setState(() {
      _board[pos] = owner;
    });
    if (_moves >= 3) {
      _checkEnd(_board);
    }
    if (owner == 'x') {
      _aiPlay(_board, 'o');
    }
  }

  void _checkEnd(List<String> board) {
    /* 
    0 1 2
    3 4 5
    6 7 8
    */
    // first row check
    if (board[0] == board[1] && board[0] == board[2] && board[0] != "") {
      print('${board[0]} wins');
    }
    // second row check
    if (board[3] == board[4] && board[3] == board[5] && board[3] != "") {
      print('${board[3]} wins');
    }
    // third row check
    if (board[6] == board[7] && board[6] == board[8] && board[6] != "") {
      print('${board[6]} wins');
    }
    // first column check
    if (board[0] == board[3] && board[0] == board[6] && board[0] != "") {
      print('${board[0]} wins');
    }
    // second column check
    if (board[1] == board[4] && board[1] == board[7] && board[1] != "") {
      print('${board[1]} wins');
    }
    // third column check
    if (board[2] == board[5] && board[2] == board[8] && board[2] != "") {
      print('${board[2]} wins');
    }
    // first cross
    if (board[0] == board[4] && board[0] == board[8] && board[0] != "") {
      print('${board[0]} wins');
    }
    // second cross
    if (board[2] == board[4] && board[2] == board[6] && board[2] != "") {
      print('${board[2]} wins');
    }
    // if all pieces a filled
    if (_options.isEmpty) {
      print('its a draw');
    }
  }

  void _aiPlay(List<String> board, String owner) async {
    if (_options.isEmpty) return;
    setState(() {
      _loading = true;
    });
    // shuffle the options list
    _options.shuffle();
    // pick a choice
    int choice = _options.last;
    // delay to simulate thinking
    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _loading = false;
      });
    });
    // call update board
    _updateBoard(_board, choice, owner);
  }

  void _playHandler(String current, int pos) {
    if (pos == -1) return;
    if (current == "x") {
      _updateBoard(_board, pos, current);
    } else {
      _aiPlay(_board, current);
    }
  }

  void _initGame() {
    // init the used variable
    _options = [0, 1, 2, 3, 4, 5, 6, 7, 8];
    _current = "x";
    _humanScore = 0;
    _aiScore = 0;
    _moves = 0;
    //start the game
    _playHandler(_current, -1);
  }
}
