import 'package:cw_weather/src/core/widgets/text/text_subtitle.dart';
import 'package:cw_weather/src/core/widgets/text/text_title.dart';
import 'package:flutter/material.dart';

import 'package:cw_weather/src/weather_module/domain/entities/city.dart';

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
      borderRadius: BorderRadius.circular(16.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/weather', arguments: city);
        },
        child: Container(
          height: 160,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
          child: ListTile(
            title: TextTitle(text: city.name),
            subtitle:
                city.state != null ? TextSubtitle(text: city.state!) : null,
          ),
        ),
      ),
    );
  }
}
