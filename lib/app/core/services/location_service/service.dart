import 'package:geolocator/geolocator.dart';
import 'package:weather_forecast_app/app/core/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:weather_forecast_app/app/core/components/buttons/custom_button.dart';
import 'package:weather_forecast_app/app/core/components/text/custom_text.dart';

abstract class LocationsService {
  Future<bool> handleLocationPermission();
  Future<void> requestLocationPermission();
}

class LocationsServiceImpl implements LocationsService {
  @override
  Future<bool> handleLocationPermission() async {
    LocationPermission permission;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      const CustomBottomSheet(
        content:
            CustomText(text: 'Location permissions should be enabled.', textType: TextType.small),
        primaryButton: CustomButton(
          ButtonParameters(text: 'Enable'),
          ButtonType.primaryBlue,
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        const CustomBottomSheet(
          content: CustomText(text: 'Location permissions are denied.', textType: TextType.small),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      const CustomBottomSheet(
        content: CustomText(
            text: 'Location permissions are permanently denied, we cannot request permissions.',
            textType: TextType.small),
      );
      return false;
    }
    return true;
  }

  @override
  Future<void> requestLocationPermission() async {
    await Geolocator.requestPermission();
  }
}
