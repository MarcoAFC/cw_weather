class City {
  final double latitude;
  final double longitude;
  final String name;
  final String countryCode;
  final String? state;

  City(
      {required this.latitude,
      required this.longitude,
      required this.name,
      required this.countryCode,
      required this.state});
}
