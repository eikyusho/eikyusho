import 'package:flutter/cupertino.dart';

import 'package:auto_route/auto_route.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';

class BrowsePageAppBar extends MainAppBar {
  const BrowsePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MainAppBar(
      showLogo: true,
      showNotificationButton: true,
      actionIcon: Assets.icons.planetBold,
      actionButton: () {
        context.router.push(const ExtensionsRoute());
      },
    );
  }
}

@RoutePage()
class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
