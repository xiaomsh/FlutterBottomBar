import 'package:flutter/material.dart';

import '../data/bar_data.dart';

class CommonPage extends StatefulWidget {
  const CommonPage({super.key});

  @override
  State<StatefulWidget> createState() => _CommonPageState();
}

class _CommonPageState extends State<CommonPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Common Bar'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("${BarItem.commonItems[_currentIndex].label}"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: BarItem.commonItems,
        onTap: (index) {
          _currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
