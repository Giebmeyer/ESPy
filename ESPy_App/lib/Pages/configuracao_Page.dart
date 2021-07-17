import 'package:flutter/material.dart';

Widget menuDeOpcoes() {
  return BottomNavigationBar(
    currentIndex: 0,
    items: [
      BottomNavigationBarItem(
          icon: Icon(Icons.door_back_outlined), title: Text("Sair")),
      BottomNavigationBarItem(icon: Icon(Icons.nature), title: Text("")),
    ],
  );
}
