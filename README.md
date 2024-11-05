# Santa Clara University - CSEN268 Fall 2024


## Lecture 13 - Modifying Contacts on the Phone

In the previous lecture we accessed the contacts on the phone and listed them. Now we will try to modify them

### Changes to the cubit
We add two methods to our cubit such that we have a function call when
 we hit the **edit** button next to the contact and when we hit 
 the submit button after editing the said contact.
```dart
  void editContact(Contact contact) {
    emit(ContactEdit(saveCallback: saveContact, contact: contact));
  }

  void saveContact(Contact contact) async {
    await FlutterContacts.updateContact(contact);
    contacts = await FlutterContacts.getContacts(
        withProperties: true, withAccounts: true, withPhoto: true);
    emit(ContactsPermissionFullAccess(
        contacts: contacts!, editCallback: editContact));
  }
```
In the `editContact` method we simply emit a new state `ContactEdit()` such that we can trigger the `ContactEditView()` in the `ContactsPage()` widget:
```dart
class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactsCubit cubit = ContactsCubit();
    return BlocProvider(
      create: (context) => cubit..init(),
      child: BlocBuilder<ContactsCubit, ContactsState>(
        builder: (context, state) {
          switch (state) {
            ... 
            case ContactEdit _:
              return ContactEditView(
                  contact: state.contact, saveCallback: state.saveCallback);
          }}));}}
```
With this we complete the view and update functionality of contacts. Something to pay attention is to specify `withProperties`, `withAccounts` and `withPhoto` when getting contacts from Android because without these you cannot update the contact.
```dart
    contacts = await FlutterContacts.getContacts(
        withProperties: true, withAccounts: true, withPhoto: true);
```
![Contacts](/assets/images/SavingAndDisplayingContacts.gif)

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



