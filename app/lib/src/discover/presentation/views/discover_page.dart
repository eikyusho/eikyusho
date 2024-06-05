import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:resources/resources.dart';

import '../../../../common/common.dart';
import '../widgets/widgets.dart';

class DiscoverPageAppBar extends MainAppBar {
  const DiscoverPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MainAppBar(
      showLogo: true,
      showNotificationButton: true,
      actionIcon: Assets.icons.puzzlePieceBold,
      actionButton: () {},
    );
  }
}

@RoutePage()
class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = context.screenPadding;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: padding.top + AppDimens.$2xl,
        bottom: padding.bottom + AppDimens.$2xl,
      ),
      child: Column(
        children: [
          const DiscoverSpotlight().px(AppDimens.defaultHorizontalPadding),
          const VSpace(AppDimens.$4xl),
          const DiscoverMostPopularListView(),
          const VSpace(AppDimens.$2xl),
          const DiscoverRecentlyUpdatedListView(),
        ],
      ),
    );
  }
}
