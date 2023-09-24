import 'package:cw_weather/src/weather_module/domain/repositories/open_weather_repository.dart';
import 'package:flutter/material.dart';

import 'package:cw_weather/src/core/exceptions/failure.dart';
import 'package:cw_weather/src/weather_module/domain/entities/city.dart';

class CitiesViewModel {
  final OpenWeatherRepository repository;
  final ValueNotifier<List<City>?> citiesNotifier = ValueNotifier(null);
  final ValueNotifier<Failure?> errorNotifier = ValueNotifier(null);
  final ValueNotifier<bool> showSearchBar = ValueNotifier(false);

  CitiesViewModel({
    required this.repository,
  });

  Future<void> _fetchData(String? query) async {
    citiesNotifier.value = null;
    errorNotifier.value = null;
    var data = await repository.getCities(query: query, hasConnection: true);

    if (data.$2 != null) {
      citiesNotifier.value = data.$2;
    } else if (data.$1 != null) {
      errorNotifier.value = data.$1;
    }
  }

  void triggerSearchBar() {
    showSearchBar.value = !showSearchBar.value;
  }

  void submitSearch(String query) {
    triggerSearchBar();
    _fetchData(query);
  }

  void onSearch(String query) {
    if (query.isNotEmpty) {
      _fetchData(query);
    }
    else{
      triggerSearchBar();
    }
  }
}
