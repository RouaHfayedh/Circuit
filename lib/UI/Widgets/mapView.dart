import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart' as latLng;
import 'package:transporitn/Models/station.dart';
import 'package:transporitn/Services/service.dart';
import 'package:timelines/timelines.dart';
import 'package:http/http.dart' as http;
import 'package:transporitn/UI/Widgets/infoCardWidget.dart';

class MapView extends StatefulWidget {
  //final List<Station> station;
  final lat1;
  final lan1;
  final lat2;
  final lan2;

  MapView({
    Key key,
    @required this.lat1,
    @required this.lan1,
    @required this.lat2,
    @required this.lan2,
  }) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  var title = "Details du voyage";
  var itineraire = <latLng.LatLng>[
    // new latLng.LatLng(35.22, -101.83),
    // new latLng.LatLng(32.77, -96.79),
    // new latLng.LatLng(29.76, -95.36),
    // new latLng.LatLng(29.42, -98.49),
    // new latLng.LatLng(35.22, -101.83),
  ];

  var markers = <Marker>[
    // Marker(
    //   width: 50.0,
    //   height: 50.0,
    //   point: latLng.LatLng(35.22, -101.83),
    //   builder: (ctx) => Container(
    //     child: Image.asset(
    //       "assets/marker.png",
    //       height: 20,
    //       width: 10,
    //     ),
    //   ),
    // ),
  ];

  Widget connectorTop(BuildContext context, content) {
    return TimelineTile(
      contents: Card(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Text('$content'),
        ),
      ),
      node: TimelineNode(
        indicator: DotIndicator(),
        //startConnector: SolidLineConnector(),
        endConnector: SolidLineConnector(),
      ),
    );
    //  SolidLineConnector(
    //   color: Colors.grey,
    // );
  }

  Widget connectorBottom(BuildContext context, content) {
    return Align(
      alignment: Alignment.topLeft,
      child: TimelineTile(
        contents: Card(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Text('$content'),
          ),
        ),
        node: TimelineNode(
          indicator: DotIndicator(),
          startConnector: SolidLineConnector(),
          //endConnector: SolidLineConnector(),
        ),
      ),
    );
    //  SolidLineConnector(
    //   color: Colors.grey,
    // );
  }

  Widget dot(BuildContext context, int index, ConnectorType type) {
    return SolidLineConnector(
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    var service = new Service();
    String depart = "de: ";
    String arrivee = "à: ";
    final lat1 = widget.lat1;
    final lat2 = widget.lat2;
    final lan1 = widget.lan1;
    final lan2 = widget.lan2;
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.grey[200],
      ),

      body: FutureBuilder<List<Station>>(
        future: service.fetchOffre(http.Client(), lat1, lan1, lat2,
            lan2), // fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data.length; i++) {
              print("yaaaaa rab  $i  " + snapshot.data[i].nameDep.toString());
              itineraire.add(new latLng.LatLng(
                  snapshot.data[i].lat, snapshot.data[i].lan));
              //print(snapshot.data[i].lat + snapshot.data[i].lan);
              markers.add(
                Marker(
                  width: 50.0,
                  height: 50.0,
                  point:
                      latLng.LatLng(snapshot.data[i].lat, snapshot.data[i].lan),
                  builder: (ctx) => Container(
                    child: Image.asset(
                      "assets/marker.png",
                      height: 20,
                      width: 10,
                    ),
                  ),
                ),
              );
            }

            depart = depart + snapshot.data[0].nameDep;
            arrivee = arrivee + snapshot.data[1].nameDest;

            return Column(
              children: [
                Container(
                  height: screenHeight - 250,
                  width: screenWidth,
                  child: FlutterMap(
                    options: new MapOptions(
                      center: latLng.LatLng(
                          snapshot.data[0].lat, snapshot.data[1].lan),
                      //zoom: 10.0,
                      bounds: LatLngBounds.fromPoints(itineraire),
                      plugins: [
                        MarkerClusterPlugin(),
                      ],
                    ),
                    layers: [
                      TileLayerOptions(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerClusterLayerOptions(
                        maxClusterRadius: 120,
                        size: Size(40, 40),
                        fitBoundsOptions: FitBoundsOptions(
                          padding: EdgeInsets.all(50),
                        ),
                        markers: markers,
                        polygonOptions: PolygonOptions(
                            borderColor: Colors.blueAccent,
                            color: Colors.black12,
                            borderStrokeWidth: 3),
                        builder: (context, markers) {
                          return FloatingActionButton(
                            child: Text(markers.length.toString()),
                            onPressed: null,
                          );
                        },
                      ),
                      PolylineLayerOptions(polylines: [
                        Polyline(
                            points: itineraire,
                            strokeWidth: 5.0,
                            color: Colors.red)
                      ])
                    ],
                  ),
                ),
                InfoCard(
                    name: "name",
                    price: "price",
                    placeDisponible: "placeDisponible",
                    verified: false,
                    departure: "depart",
                    arrival: arrivee,
                    userImage: "assets/marker.png",
                    carBrand: "carBrand",
                    departureDate: "departureDate",
                    departureHour: "departureHour",
                    rating: "rating")
                // Container(
                //   width: screenWidth,
                //   //height: 66,
                //   color: Colors.white,
                //   child: Stack(
                //     children: [
                //       Positioned(
                //         right: 10,
                //         child: Center(
                //           child: Text("data"),
                //         ),
                //       ),
                //       // Positioned(
                //       //     right: 0, child: connectorTop(context, depart)),
                //       // SizedBox(
                //       //   height: 12.0,
                //       //   child: SolidLineConnector(
                //       //     color: Colors.blue,
                //       //   ),
                //       // ),
                //       // connectorBottom(context, arrivee),
                //     ],
                //   ),
                // )
              ],
            );
            //Center(child: Text(snapshot.data[0].nameDep.toString()));
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      // FlutterMap(
      //   options: new MapOptions(
      //     center: latLng.LatLng(34.22, -101.83),
      //     zoom: 5.0,
      //     plugins: [
      //       MarkerClusterPlugin(),
      //     ],
      //   ),
      //   layers: [
      //     TileLayerOptions(
      //       urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      //       subdomains: ['a', 'b', 'c'],
      //     ),
      //     MarkerClusterLayerOptions(
      //       maxClusterRadius: 120,
      //       size: Size(40, 40),
      //       fitBoundsOptions: FitBoundsOptions(
      //         padding: EdgeInsets.all(50),
      //       ),
      //       markers: markers,
      //       polygonOptions: PolygonOptions(
      //           borderColor: Colors.blueAccent,
      //           color: Colors.black12,
      //           borderStrokeWidth: 3),
      //       builder: (context, markers) {
      //         return FloatingActionButton(
      //           child: Text(markers.length.toString()),
      //           onPressed: null,
      //         );
      //       },
      //     ),
      //     PolylineLayerOptions(polylines: [
      //       Polyline(points: itineraire, strokeWidth: 5.0, color: Colors.red)
      //     ])
      //   ],
      // ),
    );
  }
}

/********************* Using flutter markers without liste **********************/
//FlutterMap(
//   options: MapOptions(
//     center: latLng.LatLng(34.22, -101.83 ),
//     zoom: 5.0,
//   ),
//   layers: [
//     TileLayerOptions(
//       urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//       subdomains: ['a', 'b', 'c']
//     ),
//     MarkerLayerOptions(
//       markers: [
//         Marker(
//           width: 50.0,
//           height: 50.0,
//           point: latLng.LatLng(35.22, -101.83),
//           builder: (ctx) =>
//           Container(
//             child: Image.asset(
//               "assets/marker.png",
//               height: 20,
//               width: 10 ,

//               ),
//           ),
//         ),
//         Marker(
//           width: 50.0,
//           height: 50.0,
//           point: latLng.LatLng(32.77, -96.79),
//           builder: (ctx) =>
//           Container(
//             child:  Image.asset(
//               "assets/marker.png",
//               height: 20,
//               width: 10 ,

//               ),
//           ),
//         ),
//       ],
//     ),
//     PolylineLayerOptions(
//        polylines: [
//          Polyline(
//            points: itineraire ,
//            strokeWidth: 5.0 ,
//            color: Colors.red
//          )
//        ]
//     )
//   ],
// ),
