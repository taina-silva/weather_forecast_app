import 'package:flutter/material.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';

class LocationTextField<T> extends StatefulWidget {
  final T? selectedLocation;
  final void Function() onClear;
  final Future<List<T>> Function(String?) getLocations;
  final String Function(T) locationAsStr;
  final String labelText;

  const LocationTextField({
    super.key,
    required this.selectedLocation,
    required this.onClear,
    required this.getLocations,
    required this.locationAsStr,
    required this.labelText,
  });

  @override
  State<LocationTextField<T>> createState() => _LocationTextFieldState<T>();
}

class _LocationTextFieldState<T> extends State<LocationTextField<T>> {
  final TextEditingController _controller = TextEditingController();

  @override
  initState() {
    super.initState();

    if (widget.selectedLocation != null) {
      final location = widget.locationAsStr(widget.selectedLocation as T);
      widget.getLocations(location);
      _controller.text = location;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onChanged: (value) => widget.getLocations(value),
      style: const TextStyle(color: AppColors.neutral0),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: AppColors.neutral0),
        hintText: 'Type to search',
        hintStyle: const TextStyle(color: AppColors.neutral200),
        border: InputBorder.none,
        suffixIcon: GestureDetector(
          onTap: () {
            _controller.clear();
            widget.onClear();
            widget.getLocations(null);
          },
          child: const Icon(
            Icons.clear,
            color: AppColors.neutral0,
          ),
        ),
      ),
    );
  }
}
