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
  List<String> _board = List.filled(9, "");
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
            const SizedBox(height: 5.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(0xFF4F4242),
                    size: 28.0,
                  ),
                ),
                const PlayerTile(index: 1),
                ScoreTile(x: _humanScore, y: _aiScore),
                const PlayerTile(index: 0),
                const SizedBox(width: 10.0),
              ],
            ),
            const SizedBox(height: 40.0),
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

  void _checkEnd(List<String> board) async {
    /* 
    0 1 2
    3 4 5
    6 7 8
    */
    // if all pieces a filled
    if (_options.isEmpty) {
      print('its a draw');
      await _endDialog('draw');
    }
    // first row check
    if (board[0] == board[1] && board[0] == board[2] && board[0] != "") {
      print('${board[0]} wins');
      await _endDialog(board[0]);
    }
    // second row check
    if (board[3] == board[4] && board[3] == board[5] && board[3] != "") {
      print('${board[3]} wins');
      await _endDialog(board[3]);
    }
    // third row check
    if (board[6] == board[7] && board[6] == board[8] && board[6] != "") {
      print('${board[6]} wins');
      await _endDialog(board[6]);
    }
    // first column check
    if (board[0] == board[3] && board[0] == board[6] && board[0] != "") {
      print('${board[0]} wins');
      await _endDialog(board[0]);
    }
    // second column check
    if (board[1] == board[4] && board[1] == board[7] && board[1] != "") {
      print('${board[1]} wins');
      await _endDialog(board[1]);
    }
    // third column check
    if (board[2] == board[5] && board[2] == board[8] && board[2] != "") {
      print('${board[2]} wins');
      await _endDialog(board[2]);
    }
    // first cross
    if (board[0] == board[4] && board[0] == board[8] && board[0] != "") {
      print('${board[0]} wins');
      await _endDialog(board[0]);
    }
    // second cross
    if (board[2] == board[4] && board[2] == board[6] && board[2] != "") {
      print('${board[2]} wins');
      await _endDialog(board[2]);
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

  Future<void> _endDialog(String outcome) async {
    String end = 'Its A draw';
    if (outcome == 'x') {
      end = 'You won';
      _humanScore += 1;
    } else if (outcome == 'o') {
      end = 'You Lost';
      _aiScore += 1;
    }
    setState(() {
      _options.clear();
    });
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 30.0,
          ),
          backgroundColor: const Color(0xFF393131),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  end,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontFamily: 'Imprima',
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'You',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'Imprima',
                      ),
                    ),
                    const Text(
                      'X',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontFamily: 'Imprima',
                      ),
                    ),
                    Text(
                      _humanScore.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'Imprima',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pc/A.I',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'Imprima',
                      ),
                    ),
                    const Text(
                      'O',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontFamily: 'Imprima',
                      ),
                    ),
                    Text(
                      _aiScore.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'Imprima',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _options = [0, 1, 2, 3, 4, 5, 6, 7, 8];
                      _moves = 0;
                      _board = List.filled(9, "");
                    });
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.refresh_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
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
