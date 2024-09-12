abstract class EnvVars {
  static String get env => const String.fromEnvironment('ENV');
  static String get apiURL => const String.fromEnvironment('API_URL');
  static String get apiKey => const String.fromEnvironment('OPEN_WEATHER_MAP_API_KEY');
  static bool get previewEnabled => const bool.fromEnvironment('PREVIEW_ENABLED');
}
