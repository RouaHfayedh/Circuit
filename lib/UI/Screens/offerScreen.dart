import 'package:flutter/material.dart';
import 'package:transporitn/Models/station.dart';
import 'package:transporitn/Services/service.dart';
import 'package:transporitn/UI/Widgets/mapView.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart' as latLng;

class OfferScreen extends StatefulWidget {
  OfferScreen({Key key}) : super(key: key);

  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  @override
  Widget build(BuildContext context) {
    var service = new Service();
    return Scaffold(
        // body: FutureBuilder<List<Station>>(
        //   future:
        //       service.fetchOffre(http.Client()), // fetchPhotos(http.Client()),
        //   builder: (context, snapshot) {
        //     print(snapshot.data[0].lan.toString());
        //     return Center(child: Text(snapshot.data[0].lan.toString()));
        //     // if (snapshot.hasError) print(snapshot.error);

        //     // return snapshot.hasData
        //     //     ? MapView(station: snapshot.data)
        //     //     : Center(child: CircularProgressIndicator());
        //   },
        // ),
        );
  }
}
