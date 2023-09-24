import 'package:cw_weather/src/core/widgets/text/text_body.dart';
import 'package:cw_weather/src/core/widgets/text/text_subtitle.dart';
import 'package:cw_weather/src/core/widgets/text/text_title.dart';
import 'package:cw_weather/src/weather_module/domain/entities/weather.dart';
import 'package:flutter/material.dart';

class WeatherCardWidget extends StatelessWidget {
  final Weather weather;
  final String name;

  const WeatherCardWidget(
      {super.key, required this.weather, required this.name});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Colors.white,
              Color(0xFF0099FF),
            ],
            stops: <double>[-0.5, 0.5],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextTitle(text: name),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextSubtitle(text: weather.weather),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextBody(text: weather.description),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextBody(text: '${weather.temperature} ºC'),
                ],
              ),
            ),
            Image.network(
              "https://openweathermap.org/img/wn/${weather.icon}@4x.png",
              errorBuilder: (context, _, __) {
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}
