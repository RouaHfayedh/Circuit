import 'package:flutter/material.dart';

class TripsListe extends StatefulWidget {
  TripsListe({Key key}) : super(key: key);

  @override
  _TripsListeState createState() => _TripsListeState();
}

class _TripsListeState extends State<TripsListe> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Car",
                  icon: Icon(Icons.directions_car),
                ),
                Tab(
                  icon: Icon(Icons.directions_transit),
                  text: "Metro",
                ),
                Tab(
                  icon: Icon(Icons.directions_bus),
                  text: "Bus",
                ),
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
