class Failure implements Exception {
  final String message;

  const Failure({required this.message});

  static Failure get generic {
    return const Failure(
        message: "An internal error has ocurred, please try again later.");
  }

  static Failure get noDataAndConnectivity {
    return const Failure(
        message: "No data has been stored and no connection is available, please connect and try again.");
  }
}
