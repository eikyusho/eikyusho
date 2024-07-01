import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/src/search/presentation/cubits/cubits.dart';

class SearchAppBar extends MainAppBarChild {
  const SearchAppBar({super.key});

  @override
  double get height => AppDimens.inputHeight + (AppDimens.lg * 2);

  @override
  Widget build(BuildContext context) {
    final debouncer = Debouncer(milliseconds: 500);

    return Container(
      color: getBlurredBgColor(context),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.$2xl,
        vertical: AppDimens.lg,
      ),
      height: height,
      child: ValueListenableBuilder(
        valueListenable: context.read<SearchCubit>().globalMode,
        builder: (context, value, child) {
          return TextInput(
            hint: value
                ? context.translate.hint_search_globally
                : context.translate.hint_search_locally,
            value: context.read<SearchCubit>().query.value,
            prefixIcon: Assets.icons.magnifyingGlassBold,
            suffixIcon: Assets.icons.slidersHorizontalBold,
            isSuffixActive: true,
            onChanged: (value) {
              context.read<SearchCubit>().query.value = value;
              debouncer.run(() {
                context.read<SearchCubit>().search(value);
              });
            },
          );
        },
      ),
    );
  }
}
