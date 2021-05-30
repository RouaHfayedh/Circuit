import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatelessWidget {
  final userImage;
  final String name;
  final price;
  final placeDisponible;
  final bool verified;
  final departure;
  final arrival;
  final carBrand;
  final departureDate;
  final departureHour;
  final rating;
  const InfoCard(
      {Key key,
      @required this.name,
      @required this.price,
      @required this.placeDisponible,
      @required this.verified,
      @required this.departure,
      @required this.arrival,
      @required this.userImage,
      @required this.carBrand,
      @required this.departureDate,
      @required this.departureHour,
      @required this.rating})
      : super(key: key);

  Widget connector(BuildContext context, int index, ConnectorType type) {
    return SolidLineConnector(
      color: Colors.grey,
    );
  }

  Widget dot(BuildContext context, int index, ConnectorType type) {
    return SolidLineConnector(
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color greenColor = Color(0xff08A0AC);
    final Color goldColor = Color(0xffFFD700);
    final double leftInfoSize = 4.0;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Card(
          elevation: 15.0,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 12.0, left: 12.0, right: 12.0, bottom: 8.0),
            child: Container(
              width: screenWidth,
              height: 125,
              child: Stack(
                children: <Widget>[
                  // Positioned(
                  //   child: CircleAvatar(
                  //     radius: 28,
                  //     backgroundImage: AssetImage(
                  //       "$userImage",
                  //     ),
                  //   ),
                  // ),
                  // Positioned(
                  //   left: leftInfoSize,
                  //   top: 2,
                  //   child: Center(
                  //     child: Row(
                  //       children: [
                  //         Text(
                  //           name,
                  //           style: GoogleFonts.varelaRound(
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 17,
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           width: 3.0,
                  //         ),
                  //         verified
                  //             ? Icon(
                  //                 Icons.verified_outlined,
                  //                 color: Colors.blueGrey,
                  //                 size: 20.0,
                  //               )
                  //             : SizedBox(
                  //                 width: 0.0,
                  //               ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Positioned(
                  //     left: leftInfoSize,
                  //     top: 25,
                  //     child: Row(
                  //       children: [
                  //         Text(
                  //           "$price € ",
                  //           style: GoogleFonts.roboto(
                  //               fontSize: 17, fontWeight: FontWeight.bold),
                  //         ),
                  //         SizedBox(
                  //           width: 20,
                  //         ),
                  //         Text(
                  //           "$placeDisponible places",
                  //           style: GoogleFonts.roboto(fontSize: 17),
                  //         ),
                  //       ],
                  //     )),
                  Positioned(
                      left: leftInfoSize,
                      top: 10,
                      child: Column(
                        children: [
                          DotIndicator(
                            color: greenColor,
                          ),
                          SizedBox(
                            height: 35.0,
                            child: SolidLineConnector(
                              color: Colors.grey,
                            ),
                          ),
                          OutlinedDotIndicator(
                            color: Colors.grey,
                          )
                        ],
                      )),
                  Positioned(
                      left: leftInfoSize + 20.0,
                      top: 9,
                      child: Column(
                        children: [
                          Text("$departure"),
                          SizedBox(
                            height: 35.0,
                          ),
                          Text("$arrival"),
                        ],
                      )),
                  // Positioned(
                  //   left: leftInfoSize,
                  //   top: 100,
                  //   child: Text(
                  //     "$departureDate $departureHour",
                  //     style: GoogleFonts.varelaRound(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 15,
                  //         color: greenColor),
                  //   ),
                  // ),
                  // Positioned(
                  //   left: 0,
                  //   top: 60,
                  //   child: Container(
                  //     height: 28,
                  //     width: 56,
                  //     decoration: BoxDecoration(
                  //       border: Border.all(
                  //         color: Colors.grey,
                  //       ),
                  //       borderRadius: BorderRadius.circular(15.0),
                  //       color: Colors.grey[100],
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  //       child: Row(
                  //         children: [
                  //           Icon(
                  //             Icons.star,
                  //             color: goldColor,
                  //             size: 20.0,
                  //           ),
                  //           Text(
                  //             "$rating",
                  //             style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Positioned(
                  //   right: 0,
                  //   bottom: 0,
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       primary: greenColor, //onPrimary: Colors.white
                  //     ),
                  //     child: const Text(
                  //       'Details',
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //     onPressed: () {
                  //       print(screenWidth);
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          )),
    );
  }
}

/*
Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(
                    "assets/images/user.png",
                  ),
                ),
              ),
              title: Text('Mohamed Ben Halima'),
              //subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            FixedTimeline.tileBuilder(
              theme: TimelineThemeData(
                nodePosition: 0.1,
                connectorTheme: const ConnectorThemeData(
                  space: 30.0,
                  thickness: 2,
                ),
              ),
              builder: TimelineTileBuilder.connected(
                connectionDirection: ConnectionDirection.before,
                contentsBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('opposite contents'),
                ),
                indicatorBuilder: (context, index) => OutlinedDotIndicator(
                  color: greenColor,
                ),
                // oppositeContentsBuilder: timeLineWidgets.oppositeContent,
                connectorBuilder: connector,
                itemCount: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: greenColor, //onPrimary: Colors.white
                  ),
                  child: const Text(
                    'Details',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
*/
