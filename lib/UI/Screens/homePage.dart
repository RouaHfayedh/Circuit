import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
// import 'package:mapbox_geocoding/mapbox_geocoding.dart';
// import 'package:mapbox_geocoding/model/forward_geocoding.dart';
import 'package:transporitn/Models/station.dart';
import 'package:transporitn/Services/service.dart';
import 'package:transporitn/UI/Screens/offerScreen.dart';
import 'package:transporitn/UI/Screens/tripsListe.dart';
import 'package:transporitn/UI/Widgets/dateTimePicker.dart';
import 'package:transporitn/UI/Widgets/formOptions.dart';
import 'package:transporitn/UI/Widgets/mapView.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'package:http/http.dart' as http;

import 'gharbiMokrez.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, String title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const kApiKey =
      'pk.eyJ1IjoiN2FtbWEiLCJhIjoiY2tuMGw1MTU4MHAxbjJ0bGVqZm85bGo2NSJ9.VChadkXvg2NY4fDi-ZCWQg';
  bool _pinned = false;
  bool _snap = false;
  bool _floating = false;
  final formOptions = FormOptions();
  final _formKey = GlobalKey<FormState>();
  //int _index = 0;
  final dateTimePickerDepart = BasicDateTimeField(
    labelText: "Date et Heure de Départ",
    hintText: "y",
  );
  final dateTimePickerArrivee = BasicDateTimeField(
    labelText: "Date et Heure d'Arrivée",
    hintText: "yyyy-mm-dd hh-mm",
  );

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    String depart = "1600 Amphiteatre Parkway, Mountain View";
    String arrivee = "1600 Amphiteatre Parkway, Mountain View";

    List<Station> offres;
    var service = new Service();

    var lat1 = 36.4512893;
    var lan1 = 10.7356634;
    var departLatLong;
    var arriveeLatLong;
    var test;
    var test2;

    // MapboxGeocoding geocoding = MapboxGeocoding(
    //     'pk.eyJ1IjoiN2FtbWEiLCJhIjoiY2tuMGtuMGdnMG9rMDJ2cGs4cHk3dWcyaCJ9.50tM7MVJiv3Xs1wimpjnwA');
    // getCoordinates(String city) async {
    //   try {
    //     ForwardGeocoding forwardModel = await geocoding.forwardModel(city);
    //     return forwardModel.features[0].center;
    //   } catch (Excepetion) {
    //     return 'Forward Geocoding Error';
    //   }
    // }

    Future getPlace(dynamic query) async {
      //final query = "1600 Amphiteatre Parkway, Mountain View";
      var addresses = await Geocoder.local.findAddressesFromQuery(query);
      var first = addresses.first;
      // setState(() {
      //   lat1 = first.coordinates.latitude;
      // });

      // lan1 = first.coordinates.longitude;
      // print("${first.featureName} : ${first.coordinates}");

      return first.coordinates;
    }

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: _pinned,
          snap: _snap,
          floating: _floating,
          expandedHeight: 115.0,
          backgroundColor: Colors.lightBlue[200],
          flexibleSpace: FlexibleSpaceBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 120,
                      child: Column(
                        children: [
                          Text(
                            'Où désirez-vous voyager ? ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            centerTitle: true,
            background: Image.asset("assets/travel2.jpg"),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            color: Colors.lightBlue[200],
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0),
                    ),
                  ),
                  child: formOptions,
                )
              ],
            ),
          ),
        ),
        SliverFixedExtentList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: EdgeInsets.only(top: 0.0, right: 10.0, left: 10.0),
              child: Container(
                //color: Colors.grey,
                //height: 300,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    //controller: controller,
                    child: Column(
                      children: <Widget>[
                        SafeArea(
                          bottom: false,
                          child: MapBoxPlaceSearchWidget(
                            popOnSelect: true,
                            apiKey: kApiKey,
                            searchHint: 'Place de Départ',
                            onSelected: (place) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GharbiMokrez(),
                                ),
                              );
                              depart = place.toString();
                              print(place.toString());
                            },
                            context: context,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SafeArea(
                          bottom: false,
                          top: false,
                          child: MapBoxPlaceSearchWidget(
                            popOnSelect: true,
                            apiKey: kApiKey,
                            searchHint: 'Place d\'arrivée',
                            onSelected: (place) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GharbiMokrez(),
                                ),
                              );
                              arrivee = place.toString();
                              print(place);
                            },
                            context: context,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        BasicDateTimeField(
                          hintText: 'Date et Heure de Départ ',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 15.0),
                          child: ButtonTheme(
                            minWidth: 600.0,
                            height: 75.0,
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              textColor: Colors.white,
                              color: Colors.red[400],
                              onPressed: () async {
                                //service.getOffre();
                                test = await getPlace(depart);

                                test2 = await getPlace(arrivee);

                                print(test.latitude);
                                print(test2.longitude);
                                //getPlace(arrivee);
                                //print("lat1= $lat1 \n lan1= $lan1");
                                //print(service.fetchOffre(http.Client));
                                // Respond to button press
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MapView(
                                              lat1: test.latitude,
                                              lan1: test.longitude,
                                              lat2: test2.latitude,
                                              lan2: test2.longitude,
                                            )));
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 16.0,
                                      right: 16.0,
                                      top: 12,
                                      bottom: 12),
                                  child: Text("Recherche",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25.0))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10.0),
                                child: Text(
                                  "Comment cela fonctionne-t-il ? ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17.0),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Image.asset("assets/stepper2.jpg"),
                        ])
                        // TextFormField(
                        //   //keyboardType: TextInputType.numberWithOptions(),
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(),
                        //     labelText: "Destination d'Arrivée ",
                        //     hintText: "Vers: Ville, Gare ou Aéroport",
                        //     prefixIcon: Icon(Icons.place),
                        //   ),
                        //   // ignore: missing_return
                        //   validator: (value) {},
                        // ),
                        // SizedBox(
                        //   height: 10.0,
                        // ),
                        // dateTimePickerDepart,
                        // SizedBox(
                        //   height: 10.0,
                        // ),
                        ///////dateTimePickerArrivee,
                        // SizedBox(
                        //   height: 10.0,
                        // ),
                        // ButtonTheme(
                        //   minWidth: 600.0,
                        //   height: 55.0,
                        //   // ignore: deprecated_member_use
                        //   child: RaisedButton(
                        //     textColor: Colors.white,
                        //     color: Colors.red[400],
                        //     onPressed: () {
                        //       // Respond to button press
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => MapView()),
                        //       );
                        //     },
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(4.0),
                        //     ),
                        //     child: Padding(
                        //         padding: EdgeInsets.only(
                        //             left: 16.0, right: 16.0, top: 12, bottom: 12),
                        //         child: Text("Recherche",
                        //             style: TextStyle(
                        //                 fontWeight: FontWeight.w600,
                        //                 fontSize: 16.0))),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10.0,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
          itemExtent: screenHeight,
        )
        //     SliverGrid.count(
        //       crossAxisCount: 1,
        //       children: [
        //         Padding(
        //           padding: EdgeInsets.only(top: 15.0, right: 10.0, left: 10.0),
        //           child: Container(
        //             //color: Colors.grey,
        //             //height: 300,
        //             child: Form(
        //               key: _formKey,
        //               child: Column(
        //                 children: <Widget>[
        //                   // TextFormField(
        //                   //   //keyboardType: TextInputType.numberWithOptions(),
        //                   //   decoration: InputDecoration(
        //                   //       border: OutlineInputBorder(),
        //                   //       labelText: "Place de Départ",
        //                   //       hintText: "De: Ville, Gare ou Aéroport",
        //                   //       //fillColor: Colors.black,
        //                   //       prefixIcon: Icon(Icons.album_rounded)),
        //                   //   // ignore: missing_return
        //                   //   validator: (value) {},
        //                   // ),
        //                   // SizedBox(
        //                   //   height: 10.0,
        //                   // ),
        //                   SafeArea(
        //                     bottom: false,
        //                     child: MapBoxPlaceSearchWidget(
        //                       popOnSelect: true,
        //                       apiKey: kApiKey,
        //                       searchHint: 'Search around',
        //                       onSelected: (place) {
        //                         Navigator.push(
        //                           context,
        //                           MaterialPageRoute(
        //                             builder: (context) => GharbiMokrez(),
        //                           ),
        //                         );
        //                         print(place);
        //                       },
        //                       context: context,
        //                     ),
        //                   ),
        //                   // SizedBox(
        //                   //   height: 10.0,
        //                   // ),
        //                   // TextFormField(
        //                   //   //keyboardType: TextInputType.numberWithOptions(),
        //                   //   decoration: InputDecoration(
        //                   //     border: OutlineInputBorder(),
        //                   //     labelText: "Destination d'Arrivée ",
        //                   //     hintText: "Vers: Ville, Gare ou Aéroport",
        //                   //     prefixIcon: Icon(Icons.place),
        //                   //   ),
        //                   //   // ignore: missing_return
        //                   //   validator: (value) {},
        //                   // ),
        //                   // SizedBox(
        //                   //   height: 10.0,
        //                   // ),
        //                   // dateTimePickerDepart,
        //                   // SizedBox(
        //                   //   height: 10.0,
        //                   // ),
        //                   dateTimePickerArrivee,
        //                   // SizedBox(
        //                   //   height: 10.0,
        //                   // ),
        //                   ButtonTheme(
        //                     minWidth: 600.0,
        //                     height: 55.0,
        //                     // ignore: deprecated_member_use
        //                     child: RaisedButton(
        //                       textColor: Colors.white,
        //                       color: Colors.red[400],
        //                       onPressed: () {
        //                         // Respond to button press
        //                         Navigator.push(
        //                           context,
        //                           MaterialPageRoute(
        //                               builder: (context) => MapView()),
        //                         );
        //                       },
        //                       shape: RoundedRectangleBorder(
        //                         borderRadius: BorderRadius.circular(4.0),
        //                       ),
        //                       child: Padding(
        //                           padding: EdgeInsets.only(
        //                               left: 16.0,
        //                               right: 16.0,
        //                               top: 12,
        //                               bottom: 12),
        //                           child: Text("Recherche",
        //                               style: TextStyle(
        //                                   fontWeight: FontWeight.w600,
        //                                   fontSize: 16.0))),
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: 10.0,
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //         //Image.asset("assets/stepper.jpg"),
        //         // Image.asset("assets/stepper.jpg"),
        //         Column(children: [
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.only(left: 10.0, top: 10.0),
        //                 child: Text(
        //                   "Comment cela fonctionne-t-il ? ",
        //                   style: TextStyle(
        //                       fontWeight: FontWeight.w600, fontSize: 17.0),
        //                 ),
        //               ),
        //             ],
        //           ),
        //           Image.asset("assets/stepper2.jpg"),
        //         ])
        //         //     Stepper(
        //         //       steps: [
        //         //         Step(
        //         //           title: Text("Step 1 title"),
        //         //           content: Container(
        //         //               alignment: Alignment.centerLeft,
        //         //               child: Text("Content for Step 1")),
        //         //         ),
        //         //         Step(
        //         //           title: Text("Step 2 title"),
        //         //           content: Text("Content for Step 2"),
        //         //         ),
        //         //         Step(
        //         //           title: Text("Step 1 title"),
        //         //           content: Container(
        //         //               alignment: Alignment.centerLeft,
        //         //               child: Text("Content for Step 1")),
        //         //         ),
        //         //         Step(
        //         //           title: Text("Step 2 title"),
        //         //           content: Text("Content for Step 2"),
        //         //         ),
        //         //       ],
        //         //     )
        //         //   ],
        //         // ),
        //       ],
        //     ),
        //     // SliverList(
        //     //   delegate: SliverChildBuilderDelegate(
        //     //     (BuildContext context, int index) {
        //     //       return Container(
        //     //         color: !index.isOdd ? Colors.white : Colors.black12,
        //     //         height: 100.0,
        //     //         child: Center(
        //     //           child: Text('$index', textScaleFactor: 5),
        //     //         ),
        //     //       );
        //     //     },
        //     //     childCount: 20,
        //     //   ),

        //     // )
        //   ],
        // ),

        // material icon named "album".

        // bottomNavigationBar: BottomAppBar(
        //   child: ButtonBar(
        //     alignment: MainAxisAlignment.spaceEvenly,
        //     children: <Widget>[
        //       Row(
        //         children: <Widget>[
        //           const Text('pinned'),
        //           Switch(
        //             onChanged: (bool val) {
        //               setState(() {
        //                 _pinned = val;
        //               });
        //             },
        //             value: _pinned,
        //           ),
        //         ],
        //       ),
        //       Row(
        //         children: <Widget>[
        //           const Text('snap'),
        //           Switch(
        //             onChanged: (bool val) {
        //               setState(() {
        //                 _snap = val;
        //                 // Snapping only applies when the app bar is floating.
        //                 _floating = _floating || _snap;
        //               });
        //             },
        //             value: _snap,
        //           ),
        //         ],
        //       ),
        //       Row(
        //         children: <Widget>[
        //           const Text('floating'),
        //           Switch(
        //             onChanged: (bool val) {
        //               setState(() {
        //                 _floating = val;
        //                 _snap = _snap && _floating;
        //               });
        //             },
        //             value: _floating,
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ],
    ));
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const kApiKey =
        'pk.eyJ1IjoiN2FtbWEiLCJhIjoiY2tuMGw1MTU4MHAxbjJ0bGVqZm85bGo2NSJ9.VChadkXvg2NY4fDi-ZCWQg';
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        bottom: false,
        top: false,
        left: false,
        right: false,
        child: MapBoxPlaceSearchWidget(
          popOnSelect: true,
          apiKey: kApiKey,
          searchHint: 'Search around',
          onSelected: (place) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GharbiMokrez(),
              ),
            );
            print(place);
          },
          context: context,
        ),
      ),
    );
  }
}

// TextFormField(
//   //keyboardType: TextInputType.numberWithOptions(),
//   decoration: InputDecoration(
//       border: OutlineInputBorder(),
//       labelText: "Place de Départ",
//       hintText: "De: Ville, Gare ou Aéroport",
//       //fillColor: Colors.black,
//       prefixIcon: Icon(Icons.album_rounded)),
//   // ignore: missing_return
//   validator: (value) {},
// ),
// SizedBox(
//   height: 10.0,
// ),
