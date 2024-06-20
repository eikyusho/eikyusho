import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/common/common.dart';
import 'package:app/src/browse/data/data.dart';
import 'package:app/src/discover/presentation/cubits/discover_cubit.dart';

class SelectSourceBottomSheet extends StatelessWidget {
  const SelectSourceBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      children: [
        SizedBox(
          height: 200,
          child: BlocBuilder<DiscoverCubit, DiscoverState>(
            bloc: context.read<DiscoverCubit>()..getSources(),
            builder: (context, state) {
              if (state is DiscoverLoading) return const Loading();

              if (state is DiscoverError) throw UnimplementedError();

              final sources = (state as DiscoverLoaded).sources;

              return ListView.separated(
                itemCount: sources.length,
                separatorBuilder: (_, __) => const VSpace(AppDimens.md),
                itemBuilder: (context, index) {
                  final source = sources[index];
                  final selected = sources.first;

                  return SourceOption(
                    source: source,
                    selectedSource: selected,
                  );
                },
              );
            },
          ),
        ),
      ],
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
  final AvailableExtension selectedSource;

  @override
  Widget build(BuildContext context) {
    final image = Uint8List(1);

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
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.sm),
            child: Image.memory(
              image,
              width: AppDimens.iconXl,
              height: AppDimens.iconXl,
              semanticLabel: '${source.name} icon',
              errorBuilder: (ctx, e, ee) {
                /// Delete
                return Container(
                  color: context.colors.primary,
                  width: 32,
                  height: 32,
                );
              },
            ),
          ),
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

class Source {
  Source(this.name);

  final String icon = '';
  final String name;
}
