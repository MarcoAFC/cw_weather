import 'package:cw_weather/src/core/local_storage/hive/hive_service.dart';
import 'package:cw_weather/src/core/local_storage/local_storage_service.dart';
import 'package:cw_weather/src/core/network/http_service.dart';
import 'package:cw_weather/src/core/network/impl/dio_service.dart';
import 'package:cw_weather/src/weather_module/data/datasources/open_weather_local_datasource.dart';
import 'package:cw_weather/src/weather_module/data/datasources/open_weather_remote_datasource.dart';
import 'package:cw_weather/src/weather_module/data/repositories/open_weather_repository_impl.dart';
import 'package:cw_weather/src/weather_module/domain/repositories/open_weather_repository.dart';
import 'package:cw_weather/src/weather_module/pages/cities/view_models/cities_view_model.dart';
import 'package:cw_weather/src/weather_module/pages/weather/view_models/forecast_view_model.dart';
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
    di.registerLazySingleton<LocalStorageService>(() => HiveService());
    di.registerLazySingleton<OpenWeatherRemoteDatasource>(() => OpenWeatherRemoteDatasource(http: di.get()));
    di.registerLazySingleton<OpenWeatherLocalDatasource>(() => OpenWeatherLocalDatasource(storage: di.get()));
    di.registerLazySingleton<OpenWeatherRepository>(() => OpenWeatherRepositoryImpl(local: di.get(), remote: di.get()));
    di.registerLazySingleton<CitiesViewModel>(() => CitiesViewModel(repository: di.get()));
    di.registerLazySingleton<WeatherViewModel>(() => WeatherViewModel(repository: di.get()));
    di.registerLazySingleton<ForecastViewModel>(() => ForecastViewModel(repository: di.get()));
  }

  T get<T extends Object>(){
    return di.get<T>(); 
  }
}