import 'package:cw_weather/src/core/widgets/text/text_subtitle.dart';
import 'package:cw_weather/src/core/widgets/text/text_title.dart';
import 'package:flutter/material.dart';

import 'package:cw_weather/src/weather_module/entities/city.dart';

class CityCardWidget extends StatelessWidget {
  const CityCardWidget({
    Key? key,
    required this.city,
  }) : super(key: key);

  final City city;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
        child: ListTile(
          title: TextTitle(text: city.name),
          subtitle: TextSubtitle(text: city.state),
        ),
      ),
    );
  }
}
