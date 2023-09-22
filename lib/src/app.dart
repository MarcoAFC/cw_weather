import 'package:cw_weather/src/weather_module/pages/cities/view/cities_page.dart';
import 'package:cw_weather/src/weather_module/pages/weather/view/weather_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CitiesPage(),
      color: Colors.purple,
      routes: {
        '/' : (context) => const CitiesPage(),
        '/forecast/:id' : (context) => const WeatherPage(),

      },
    );
  }
}