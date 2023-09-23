import 'package:cw_weather/src/core/widgets/failure_widget.dart';
import 'package:cw_weather/src/core/widgets/text/text_title.dart';
import 'package:cw_weather/src/weather_module/entities/city.dart';
import 'package:cw_weather/src/weather_module/pages/weather/view/widgets/weather_card.dart';
import 'package:cw_weather/src/weather_module/pages/weather/view_models/weather_view_model.dart';
import 'package:flutter/material.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key, required this.viewModel});
  final WeatherViewModel viewModel;
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  late City city;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    city = ModalRoute.of(context)?.settings.arguments as City;
    widget.viewModel.fetchData(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextTitle(text: "Weather"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AnimatedBuilder(
              animation: Listenable.merge([
                widget.viewModel.weatherNotifier,
                widget.viewModel.errorNotifier
              ]),
              builder: (context, _) {
                var weather = widget.viewModel.weatherNotifier.value;
                var error = widget.viewModel.errorNotifier.value;
                if (error != null) {
                  return Center(
                    child: FailureWidget(text: error.message),
                  );
                } else if (weather == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } 
                return WeatherCard(weather: weather, name: city.name);
              })),
    );
  }
}
