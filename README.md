# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 18 - Flutter Web, WebView and Ads
In this lecture we will explore Flutter Web, WebView and Ads

### Step 03 - Webview
There are two packages that allow you to connect to Web from inside the Flutter App. We import both packages:
```zsh
flutter pub add webview_flutter flutter_inappwebview
```

#### InAppWebView
Here the syntax of the WebView is slightly different. We create a new page called [in_app_web_view_page.dart](/lib/pages/in_app_web_view_page.dart):
```dart
class _InAppWebViewPageState extends State<InAppWebViewPage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController controller;
  late InAppWebViewController webViewController;
  Uri? uri;

  @override
  void initState() {
    controller = TextEditingController(text: "google.com");
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
    if (webViewController != null && uri != null) {
      webViewController.loadUrl(
          urlRequest: URLRequest(url: WebUri(uri.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("In App Web View"),
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
              child: InAppWebView(
                onWebViewCreated: (controller) async {
                  webViewController = controller;
                },
              ),
            ),
          ],
        ));
  }
}
```
Here the controller is created together with the WebView and a handle is passed on. You don't need to `dispose()` this `InAppWebViewController` as it self disposes when the WebViewWidget is disposed.


### Setting up your environment before the lecture

Each lecture is stored under a separate tag. On your computer do the following

    git clone <Repository Name>
    git pull
    git tag -l

This will list all the tags in the repository such as

    Lecture4
    Lecture5
    Lecture6
    ...

In order to pull a particular tag to your computer

    git checkout tags/Lecture5_start -b Lecture5_study

### Cloning to Google IDX

1. Go to this link. [idx.dev](https://idx.google.com/import?url=https://github.com/mehmetartun/CSEN268-F24)
2. Name your project (default value is fine)
3. Click the Flutter Project checkbox
4. Wait for the setup to continue
5. Open the terminal and pull the requisite tag from the repo by
```zsh
git pull
git tag -l
git tags/<TagName> -b <NewLocalBranchName>
```



