import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:transporitn/Models/station.dart';

class Service {
  List<Station> parseOffre(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Station>((json) => Station.fromJson(json)).toList();
  }

  Future<List<Station>> fetchOffre(
      http.Client client, lat1, lan1, lat2, lan2) async {
    var url = Uri.parse('https://hidden-inlet-64220.herokuapp.com/');
    final response = await client.post(url, body: {
      'lat1': '$lat1',
      'lan1': '$lan1',
      'lat2': '$lat2',
      'lan2': '$lan2'
    });

    /*await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/photos')); */

    // Use the compute function to run parsePhotos in a separate isolate.
    return parseOffre(response.body);
  }

  getOffre() async {
    var url = Uri.parse('https://hidden-inlet-64220.herokuapp.com/');
    var response = await http.post(url, body: {
      'lat1': '35.823166 ',
      'lan1': '10.636622',
      'lat2': '33.8933',
      'lan2': '10.1029'
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    //return (response.body);

    //print(await http.read('https://example.com/foobar.txt'));
  }
}
