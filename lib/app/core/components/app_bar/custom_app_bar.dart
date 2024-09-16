import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:tuple/tuple.dart';
import 'package:weather_forecast_app/app/core/components/text/custom_text.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';

class CustomAppBar extends StatefulWidget {
  final Either<Tuple2<String, VoidCallback>, Widget> title;
  final List<Widget>? trailing;
  final Widget? leading;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.trailing,
    this.leading,
    this.backgroundColor,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Layout.appBarSize,
      padding: const EdgeInsets.symmetric(horizontal: Space.medium),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppColors.mainBlue,
        boxShadow: [Layout.boxShadow(AppColors.mainBlue)],
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(Layout.borderRadiusMedium),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // _renderAppBarLeading(context),
          Expanded(
            child: widget.title.fold(
              (title) => GestureDetector(
                onTap: canPop() ? () => Modular.to.pop() : title.item2,
                child: CustomText(
                  text: title.item1,
                  textType: TextType.medium,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  fWeight: FWeight.bold,
                  color: AppColors.neutral0,
                ),
              ),
              (widget) => Container(
                alignment: Alignment.bottomLeft,
                child: widget,
              ),
            ),
          ),
          _renderAppBarTrailing(context),
        ],
      ),
    );
  }

  bool canPop() => Modular.to.canPop();

  Widget _renderAppBarLeading(BuildContext context) {
    if (widget.leading != null) {
      return Container(
        margin: const EdgeInsets.only(right: Layout.appBarLeadingAndTrailingWidth / 4),
        child: widget.leading!,
      );
    }

    if (!canPop()) return const SizedBox();

    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () => Modular.to.pop(),
        child: const Icon(
          Icons.keyboard_arrow_left,
          color: AppColors.neutral600,
          size: Layout.appBarLeadingAndTrailingWidth,
          semanticLabel: 'Voltar para a página anterior',
        ),
      ),
    );
  }

  Widget _renderAppBarTrailing(BuildContext context) {
    if (widget.trailing == null) return const SizedBox();

    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: widget.trailing!.length,
      itemBuilder: (BuildContext context, int index) {
        return widget.trailing![index];
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: Space.small);
      },
    );
  }
}
