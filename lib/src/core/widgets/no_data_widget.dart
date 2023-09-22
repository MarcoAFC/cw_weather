import 'package:cw_weather/src/core/widgets/text/text_body.dart';
import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(Icons.warning_outlined, size: 24.0,),
        SizedBox(height: 16.0,),
        TextBody(text: "No data was found, plase check your connectivity or try a different query.")
      ]
    );
  }
}