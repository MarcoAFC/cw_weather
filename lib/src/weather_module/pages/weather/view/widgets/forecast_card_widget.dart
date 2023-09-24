import 'package:cw_weather/src/core/widgets/text/text_body.dart';
import 'package:cw_weather/src/core/widgets/text/text_subtitle.dart';
import 'package:cw_weather/src/weather_module/domain/entities/weather.dart';
import 'package:flutter/material.dart';

class ForecastCardWidget extends StatelessWidget {
  final Weather weather;

  const ForecastCardWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color(0xFF0099FF),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBody(
                      text:
                          "${weather.dt.day.toString().padLeft(2, '0')}/${weather.dt.month.toString().padLeft(2, '0')}/${weather.dt.year}"),
                  const SizedBox(
                    height: 4.0,
                  ),
                  TextSubtitle(text: weather.weather),
                  const SizedBox(
                    height: 4.0,
                  ),
                  TextBody(
                    text: '${weather.temperature} ºC',
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Image.network(
              "https://openweathermap.org/img/wn/${weather.icon}.png",
              errorBuilder: (context, _, __) {
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
