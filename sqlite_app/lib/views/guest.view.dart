import 'package:flutter/rendering.dart';
import 'package:sqlite_app/controllers/guest.controller.dart';
import 'package:sqlite_app/models/guest.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../app_status.dart';

class GuestListView extends StatefulWidget {
  @override
  _GuestListViewState createState() => _GuestListViewState();
}

class _GuestListViewState extends State<GuestListView> {
  /* Variables */
  final _formKey = GlobalKey<FormState>();

  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _cellPhoneController = TextEditingController();

  String _dropdownValue;
  GuestController _controller;

  @override
  void initState() {
    _dropdownValue = "Awaiting response";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller = Provider.of<GuestController>(context);

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('My special Guest 👩‍💼👨‍💼'),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Scrollbar(
        child: Observer(builder: (_) {
          if (_controller.status == AppStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (_controller.status == AppStatus.success) {
            return ListView(
              children: [
                for (int i = 0; i < _controller.list.length; i++)
                  ListTile(
                    leading: const Icon(
                      Icons.face,
                      color: Colors.cyan,
                      size: 35,
                    ),
                    title: Text(
                      _controller.list[i].name,
                      style: TextStyle(color: Colors.blue[100], fontSize: 20),
                    ),
                    subtitle: Text(
                      _controller.list[i].email +
                          "                         " +
                          _controller.list[i].cellPhone +
                          "                                                      " +
                          _controller.list[i].status,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    isThreeLine: true,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Form(
                              child: Container(
                                height: 150,
                                child: DropdownButton(
                                  value: _dropdownValue,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _dropdownValue = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'Awaiting response',
                                    'Confirmed',
                                    'Refused'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: new Text('CANCEL'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: new Text('SAVE'),
                                onPressed: () {
                                  _controller.update(
                                    Guest(
                                        id: _controller.list[i].id,
                                        name: _controller.list[i].name,
                                        status: _dropdownValue,
                                        cellPhone:
                                            _controller.list[i].cellPhone,
                                        email: _controller.list[i].email),
                                  );

                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    trailing: IconButton(
                      icon: new Icon(Icons.delete),
                      color: Colors.red[300],
                      onPressed: () async {
                        await _controller.delete(_controller.list[i].id);
                      },
                    ),
                  )
              ],
            );
          } else {
            return Text(
              "Loading... ",
              style: TextStyle(
                color: Colors.white,
              ),
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _displayDialog(context),
      ),
    );
  }

  _displayDialog(context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Container(
                height: 200,
                child: Column(
                  children: <Widget>[
                    /* Name */
                    TextFormField(
                      controller: _nameController,
                      validator: (s) {
                        if (s.isEmpty)
                          return "Please inserte guest's name.";
                        else
                          return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "Name"),
                    ),

                    /* Email */
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Email"),
                    ),

                    /* CellPhone */
                    TextFormField(
                      controller: _cellPhoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "CellPhone"),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text('SAVE'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _controller.create(
                      Guest(
                          name: _nameController.text,
                          status: "Awaiting response",
                          cellPhone: _cellPhoneController.text,
                          email: _emailController.text),
                    );

                    _nameController.clear();
                    _emailController.clear();
                    _cellPhoneController.clear();

                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }
}
