import 'package:cw_weather/src/weather_module/domain/repositories/connectivity_repository.dart';
import 'package:cw_weather/src/weather_module/domain/repositories/open_weather_repository.dart';
import 'package:flutter/material.dart';

import 'package:cw_weather/src/core/exceptions/failure.dart';
import 'package:cw_weather/src/weather_module/domain/entities/city.dart';

class CitiesViewModel {
  final OpenWeatherRepository repository;
  final ConnectivityRepository connectivity;
  final ValueNotifier<List<City>?> citiesNotifier = ValueNotifier(null);
  final ValueNotifier<Failure?> errorNotifier = ValueNotifier(null);
  final ValueNotifier<bool> showSearchBar = ValueNotifier(false);

  CitiesViewModel({
    required this.repository,
    required this.connectivity,
  });

  Future<void> _fetchData(String? query) async {
    citiesNotifier.value = null;
    errorNotifier.value = null;
    bool connection = await connectivity.checkConnectivity();
    var data =
        await repository.getCities(query: query, hasConnection: connection);

    if (data.$2 != null) {
      if (connection || query == null) {
        citiesNotifier.value = data.$2;
      } else {
        citiesNotifier.value = data.$2!
            .where((element) => element.name.toLowerCase()
            .contains(query))
            .toList();
      }
    } else if (data.$1 != null) {
      errorNotifier.value = data.$1;
    }
  }

  void triggerSearchBar({bool? value}) {
    showSearchBar.value = value ?? !showSearchBar.value;
    if (showSearchBar.value == false) {
      _fetchData(null);
    }
  }

  void onSearch(String? query, {bool? value}) {
    if (query != null && query.isNotEmpty) {
      _fetchData(query);
    } else {
      triggerSearchBar(value: value);
    }
  }
}
