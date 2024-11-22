import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController controller;
  late WebViewController webViewController;
  Uri? uri;

  @override
  void initState() {
    controller = TextEditingController(text: "google.com");
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
          NavigationDelegate(onNavigationRequest: (request) {
        if (request.url.contains("youtube")) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("This destination is not allowed")));
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      }));
    super.initState();
  }

  void processForm() {
    if (controller.text == null) {
      return;
    }
    if (controller.text.startsWith("https://") ||
        controller.text.startsWith("http://")) {
      uri = Uri.tryParse(controller.text);
    } else {
      uri = Uri.tryParse("https://${controller.text}");
    }
    if (uri != null) {
      webViewController.loadRequest(uri!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Web View"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                      labelText: "Address",
                      suffix: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          processForm();
                        },
                      )),
                ),
              ),
            ),
            Expanded(
              child: WebViewWidget(
                controller: webViewController,
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
