import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:weather_forecast_app/app/core/components/app_bar/custom_app_bar.dart';
import 'package:weather_forecast_app/app/core/components/buttons/custom_button.dart';
import 'package:weather_forecast_app/app/core/components/structure/custom_scaffold.dart';
import 'package:weather_forecast_app/app/core/components/text/custom_text.dart';
import 'package:weather_forecast_app/app/core/models/country/country_model.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/location/location_text_field.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/location_store.dart';

class SelectCountryPage extends StatefulWidget {
  const SelectCountryPage({super.key});

  @override
  State<SelectCountryPage> createState() => _SelectCountryPageState();
}

class _SelectCountryPageState extends State<SelectCountryPage> {
  final locationStore = Modular.get<LocationStore>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: Right(
          LocationTextField<CountryModel>(
            selectedLocation: locationStore.selectedCountry,
            onClear: () => locationStore.setSelectedCountry(null),
            getLocations: locationStore.getCountries,
            locationAsStr: (country) => country.name,
            labelText: 'Country',
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Space.normal),
        child: CustomButton(
          ButtonParameters(
            text: 'Go back',
            onTap: () => Modular.to.pop(),
          ),
          ButtonType.secondaryOrange,
        ),
      ),
      body: Observer(
        builder: (context) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final country = locationStore.countries[index];

                    return ListTile(
                      title: CustomText(
                        text: country.name,
                        textType: TextType.small,
                      ),
                      onTap: () {
                        locationStore.setSelectedCountry(country);
                        Modular.to.pop(true);
                      },
                    );
                  },
                  itemCount: locationStore.countries.length,
                ),
              ),
              const SizedBox(height: 2.5 * Space.big),
            ],
          );
        },
      ),
    );
  }
}
