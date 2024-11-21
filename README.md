# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 18 - Flutter Web, WebView and Ads
In this lecture we will explore Flutter Web, WebView and Ads

### Step 01 - Adding another Web App
As the owner of an App you would want to have an **admin** console where you can manage certain features of your app. You could build this functionality *inside* your client facing App accessible only to certain types of users, or you could build a separate app altogether **in the same codebase**.

#### Setting up an admin App in the same codebase
Create another `main.dart` file for the **admin App** called [main_admin.dart](/main_admin.dart).
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFunctions.instance.useFunctionsEmulator("localhost", 5001);
  runApp(MyAdminApp());
}

class MyAdminApp extends StatelessWidget {
  const MyAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Admin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GenericPage(title: "Welcome to Web - Admin App"),
    );
  }
}
```

#### Setting up launch.json to run the apps.
The default entry point to the app is [main.dart](/lib/main.dart) which doesn't need to be specified. Therefore, in the [launch.json](/.vscode/launch.json) file:
```json
        {
            "name": "CSEN268-F24",
            "request": "launch",
            "type": "dart",
            "flutterMode": "debug"
        },
```
is the same as:
```json
        {
            "name": "CSEN268-F24",
            "request": "launch",
            "type": "dart",
            "flutterMode": "debug",
            "program": "lib/main.dart"
        },
```

If we want to point to our admin app we need another entry in this file as:
```json
        {
            "name": "Admin CSEN268-F24",
            "request": "launch",
            "type": "dart",
            "flutterMode": "debug",
            "program": "lib/main_admin.dart"
        },
```
Where we changed the **name** and the **program** for the **debug** mode. Similar addition need to be done for **profile** and **release** modes.

#### New Hosting Site
Our default hosting site was `https://fir-messaging-8b691.web.app/`. We additionally created a new hosting site called: `https://fir-messaging-8b691-admin.web.app/`. When we call `firebase deploy --only hosting` it's ambiguous as to where the deployment will be done. Therefore we define `target`s by adding the following to our [.firebaserc](/.firebaserc):
```json
  "targets": {
    "fir-messaging-8b691": {
      "hosting": {
        "clientApp": [
          "fir-messaging-8b691"
        ],
        "adminApp": [
          "fir-messaging-8b691-admin"
        ]
      }
    }
  }
```
and in the [firebase.json](/firebase.json) file:
```json
 "hosting": [
    {
      "target": "clientApp",
      "public": "build/web",
      "appAssociation": "AUTO",
      "headers": [
        {
          "source": "**/*.@(jpg|jpeg|gif|png|eot|otf|ttf|ttc|woff|font.css)",
          "headers": [
            {
              "key": "Access-Control-Allow-Origin",
              "value": "*"
            }
          ]
        }
      ]
    },
    {
      "target": "adminApp",
      "public": "build/web_admin",
      "appAssociation": "AUTO",
      "headers": [
        {
          "source": "**/*.@(jpg|jpeg|gif|png|eot|otf|ttf|ttc|woff|font.css)",
          "headers": [
            {
              "key": "Access-Control-Allow-Origin",
              "value": "*"
            }
          ]
        }
      ]
    }
 ]
```
The last thing we need to do is when compiling the **admin App** we need to specify the output to `build/web_admin` and to specify the input as `lib/main_admin.dart`. Therefore the `build` command for the admin app is:
```zsh
flutter build web --release --output "build/web_admin"  --target "lib/main_admin.dart"
```

#### Deploying the Admin App
Now to deploy the **admin App** you would need to use the target in the following manner:
```zsh
firebase deploy --only hosting:adminApp
```
as `adminApp` is defined as the target. The resulting output will be:
```zsh
=== Deploying to 'fir-messaging-8b691'...

i  deploying hosting
i  hosting[fir-messaging-8b691-admin]: beginning deploy...
i  hosting[fir-messaging-8b691-admin]: found 33 files in build/web_admin
✔  hosting[fir-messaging-8b691-admin]: file upload complete
i  hosting[fir-messaging-8b691-admin]: finalizing version...
✔  hosting[fir-messaging-8b691-admin]: version finalized
i  hosting[fir-messaging-8b691-admin]: releasing new version...
✔  hosting[fir-messaging-8b691-admin]: release complete

✔  Deploy complete!

Project Console: https://console.firebase.google.com/project/fir-messaging-8b691/overview
Hosting URL: https://fir-messaging-8b691-admin.web.app
```
where on the top it's referring to the **project name** `fir-messaging-8b691` but in subsequent lines it's referring to the hosting site `fir-messaging-8b691-admin.web.app` or `fir-messaging-8b691-admin.firebaseapp.com`.

To deploy the **client App** you would use:
```zsh
firebase deploy --only hosting:clientApp
```
and you would get:
```zsh
=== Deploying to 'fir-messaging-8b691'...

i  deploying hosting
i  hosting[fir-messaging-8b691]: beginning deploy...
i  hosting[fir-messaging-8b691]: found 33 files in build/web
✔  hosting[fir-messaging-8b691]: file upload complete
i  hosting[fir-messaging-8b691]: finalizing version...
✔  hosting[fir-messaging-8b691]: version finalized
i  hosting[fir-messaging-8b691]: releasing new version...
✔  hosting[fir-messaging-8b691]: release complete

✔  Deploy complete!

Project Console: https://console.firebase.google.com/project/fir-messaging-8b691/overview
Hosting URL: https://fir-messaging-8b691.web.app
```








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



