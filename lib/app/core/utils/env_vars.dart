abstract class EnvVars {
  static String get env => const String.fromEnvironment('ENV');
  static String get weatherApiUrl => const String.fromEnvironment('WEATHER_API_URL');
  static String get geoApiUrl => const String.fromEnvironment('GEO_API_URL');
  static String get apiKey => const String.fromEnvironment('OPEN_WEATHER_MAP_API_KEY');
  static bool get previewEnabled => const bool.fromEnvironment('PREVIEW_ENABLED');
}
