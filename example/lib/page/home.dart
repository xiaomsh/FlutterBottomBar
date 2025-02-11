import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: ElevatedButton(
              child: const Text("Common Bar"),
              onPressed: () {
                Navigator.pushNamed(context, "/common");
              },
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 15, top: 15, right: 15),
            child: ElevatedButton(
              child: const Text("Wave Bar"),
              onPressed: () {
                Navigator.pushNamed(context, "/wave");
              },
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 15, top: 15, right: 15),
            child: ElevatedButton(
              child: const Text("Use"),
              onPressed: () {
                Navigator.pushNamed(context, "/use");
              },
            ),
          ),
        ],
      ),
    );
  }
}
