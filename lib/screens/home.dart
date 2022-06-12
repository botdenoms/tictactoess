import 'package:flutter/material.dart';
import 'screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFF4F4242),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF4F4242),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: const Text(
                  'Play',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontFamily: 'Imprima',
                  ),
                ),
              ),
              onTap: () {
                // play/start a new game run
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const PlayScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
