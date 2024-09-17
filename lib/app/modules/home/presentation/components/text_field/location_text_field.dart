import 'package:flutter/material.dart';
import 'package:weather_forecast_app/app/core/components/text/custom_text.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';

class LocationTextField<T> extends StatefulWidget {
  final T? selectedLocation;
  final void Function() onClear;
  final Future<void> Function(String?) getLocations;
  final String Function(T) locationAsStr;
  final String labelText;
  final bool disabled;

  const LocationTextField({
    super.key,
    required this.selectedLocation,
    required this.onClear,
    required this.getLocations,
    required this.locationAsStr,
    required this.labelText,
    this.disabled = false,
  });

  @override
  State<LocationTextField<T>> createState() => _LocationTextFieldState<T>();
}

class _LocationTextFieldState<T> extends State<LocationTextField<T>> {
  final TextEditingController _controller = TextEditingController();

  @override
  initState() {
    super.initState();
    widget.getLocations(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: widget.labelText + (_controller.text.isNotEmpty ? ': ${_controller.text}' : ''),
          textType: TextType.small,
          color: AppColors.neutral0,
        ),
        TextFormField(
          controller: _controller,
          onChanged: (value) => widget.getLocations(value),
          style: const TextStyle(color: AppColors.neutral0),
          enabled: !widget.disabled,
          decoration: InputDecoration(
            hintText: 'Type to search',
            hintStyle: const TextStyle(color: AppColors.neutral200),
            border: InputBorder.none,
            suffixIcon: widget.disabled
                ? null
                : GestureDetector(
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
        ),
      ],
    );
  }
}
