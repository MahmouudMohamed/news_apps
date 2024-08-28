import 'package:flutter/material.dart';

class RowItem extends StatelessWidget {
  IconData? icon;
  String name;
   RowItem({required this.name,required this.icon,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(
            width: 10,
          ),
          Text(name)
        ],
      ),
    );
  }
}
