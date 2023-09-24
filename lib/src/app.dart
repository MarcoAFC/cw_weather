import 'package:cw_weather/src/app_dependencies.dart';
import 'package:cw_weather/src/weather_module/pages/cities/view/cities_page.dart';
import 'package:cw_weather/src/weather_module/pages/weather/view/weather_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  App({super.key});
  final DependencyHandler handler = DependencyHandler();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.purple,
      routes: {
        '/' : (context) => CitiesPage(viewModel: handler.get(),),
        '/weather' : (context) => WeatherPage(weatherViewModel: handler.get(), forecastViewModel: handler.get(),),
      },
    );
  }
}