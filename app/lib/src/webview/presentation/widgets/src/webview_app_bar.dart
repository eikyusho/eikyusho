import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';

class WebViewAppBar extends StatefulWidget implements PreferredSizeWidget {
  const WebViewAppBar({
    required this.title,
    required this.onRefresh,
    super.key,
  });

  final ValueNotifier<String> title;
  final VoidCallback onRefresh;

  @override
  State<WebViewAppBar> createState() => _WebViewAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(AppDimens.appBarHeight);
}

class _WebViewAppBarState extends State<WebViewAppBar> {
  String title = '';

  @override
  Widget build(BuildContext context) {
    widget.title.addListener(() {
      AppLogger.debug('title: ${widget.title.value}');
      setState(() {
        title = widget.title.value;
      });
    });

    return MainAppBar(
      actionButton: widget.onRefresh,
      title: Text(title),
      actionIcon: Assets.icons.arrowClockwiseBold,
      showBackButton: true,
    );
  }
}
