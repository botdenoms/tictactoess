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
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  width: 120.0,
                  height: 40.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4F4242),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: const Center(
                    child: Text(
                      'Play',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontFamily: 'Imprima',
                      ),
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
      ),
    );
  }
}
