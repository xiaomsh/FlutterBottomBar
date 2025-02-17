import 'package:flutter/material.dart';

class ItemColorWidget extends StatelessWidget {
  final String title;
  final Color color;
  final Function() onTap;

  const ItemColorWidget({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(title),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                onTap();
              },
              child: Container(
                color: color,
                margin: const EdgeInsets.only(left: 20, right: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
