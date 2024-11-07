import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StreamBuilderPage extends StatelessWidget {
  const StreamBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Stream Builder Demo")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Cities (Stream)",
                    style: Theme.of(context).textTheme.headlineMedium),
                Text("Demonstrate the stream feature where adding a new "
                    "city to the database will"
                    " result in updated stream which will update the list."),
                SizedBox(height: 20),
                CityEntry(),
                SizedBox(height: 20),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        shrinkWrap: true,
                        children: snapshot.data?.docs.map((doc) {
                              return Text(doc.data()['name']);
                            }).toList() ??
                            [],
                      );
                    }
                    return CircularProgressIndicator();
                  },
                  stream: FirebaseFirestore.instance
                      .collection('cities')
                      .snapshots(),
                ),
              ],
            ),
          ),
        ));
  }
}

class CityEntry extends StatefulWidget {
  const CityEntry({super.key});

  @override
  State<CityEntry> createState() => _CityEntryState();
}

class _CityEntryState extends State<CityEntry> {
  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Row(children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(labelText: "City"),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter a string";
                }
                return null;
              },
              onSaved: (value) {
                FirebaseFirestore.instance
                    .collection('cities')
                    .add({'name': value});
              },
            ),
          ),
          SizedBox(width: 10),
          OutlinedButton(
              child: Text("Add"),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  controller.clear();
                }
              }),
        ]));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}
