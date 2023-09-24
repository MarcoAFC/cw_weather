import 'package:cw_weather/src/weather_module/entities/weather.dart';
import 'package:cw_weather/src/weather_module/pages/weather/view/widgets/forecast_card_widget.dart';
import 'package:flutter/material.dart';

class ForecastCarouselWidget extends StatelessWidget {
  const ForecastCarouselWidget({super.key, required this.items});
  final List<Weather> items;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: PageView.builder(
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        padEnds: false,
        controller: PageController(
          viewportFraction: 0.5,
          initialPage: 0
        ),
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ForecastCardWidget(weather: items[index]),
          );
        }),
    );
  }
}