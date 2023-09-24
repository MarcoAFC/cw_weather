import 'package:cw_weather/src/weather_module/domain/entities/city.dart';
import 'package:cw_weather/src/weather_module/domain/repositories/connectivity_repository.dart';
import 'package:cw_weather/src/weather_module/domain/repositories/open_weather_repository.dart';
import 'package:cw_weather/src/weather_module/pages/cities/view_models/cities_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockRepo extends Mock implements OpenWeatherRepository {}

class MockConnectivity extends Mock implements ConnectivityRepository {}

void main() {
  group('City viewmodel tests', () {
    var repository = MockRepo();
    var connectivity = MockConnectivity();
    var vm = CitiesViewModel(repository: repository, connectivity: connectivity);
    setUp(() => vm = CitiesViewModel(repository: repository, connectivity: connectivity));
    test('Cities view model fetches data when searching', () {
      when(() => connectivity.checkConnectivity()).thenAnswer((invocation) async => true);
      when(() => repository.getCities(hasConnection: true, query: 'query')).thenAnswer((invocation) async => (null, <City>[]));
      vm.citiesNotifier.addListener(() {
        expect(vm.citiesNotifier.value, []);
      });
      vm.onSearch('query');
    });

    test('Cities view model fetches data when searching with no connection', () {
      when(() => connectivity.checkConnectivity()).thenAnswer((invocation) async => false);
      when(() => repository.getCities(hasConnection: false, query: 'query')).thenAnswer((invocation) async => (null, <City>[]));
      vm.citiesNotifier.addListener(() {
        expect(vm.citiesNotifier.value, []);
      });
      vm.onSearch('query');
    });

    test('Cities view model trigger search bar triggers', () {
      vm.citiesNotifier.addListener(() {
        expect(vm.showSearchBar.value, true);
      });
      vm.triggerSearchBar();
    });
  });
}
