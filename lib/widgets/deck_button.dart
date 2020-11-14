import 'package:flutter/material.dart';

class DeckButton extends StatelessWidget {
  const DeckButton({
    @required this.text,
    this.onTap,
  });

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          print(text);
        },
        child: Container(
          margin: EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
