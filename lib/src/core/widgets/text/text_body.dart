import 'package:flutter/material.dart';

class TextBody extends StatelessWidget {
  const TextBody({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
    );
  }
}
