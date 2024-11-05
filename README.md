# Santa Clara University - CSEN268 Fall 2024


## Lecture 13 - Accessing Contacts on the Phone

We start with the `GenericPage` as home page.

### Addding dependencies and permissions

We import the package `flutter_contacts`
```zsh
flutter pub add flutter_contacts
```
For Android we add the following to the [AndroidManifest.xml](/android/app/src/main/AndroidManifest.xml) file:
```xml
<uses-permission android:name="android.permission.READ_CONTACTS"/>
<uses-permission android:name="android.permission.WRITE_CONTACTS"/>
```
and for iOS we have to give a reason for accessing the contacts in the [Info.plist](/ios/Runner/Info.plist) file:
```xml
<key>NSContactsUsageDescription</key>
<string>To faciliatate sharing with your contacts, we require access to contacts on your device.</string>
```

### Creating a Page

We create a Contacts Page [contacts_page.dart](/lib/pages/contacts_page.dart) and wrap it with a `ContactsCubit`. This allows us to do a few things:
1. In the `init()` call we request permission and get the permission status (in file [contacts_cubit.dart](/lib/pages/contacts/cubit/contacts_cubit.dart)). If permitted, we retrieve the contacts.
```dart
  void init() async {
    if (await FlutterContacts.requestPermission()) {
      permissionType = PermissionType.full;
      contacts = await FlutterContacts.getContacts();
      emit(ContactsPermissionFullAccess(contacts: contacts!));
      return;
    } else {
      permissionType = PermissionType.none;
      if (Platform.isAndroid) {
        if (await FlutterContacts.requestPermission(readonly: true)) {
          permissionType = PermissionType.readOnly;
          contacts = await FlutterContacts.getContacts();

          emit(ContactsPermissionReadOnly(contacts: contacts!));
          return;
        }
      } else {}
    }
    emit(ContactsPermissionDenied());
  }
```
2. With the state emitted (either with full access permission or with read-only permission) we display the contact list by directing the `switch` to `ContactsView`.
```dart
class ContactsView extends StatelessWidget {
  final List<Contact> contacts;
  final bool readOnly;
  const ContactsView({
    super.key,
    required this.contacts,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: Column(
        children: [
          Text("Here are the contacts"),
          Expanded(
            child: ListView(
              children: contacts.map((contact) {
                return ListTile(title: Text(contact.displayName));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
```
Here we must note that the `ListView` will try to take an infinite length and try to push Column. With the `Expanded` widget wrapped around it (it only works inside `Row`, `Column` and `Flex`)  the `ListView` will only try to take as much space as the `Column`'s perent allows it!
3. Finally the list of the contacts are displayed as:
![Contact List](/assets/images/ContactListView.png)




### Handling permissions
The contacts permission needs to be granted by the device. To do this

### Setting up your environment before the lecture

Each lecture is stored under a separate tag. In your computer do the following

    git clone <Repository Name>
    git pull
    git tag -l

This will list you all the tags in the repository such as

    Lecture4
    Lecture5
    Lecture6
    ...

In order to pull a particular tag to your computer

    git checkout tags/Lecture5_start -b Lecture5_study

### Cloning to Google IDX

1. Go to this link. [idx.dev](https://idx.google.com/import?url=https://github.com/mehmetartun/CSEN268-F24)
2. Name your project (default value is fine)
3. Click Flutter Project checkbox
4. Wait for the setup to continue
5. Open the terminal and pull requisite tag from the repo by
```zsh
git pull
git tag -l
git tags/<TagName> -b <NewLocalBranchName>
```



