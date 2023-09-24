import 'package:cw_weather/src/core/widgets/failure_widget.dart';
import 'package:cw_weather/src/core/widgets/text/text_title.dart';
import 'package:cw_weather/src/weather_module/domain/entities/city.dart';
import 'package:cw_weather/src/weather_module/pages/weather/view/widgets/forecast_carousel_widget.dart';
import 'package:cw_weather/src/weather_module/pages/weather/view/widgets/weather_card_widget.dart';
import 'package:cw_weather/src/weather_module/pages/weather/view_models/forecast_view_model.dart';
import 'package:cw_weather/src/weather_module/pages/weather/view_models/weather_view_model.dart';
import 'package:flutter/material.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage(
      {super.key,
      required this.weatherViewModel,
      required this.forecastViewModel});
  final WeatherViewModel weatherViewModel;
  final ForecastViewModel forecastViewModel;
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late City city;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    city = ModalRoute.of(context)?.settings.arguments as City;
    widget.weatherViewModel.fetchData(city);
    widget.forecastViewModel.fetchData(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextTitle(text: "Weather"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              AnimatedBuilder(
                  animation: Listenable.merge([
                    widget.weatherViewModel.weatherNotifier,
                    widget.weatherViewModel.errorNotifier
                  ]),
                  builder: (context, _) {
                    var weather = widget.weatherViewModel.weatherNotifier.value;
                    var error = widget.weatherViewModel.errorNotifier.value;
                    if (error != null) {
                      return Center(
                        child: FailureWidget(text: error.message),
                      );
                    } else if (weather == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return WeatherCardWidget(
                      weather: weather,
                      name: city.name,
                    );
                  }),
              const SizedBox(
                height: 16.0,
              ),
              AnimatedBuilder(
                  animation: Listenable.merge([
                    widget.forecastViewModel.forecastNotifier,
                    widget.forecastViewModel.errorNotifier
                  ]),
                  builder: (context, _) {
                    var weather =
                        widget.forecastViewModel.forecastNotifier.value;
                    var error = widget.forecastViewModel.errorNotifier.value;
                    if (error != null) {
                      return Center(
                        child: FailureWidget(text: error.message),
                      );
                    } else if (weather == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ForecastCarouselWidget(items: weather);
                  }),
            ],
          )),
    );
  }
}
