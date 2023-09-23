import 'package:cw_weather/src/core/widgets/text/text_body.dart';
import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  final String text;
  const FailureWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 24.0,),
          const SizedBox(height: 16.0,),
          TextBody(text: text,)
        ],
      ),
    );
  }
}