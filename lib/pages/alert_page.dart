import 'package:flutter/material.dart';

enum PizzaType {
  pepperoni,
  fourSeasons,
  marinara,
  margarita,
}

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomSheet: BottomSheet(
      //     backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      //     enableDrag: false,
      //     showDragHandle: false,
      //     onClosing: () {},
      //     shape: ContinuousRectangleBorder(),
      //     builder: (context) {
      //       return Container(
      //           width: double.infinity,
      //           padding: EdgeInsets.all(20),
      //           child: Text("Persistent Bottom Sheet"));
      //     }),
      appBar: AppBar(
        title: Text("Dialog Page"),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: double.infinity),
          FilledButton(
            child: Text("Basic Dialog"),
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return Container(
                      child: Text("Hello"),
                    );
                  });
            },
          ),
          FilledButton(
            child: Text("Alert Dialog OK"),
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Alert Dialog"),
                      content: Text("This is an alert"
                          " dialog we are testing."),
                      actions: [
                        FilledButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            })
                      ],
                    );
                  });
            },
          ),
          FilledButton(
            child: Text("Alert Dialog OK-Cancel"),
            onPressed: () async {
              bool? result = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Alert Dialog"),
                      content: Text("Body text"),
                      actions: [
                        FilledButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            }),
                        OutlinedButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            })
                      ],
                    );
                  });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Received $result")));
            },
          ),
          FilledButton(
            child: Text("Simple Dialog"),
            onPressed: () async {
              PizzaType? type = await showDialog<PizzaType>(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                      title: Text("Title Simple Dialog"),
                      children: PizzaType.values.map((type) {
                        return SimpleDialogOption(
                          child: Text(type.name),
                          onPressed: () {
                            Navigator.of(context).pop(type);
                          },
                        );
                      }).toList());
                },
                barrierDismissible: false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Received ${type?.name}")));
            },
          ),
          FilledButton(
            child: Text("Full Screen Dialog"),
            onPressed: () async {
              await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return Dialog.fullscreen(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        child: Center(
                          child: FilledButton(
                            child: Text("Hello"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ));
                  });
            },
          ),
          FilledButton(
            child: Text("Scaffold.showModalBottomSheet"),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Text("Bottom sheet body"),
                    );
                  });
            },
          ),
          ShowBottomSheetButton(),
          FilledButton(
            child: Text("Scaffold.showBottomSheet (doesn't work)"),
            onPressed: () {
              Scaffold.of(context).showBottomSheet((context) {
                return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Text("Persistent Bottom Sheet"));
              });
            },
          ),
        ],
      )),
    );
  }
}

class ShowBottomSheetButton extends StatelessWidget {
  const ShowBottomSheetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      child: Text("Scaffold.showBottomSheet (works)"),
      onPressed: () {
        Scaffold.of(context).showBottomSheet((context) {
          return Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text("Persistent Bottom Sheet"),
                  FilledButton(
                    child: Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
        });
      },
    );
  }
}
