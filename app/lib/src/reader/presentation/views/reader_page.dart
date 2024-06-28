import 'package:flutter/material.dart';

import 'package:core/core.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';
import 'package:app/injector/injector.dart';
import 'package:app/src/reader/data/data.dart';
import 'package:app/src/reader/presentation/views/fake.dart';

@RoutePage()
class ChapterPage extends StatelessWidget {
  const ChapterPage({super.key});
class ReaderPage extends StatelessWidget implements AutoRouteWrapper {
  const ReaderPage({required this.chapter, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        title: Text('Novel Title'),
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimens.$2xl,
          horizontal: AppDimens.defaultHorizontalPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '341',
                    style: TextStyle(color: context.colors.textSecondary),
                  ),
                  const HSpace(AppDimens.sm),
                  const Text(
                    'Chapter Title',
                  ),
                ],
              ).textStyle(
                context.textTheme.titleSm.regular,
                color: context.colors.textSubdued,
              ),
              const VSpace(AppDimens.$2xl),
              const Text(fakeChapterView).textStyle(
                context.textTheme.bodySm.regular,
                color: context.colors.textPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String repeat(String text, int count) {
  return List.generate(count, (_) => text).join(' ');
}
