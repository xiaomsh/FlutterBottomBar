import 'package:flutter/material.dart';

class BarItem {
  static final List<BottomNavigationBarItem> commonItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home, size: 23, color: Colors.grey),
      activeIcon: Icon(Icons.home, size: 23, color: Colors.blue),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.add, size: 23, color: Colors.grey),
      activeIcon: Icon(Icons.add, size: 23, color: Colors.blue),
      label: "Add",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person, size: 23, color: Colors.grey),
      activeIcon: Icon(Icons.person, size: 23, color: Colors.blue),
      label: "Me",
    ),
  ];

  static final List<BottomNavigationBarItem> simpleUse = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.home, size: 23, color: Colors.grey),
      activeIcon: ClipOval(
        child: Container(
          width: 45,
          height: 45,
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Icon(Icons.home, size: 35, color: Colors.white),
        ),
      ),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.add, size: 23, color: Colors.grey),
      activeIcon: ClipOval(
        child: Container(
          width: 45,
          height: 45,
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Icon(Icons.add, size: 35, color: Colors.white),
        ),
      ),
      label: "Add",
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.person, size: 23, color: Colors.grey),
      activeIcon: ClipOval(
        child: Container(
          width: 45,
          height: 45,
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Icon(Icons.person, size: 35, color: Colors.white),
        ),
      ),
      label: "Me",
    ),
  ];

  static final List<BottomNavigationBarItem> fixed = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home, size: 23, color: Colors.grey),
      activeIcon: Icon(Icons.home, size: 23, color: Colors.blue),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: ClipOval(
        child: Container(
          width: 45,
          height: 45,
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Icon(Icons.add, size: 35, color: Colors.white),
        ),
      ),
      activeIcon: ClipOval(
        child: Container(
          width: 45,
          height: 45,
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Icon(Icons.add, size: 35, color: Colors.white),
        ),
      ),
      label: "Add",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person, size: 23, color: Colors.grey),
      activeIcon: Icon(Icons.person, size: 23, color: Colors.blue),
      label: "Me",
    ),
  ];
}
