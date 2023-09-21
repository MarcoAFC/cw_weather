class CurrentWeather {
  final int id;
  final String weather;
  final String description;
  final String icon;
  final double temperature;

  CurrentWeather(
      {required this.id,
      required this.weather,
      required this.description,
      required this.icon,
      required this.temperature});
}
