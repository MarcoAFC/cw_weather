import 'package:flutter/material.dart';

class TextBody extends StatelessWidget {
  const TextBody({
    Key? key,
    required this.text,
    this.overflow = TextOverflow.visible
  }) : super(key: key);
  final String text;
  final TextOverflow overflow;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, overflow: TextOverflow.visible),
    );
  }
}
