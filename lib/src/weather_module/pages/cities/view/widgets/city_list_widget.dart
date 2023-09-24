import 'package:cw_weather/src/weather_module/pages/cities/view/widgets/city_card_widget.dart';
import 'package:flutter/material.dart';

import 'package:cw_weather/src/weather_module/domain/entities/city.dart';

class CityListWidget extends StatelessWidget {
  const CityListWidget({
    Key? key,
    required this.cities,
  }) : super(key: key);

  final List<City> cities;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: cities
          .map((e) => CityCardWidget(
                city: e,
              ))
          .toList(),
    );
  }
}
