# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 17 - Testing
In this lecture we will explore testing of widgets and the app in general

### Step 06 - Integration Testing
For integration testing we create a directory called [integration_test](/integration_test). In this, we create a file called [app_test.dart](/integration_test/app_test.dart).
```dart
void main() {
  group('Testing MyApp', () {
    testWidgets('Button Test', (tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.text('Testing Start'), findsOne);
    });
  });
}

```
Integration tests are run on real device or simulator. With the command
```zsh
$ flutter test integration_test/app_test.dart
```
Note that this requires a current device target to run the test on. The test is run in a simulator or actual device.

### Testing Firestore
We create a new page [FirestoreTestPage](/lib/pages/firestore_test_page.dart). It has a data addition and data retrieval button.
```dart
        body: Center(
          child: Column(
            children: [
              FilledButton(
                child: Text("Add Data"),
                onPressed: () async {
                  ref = await FirebaseFirestore.instance
                      .collection("test_firestore")
                      .add({'firstName': 'John'});
                  data_added = true;
                  setState(() {});
                },
              ),
              Text("Data Added: $data_added"),
              FilledButton(
                child: Text("Retrieve Data"),
                onPressed: () async {
                  final DocumentSnapshot ds = await ref!.get();
                  first_name =
                      (ds.data()! as Map<String, dynamic>)['firstName'];
                  data_retrieved = true;
                  setState(() {});
                },
              ),
              Text("Data Retrieved: $data_retrieved"),
              Text("First Name: $first_name"),
            ],
          ),
        )
```
Our test at this stage contains only checking the page and the buttons rendering correctly:
```dart
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle(Duration(milliseconds: 3000));
      // expect(find.text('Testing Start'), findsOne);
      expect(find.text('Firestore Test'), findsOne);
      expect(find.widgetWithText(FilledButton, "Add Data"), findsOne);
      expect(find.widgetWithText(FilledButton, "Retrieve Data"), findsOne);
```
The `pumpAndSettle` waits for the UI to finish any animations and waits another 3000 milliseconds. We can see that the tests pass.

### Testing addition of data
We now test the interaction with Firebase and add the following tests in our [app_test.dart](/integration_test/app_test.dart):
```dart
      await tester.tap(find.widgetWithText(FilledButton, "Add Data"));
      await tester.pumpAndSettle(Duration(milliseconds: 3000));
      expect(find.text("Data Added: true"), findsOne);
      await tester.tap(find.widgetWithText(FilledButton, "Retrieve Data"));
      await tester.pumpAndSettle(Duration(milliseconds: 3000));
      expect(find.text("Data Retrieved: true"), findsOne);
      expect(find.text("First Name: John"), findsOne);
```
When we run the test we receive an error:
```zsh
The following FirebaseException was thrown running a test:
[core/no-app] No Firebase App '[DEFAULT]' has been created - call Firebase.initializeApp()
```
This is because we normally initialize Firebase in `main()` before calling calling `runApp`. To do this we modify the `main()` in the [app_test](/integration_test/app_test.dart) with the following:
```dart
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
```
Now, when we run the test we see that it passes both tests.


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



