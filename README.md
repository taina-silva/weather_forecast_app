## **Weather Forecast App**

A fully functional mobile application built using Flutter. This app consumes a public API and implements key features including UI/UX, state management, API integration, and error handling.

This app allows users to search for a city and view the current weather and a 7-day weather forecast.

### **Architecture**

The application was constructed based on a code modularization using Flutter Modular. This way, within the `lib/app` folder, we have the `core` and `modules` sections. In `core`, we have everything common to the entire application, that is, which can be used in any feature. Therefore, it includes generic widgets such as buttons, bottom sheets, app bars, scaffolds, and text widgets, all customizable according to the location of use but following a predefined configuration and styling to avoid code duplication and rework. In addition, the `core` contains the most generic services, such as `NetworkService`, `LoggerService` (to log errors or even normal information, such as navigation routes), `LocalStorage` (to handle local data storage), among others. There are also some global classes, methods, and constants.

When entering the `modules` section, we have the separation of features. In the case of this application, we have the development of two features: `splash` and `home`.
The `splash` handles the opening of the application itself, just to attract the user's attention, presenting a Splash Screen with the application logo.
In the `home` module, we have all the data retrieval and manipulation to present the correct and consistent information to the user. In this feature, there is a separation between `infra` (to handle the retrieval of data from external APIs and error handling) and `presentation` (to handle data management and states for building screens for the user).

### **API Integration**

To retrieve the data related to the 7-day weather forecast, the following APIs were used:

- **Open Meteo ([https://open-meteo.com/en/docs](https://open-meteo.com/en/docs#timezone=America%2FSao_Paulo)):** A free API that returns weather information for a given location following various structures, including on a daily basis, considering the current day and the next 6 days (method used in this application).

_Note: The OpenWeatherMap API () was not used because, to obtain daily forecasts, it would be necessary to register and provide payment information. After a certain number of requests, the use of the API becomes paid._

- **Geo API ([https://openweathermap.org/api/geocoding-api](https://openweathermap.org/api/geocoding-api)):** API used to retrieve latitude and longitude coordinates from a specific location - city and country. This is because the weather forecast API requires sending such coordinates as parameters.

### **Running the Project**

To easily run the application, it is recommended to create a file like `.env/dev.json` to specify the variables used to build the app. For example:

```json
{
  "ENV": "dev",
  "PREVIEW_ENABLED": false,
  "WEATHER_API_URL": "https://api.open-meteo.com/v1/",
  "GEO_API_URL": "http://api.openweathermap.org/geo/1.0/",
  "API_KEY": "API_KEY"
}
```

### **Running Tests**

To run the tests, you can use RPS ([https://pub.dev/packages/rps](https://pub.dev/packages/rps)) to facilitate, as a script is already included in `pubspec.yaml` that uses this tool.
To activate RPS, run `dart pub global activate rps` in the terminal.
Also, before running `rps test`, run the following command to activate the Flutter test coverage package: `dart pub global activate full_coverage`.
