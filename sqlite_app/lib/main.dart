import 'package:sqlite_app/views/guest.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/guest.controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<GuestController>.value(
            value: GuestController(),
          ),
        ],
        child: MaterialApp(
          title: 'Guests List',
          debugShowCheckedModeBanner: false,
          home: GuestListView(),
        ));
  }
}
