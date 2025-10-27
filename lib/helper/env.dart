abstract class EnvConfig {
  static String baseUrl = const String.fromEnvironment("BASE_URL");
  static String token = const String.fromEnvironment("TOKEN");
  static String lockerId = const String.fromEnvironment("LOCKER_ID");
  static String buildingId = const String.fromEnvironment("BUILDING_ID");
}
