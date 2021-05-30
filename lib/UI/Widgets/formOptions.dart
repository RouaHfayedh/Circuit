import 'package:flutter/material.dart';

class FormOptions extends StatelessWidget {
  const FormOptions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // aller Retour button
          InkWell(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 17.0, top: 15.0),
                    child: Text(
                      "Aller Retour",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Icon(Icons.arrow_drop_down_outlined),
                  ),
                ],
              ),
            ),
            onTap: () => print("Aller Retour inkwel tapped"),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // person number button
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 3.0, top: 15.0),
                            child: Icon(Icons.person),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                              "1",
                              style: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  onTap: () => print("person number inkwel tapped"),
                ),
                // ticket number button
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 17.0),
                    child: Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 4.0, top: 15.0),
                            child: Icon(Icons.local_activity_outlined),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                              "1",
                              style: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  onTap: () => print("Ticket number inkwel tapped"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
