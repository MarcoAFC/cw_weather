import 'package:cw_weather/src/core/widgets/no_data_widget.dart';
import 'package:cw_weather/src/weather_module/pages/cities/view/widgets/city_list_widget.dart';
import 'package:flutter/material.dart';

import 'package:cw_weather/src/weather_module/pages/cities/view_models/cities_view_model.dart';

class CitiesPage extends StatelessWidget {
  final CitiesViewModel viewModel;

  const CitiesPage({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedBuilder(
          animation: Listenable.merge(
              [viewModel.citiesNotifier, viewModel.errorNotifier]),
          builder: (context, child) {
            var cities = viewModel.citiesNotifier.value;
            var error = viewModel.errorNotifier.value;

            if (error != null) {
              return Center(
                child: ErrorWidget(error.message),
              );
            } else if (cities == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (cities.isEmpty) {
              return const NoDataWidget();
            } else if (cities.isNotEmpty) {
              return CityListWidget(cities: cities);
            }
            return const SizedBox.shrink();
          }),
    );
  }
}
