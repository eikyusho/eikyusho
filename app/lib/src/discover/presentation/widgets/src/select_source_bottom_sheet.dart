import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/common/common.dart';
import 'package:app/src/browse/data/data.dart';
import 'package:app/src/discover/presentation/cubits/cubits.dart';

class SelectSourceBottomSheet extends StatelessWidget {
  const SelectSourceBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      children: [
        SizedBox(
          height: 200,
          child: BlocBuilder<DiscoverCubit, DiscoverState>(
            builder: (context, state) {
              return switch (state) {
                DiscoverLoading() => const Loading(),
                DiscoverError() => buildListView(state.sources!, null),
                DiscoverEmpty() => const SizedBox(),
                DiscoverUninitialized() => buildListView(state.sources, null),
                DiscoverLoaded() => buildListView(
                    state.sources,
                    state.selected.uuid,
                  ),
              };
            },
          ),
        ),
      ],
    );
  }

  Widget buildListView(List<AvailableExtension> sources, String? selected) {
    return ListView.separated(
      itemCount: sources.length,
      separatorBuilder: (_, __) => const VSpace(AppDimens.md),
      itemBuilder: (context, index) {
        final source = sources[index];
        final selectedSource = sources.where(
          (s) => s.uuid == selected,
        );

        return ClickableElement(
          onTap: () async {
            if (await context.read<DiscoverCubit>().selectSource(source)) {
              if (context.mounted) Navigator.of(context).pop();
            }
          },
          child: SourceOption(
            source: source,
            selectedSource: selectedSource.firstOrNull,
          ),
        );
      },
    );
  }
}

@protected
class SourceOption extends StatelessWidget {
  const SourceOption({
    required this.source,
    required this.selectedSource,
    super.key,
  });

  final AvailableExtension source;
  final AvailableExtension? selectedSource;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.buttonLg,
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.sm,
        horizontal: AppDimens.md,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
      ),
      child: Row(
        children: [
          ExtensionIcon(extension: source, imageSize: 32),
          const HSpace(AppDimens.md),
          Text(source.name).textStyle(
            context.textTheme.bodyLg.medium,
            color: context.colors.textPrimary,
          ),
          const Spacer(),
          SizedBox(
            width: AppDimens.buttonXs,
            height: AppDimens.buttonXs,
            child: Radio(
              value: source,
              groupValue: selectedSource,
              onChanged: (_) {},
              activeColor: context.colors.primary,
              splashRadius: 0,
            ),
          ),
        ],
      ),
    );
  }
}
