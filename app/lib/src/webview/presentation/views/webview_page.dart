import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:app/config/app.dart';
import 'package:app/src/webview/presentation/widgets/widgets.dart';

@RoutePage()
class WebViewPage extends StatefulWidget {
  const WebViewPage({required this.url, super.key});

  final String url;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  InAppWebViewController? _webViewController;
  final webViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final padding = context.screenPaddingWithAppBar;

    final progress = ValueNotifier<double>(0);
    final title = ValueNotifier<String>('');

    return Scaffold(
      appBar: WebViewAppBar(
        title: title,
        onRefresh: reload,
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.only(
          top: padding.top,
        ),
        child: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(url: WebUri(widget.url)),
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              onLoadStart: (controller, url) {},
              onProgressChanged: (controller, value) {
                progress.value = value / 100;
              },
              onLoadStop: (controller, url) async {
                progress.value = 0;
                title.value = await controller.getTitle() ?? '';
              },
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ValueListenableBuilder(
                valueListenable: progress,
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      context.colors.primaryVariant,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: WebViewControls(
        onBack: back,
        onForward: forward,
      ),
    );
  }

  Future<void> reload() async {
    await _webViewController?.reload();
  }

  Future<void> back() async {
    if (await _webViewController?.canGoBack() ?? false) {
      await _webViewController?.goBack();
    }
  }

  Future<void> forward() async {
    if (await _webViewController?.canGoForward() ?? false) {
      await _webViewController?.goForward();
    }
  }

  @override
  void dispose() {
    _webViewController?.dispose();
    super.dispose();
  }
}
