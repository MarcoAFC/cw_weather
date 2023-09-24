class Weather {
  final int id;
  final String weather;
  final String description;
  final String icon;
  final num temperature;
  final DateTime dt;

  Weather(
      {required this.id,
      required this.weather,
      required this.description,
      required this.icon,
      required this.temperature,
      required this.dt});
}
