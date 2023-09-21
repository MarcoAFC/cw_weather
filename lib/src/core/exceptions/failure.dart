class Failure implements Exception {
  final String message;

  const Failure({required this.message});

  static Failure get generic {
    return const Failure(
        message: "An internal error has ocurred, please try again later.");
  }
}
