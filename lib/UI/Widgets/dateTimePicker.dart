// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

// // ...

// class BasicDateField extends StatelessWidget {
//   final format = DateFormat("yyyy-MM-dd");
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       Text('Basic date field (${format.pattern})'),
//       DateTimeField(
//         format: format,
//         onShowPicker: (context, currentValue) {
//           return showDatePicker(
//               context: context,
//               firstDate: DateTime(1900),
//               initialDate: currentValue ?? DateTime.now(),
//               lastDate: DateTime(2100));
//         },
//       ),
//     ]);
//   }
// }

// class BasicTimeField extends StatelessWidget {
//   final format = DateFormat("HH:mm");
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       Text('Basic time field (${format.pattern})'),
//       DateTimeField(
//         format: format,
//         onShowPicker: (context, currentValue) async {
//           final time = await showTimePicker(
//             context: context,
//             initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
//           );
//           return DateTimeField.convert(time);
//         },
//       ),
//     ]);
//   }
// }

// class BasicDateTimeField extends StatelessWidget {
//   final format = DateFormat("yyyy-MM-dd HH:mm");
//   final dateTimeNow = DateTime.now();
//   final String labelText;
//   final String hintText;

//   BasicDateTimeField({Key key, this.labelText, this.hintText})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       //Text('Basic date & time field (${format.pattern})'),
//       DateTimeField(
//         decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             labelText: this.labelText,
//             hintText: this.hintText.length > 2 ? this.hintText : "$dateTimeNow",
//             prefixIcon: Icon(Icons.date_range)),
//         format: format,
//         onShowPicker: (context, currentValue) async {
//           final date = await showDatePicker(
//               context: context,
//               firstDate: DateTime(1900),
//               initialDate: currentValue ?? DateTime.now(),
//               lastDate: DateTime(2100));
//           if (date != null) {
//             final time = await showTimePicker(
//               context: context,
//               initialTime:
//                   TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
//             );
//             return DateTimeField.combine(date, time);
//           } else {
//             return currentValue;
//           }
//         },
//       ),
//     ]);
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

// ...

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic date field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}

class BasicDateTimeField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final dateTimeNow = DateTime.now();
  final String labelText;
  final String hintText;

  BasicDateTimeField({Key key, this.labelText, this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.now().year.toString() +
        "-" +
        DateTime.now().month.toString() +
        "-" +
        DateTime.now().day.toString() +
        " " +
        DateTime.now().hour.toString() +
        "-" +
        DateTime.now().minute.toString();
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Container(
        height: 75.0,
        decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [Color(0xffE7EC1D), Color(0xff27A536)],
            //   begin: Alignment.centerLeft,
            //   end: Alignment.centerRight,
            // ),
            border: Border.all(color: Colors.grey[400], width: 0.8),
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0)),
        child: Center(
          child: Material(
            color: Colors.transparent,
            elevation: 0.0,
            shadowColor: Colors.black,
            borderRadius: BorderRadius.circular(0.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: DateTimeField(
                // decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //     labelText: this.labelText,
                //     hintText: this.hintText.length > 2 ? this.hintText : "$dateTimeNow",
                //     prefixIcon: Icon(Icons.date_range)),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.date_range,
                    color: Colors.blueGrey,
                    size: 32.0, /*Color(0xff224597)*/
                  ),
                  //labelText: labelText,
                  labelStyle: TextStyle(color: Colors.black54, fontSize: 18.0),
                  hintText: dateTime,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                    //fontWeight: FontWeight.bold
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                  border: InputBorder.none,
                ),
                format: format,
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
