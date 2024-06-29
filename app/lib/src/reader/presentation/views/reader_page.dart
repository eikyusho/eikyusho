import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';
import 'package:app/injector/injector.dart';
import 'package:app/src/reader/data/data.dart';
import 'package:app/src/reader/presentation/cubits/cubits.dart';

@RoutePage()
class ReaderPage extends StatefulWidget implements AutoRouteWrapper {
  const ReaderPage({required this.chapter, required this.chapters, super.key});

  final Chapter chapter;
  final List<Chapter> chapters;

  @override
  State<ReaderPage> createState() => _ReaderPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => ReaderCubit(
        getIt<NovelRepository>(),
      )..loadChapter(chapter),
      child: this,
    );
  }
}

class _ReaderPageState extends State<ReaderPage> {
  late PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.chapters.indexOf(widget.chapter);
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    final (chapters, chapter) = (widget.chapters, widget.chapter);

    return BlocBuilder<ReaderCubit, ReaderState>(
      builder: (context, state) {
        return Scaffold(
          appBar: MainAppBar(
            title: Text(chapter.novel.title),
            showBackButton: true,
            actionButton: () {},
          ),
          extendBodyBehindAppBar: true,
          body: PageView.builder(
            controller: _pageController,
            itemCount: chapters.length,
            onPageChanged: (index) {
              if (index != _currentPage) {
                setState(() => _currentPage = index);
                context.read<ReaderCubit>().loadChapter(chapters[index]);
              }
            },
            itemBuilder: (context, index) {
              return BlocBuilder<ReaderCubit, ReaderState>(
                builder: (context, state) {
                  final shouldLoad = state is ReaderLoaded &&
                      state.chapter == widget.chapters[index];

                  if (state is ReaderError) {
                    return buildErrorPage(state.error);
                  }

                  if (shouldLoad) {
                    return buildChapter(state.chapter, state.content);
                  }

                  return const Loading();
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget buildChapter(Chapter chapter, String content) {
    return Builder(
      builder: (context) {
        final padding = context.screenPadding;

        return SingleChildScrollView(
          padding: EdgeInsets.only(
            top: padding.top + AppDimens.$2xl,
            bottom: AppDimens.$2xl,
            left: AppDimens.defaultHorizontalPadding,
            right: AppDimens.defaultHorizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${chapter.number} ',
                      style: context.textTheme.titleSm.regular.copyWith(
                        color: context.colors.textSecondary,
                      ),
                    ),
                    TextSpan(
                      text: chapter.title,
                      style: context.textTheme.titleSm.medium.copyWith(
                        color: context.colors.textSubdued,
                      ),
                    ),
                  ],
                ),
              ),
              const VSpace(AppDimens.$2xl),
              Text(content).textStyle(
                context.textTheme.bodySm.regular,
                color: context.colors.textPrimary,
              ),
              const VSpace(AppDimens.$4xl),
              if (hasNextChapter())
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppIconButton(
                      Assets.icons.caretRightBold,
                      size: AppDimens.buttonLg,
                      iconSize: AppDimens.iconXl,
                      onPressed: () {
                        _pageController.nextPage(
                          duration: AppMisc.normalDuration,
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget buildErrorPage(Exception error) {
    return EmptyPage(
      image: Assets.images.wentWrong,
      message: AppStrings.emptyStateError,
      description: AppStrings.emptyStateDescriptionError,
      error: error,
    );
  }

  bool hasNextChapter() {
    return _currentPage < widget.chapters.length - 1;
  }
}
