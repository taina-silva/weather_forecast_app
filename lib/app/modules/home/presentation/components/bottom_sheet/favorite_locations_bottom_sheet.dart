import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/favorite_locations_store.dart';

class FavoriteLocations extends StatefulWidget {
  const FavoriteLocations({super.key});

  @override
  State<FavoriteLocations> createState() => _FavoriteLocationsState();
}

class _FavoriteLocationsState extends State<FavoriteLocations> {
  final favoriteLocationsStore = Modular.get<FavoriteLocationsStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return favoriteLocationsStore.getFavoriteLocationsState.when(
          initial: () => const SizedBox(),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (message) => Text(message),
          success: () {
            return ListView.builder(
              itemCount: favoriteLocationsStore.favoriteLocations.length,
              itemBuilder: (context, index) {
                final location = favoriteLocationsStore.favoriteLocations[index];
                return ListTile(
                  title: Text(location.city),
                  subtitle: Text(location.country),
                  trailing: IconButton(
                    onPressed: () {
                      favoriteLocationsStore.removeFavoriteLocation(location);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            );
          },
        );
      }
    );
  }
}
