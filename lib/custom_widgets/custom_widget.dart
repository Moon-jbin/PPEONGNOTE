import 'package:flutter/material.dart';

class CustomWidget {
  static Widget playerScoreTF(
      {required String playerName, required TextEditingController controller}) {
    return Row(
      children: [
        Text(playerName),
        Container(
            width: 100,
            height: 20,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: controller,
              style: TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.zero),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.zero),
              ),
            ))
      ],
    );
  }
}
