import 'package:cw_weather/src/core/network/http_service.dart';
import 'package:cw_weather/src/core/network/impl/dio_service.dart';
import 'package:cw_weather/src/weather_module/data/datasources/open_weather_datasource.dart';
import 'package:cw_weather/src/weather_module/pages/cities/view_models/cities_view_model.dart';
import 'package:cw_weather/src/weather_module/pages/weather/view_models/weather_view_model.dart';
import 'package:get_it/get_it.dart';

class DependencyHandler{
  static final DependencyHandler _instance = DependencyHandler._internal();

  factory DependencyHandler() {
    return _instance;
  }
  
  DependencyHandler._internal() {
    registerDependencies();
  }


  final GetIt di = GetIt.I;

  void registerDependencies(){
    di.registerLazySingleton<HttpService>(() => DioService());
    di.registerLazySingleton<OpenWeatherDatasource>(() => OpenWeatherDatasource(http: di.get()));
    di.registerLazySingleton<CitiesViewModel>(() => CitiesViewModel(datasource: di.get()));
    di.registerLazySingleton<WeatherViewModel>(() => WeatherViewModel(datasource: di.get()));
  }

  T get<T extends Object>(){
    return di.get<T>(); 
  }
}