import 'package:flutter/material.dart';

const maintheme = {
  'back': Color.fromARGB(255, 53, 53, 53),
  'text': Color.fromARGB(255, 222, 222, 222),
};

const myColors = {
  0: [
    Color.fromARGB(255, 134, 186, 234),
    Color.fromARGB(255, 82, 150, 214),
    Color.fromARGB(255, 37, 113, 185),
    Color.fromARGB(255, 28, 71, 112)
  ],
  1: [
    Color.fromARGB(255, 234, 166, 137),
    Color.fromARGB(255, 210, 133, 97),
    Color.fromARGB(255, 196, 112, 66),
    Color.fromARGB(255, 130, 66, 26)
  ],
  2: [
    Color.fromARGB(255, 111, 237, 168),
    Color.fromARGB(255, 57, 185, 115),
    Color.fromARGB(255, 22, 165, 87),
    Color.fromARGB(255, 24, 87, 52)
  ],
  3: [
    Color.fromARGB(255, 178, 108, 225),
    Color.fromARGB(255, 139, 71, 198),
    Color.fromARGB(255, 99, 18, 149),
    Color.fromARGB(255, 65, 27, 83)
  ],
  4: [
    Color.fromARGB(255, 235, 106, 136),
    Color.fromARGB(255, 201, 39, 79),
    Color.fromARGB(255, 159, 21, 58),
    Color.fromARGB(255, 112, 18, 40)
  ]
};

final List<dynamic> allClasses = const [
  { 'name' : 'الحصة الأولى',         'value': 1},
  { 'name' : 'الحصة الثانية',       'value': 2},
  { 'name' : 'الحصة الثالثة',       'value': 3},
  { 'name' : 'الحصة الرابعة',       'value': 4},
  { 'name' : 'الحصة الخامسة',       'value': 5},
  { 'name' : 'الحصة السادسة',       'value': 6},
  { 'name' : 'الحصة السابعة',       'value': 7},
  { 'name' : 'الحصة الثامنة',       'value': 8},
  { 'name' : 'الحصة التاسعة',       'value': 9},
  { 'name' : 'الحصة العاشرة',       'value': 10},
  { 'name' : 'الحصة الحادية عشر',   'value': 11},
  { 'name' : 'الحصة الثانية عشر',   'value': 12},
  { 'name' : 'الحصة الثالثة عشر',   'value': 13},
  { 'name' : 'الحصة الرابعة عشر',   'value': 14},
  { 'name' : 'الحصة الخامسة عشر',   'value': 15},
  { 'name' : 'طابور',               'value': 16},
  { 'name' : 'فرصة',                'value': 17},
  { 'name' : 'حكمة',                'value': 18},
];

List<DropdownMenuItem> allClassesDropdown = [
  DropdownMenuItem(child: Text('الحصة الأولى'), value: 1,),
  DropdownMenuItem(child: Text('الحصة الثانية'), value: 2,),
  DropdownMenuItem(child: Text('الحصة الثالثة'), value: 3,),
  DropdownMenuItem(child: Text('الحصة الرابعة'), value: 4,),
  DropdownMenuItem(child: Text('الحصة الخامسة'), value: 5,),
  DropdownMenuItem(child: Text('الحصة السادسة'), value: 6,),
  DropdownMenuItem(child: Text('الحصة السابعة'), value: 7,),
  DropdownMenuItem(child: Text('الحصة الثامنة'), value: 8,),
  DropdownMenuItem(child: Text('الحصة التاسعة'), value: 9,),
  DropdownMenuItem(child: Text('الحصة العاشرة'), value: 10,),
  DropdownMenuItem(child: Text('الحصة الحادية عشر'), value: 11,),
  DropdownMenuItem(child: Text('الحصة الثانية عشر'), value: 12,),
  DropdownMenuItem(child: Text('الحصة الثالثة عشر'), value: 13,),
  DropdownMenuItem(child: Text('الحصة الرابعة عشر'), value: 14,),
  DropdownMenuItem(child: Text('الحصة الخامسة عشر'), value: 15,),
  DropdownMenuItem(child: Text('طابور'), value: 16,),
  DropdownMenuItem(child: Text('فرصة'), value: 17,),
  DropdownMenuItem(child: Text('حكمة'), value: 18,),
];

List<DropdownMenuItem> availableClasses = [
  DropdownMenuItem(child: Text('الحصة الأولى'), value: 1,),
  DropdownMenuItem(child: Text('الحصة الثانية'), value: 2,),
  DropdownMenuItem(child: Text('الحصة الثالثة'), value: 3,),
  DropdownMenuItem(child: Text('الحصة الرابعة'), value: 4,),
  DropdownMenuItem(child: Text('الحصة الخامسة'), value: 5,),
  DropdownMenuItem(child: Text('الحصة السادسة'), value: 6,),
  DropdownMenuItem(child: Text('الحصة السابعة'), value: 7,),
  DropdownMenuItem(child: Text('الحصة الثامنة'), value: 8,),
  DropdownMenuItem(child: Text('الحصة التاسعة'), value: 9,),
  DropdownMenuItem(child: Text('الحصة العاشرة'), value: 10,),
  DropdownMenuItem(child: Text('الحصة الحادية عشر'), value: 11,),
  DropdownMenuItem(child: Text('الحصة الثانية عشر'), value: 12,),
  DropdownMenuItem(child: Text('الحصة الثالثة عشر'), value: 13,),
  DropdownMenuItem(child: Text('الحصة الرابعة عشر'), value: 14,),
  DropdownMenuItem(child: Text('الحصة الخامسة عشر'), value: 15,),
  DropdownMenuItem(child: Text('طابور'), value: 16,),
  DropdownMenuItem(child: Text('فرصة'), value: 17,),
  DropdownMenuItem(child: Text('حكمة'), value: 18,),
];

Future<void> showMyDialog(BuildContext context, String title, String body) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(body),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('اغلاق'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> showMyInputDialog(BuildContext context, String title, String body, TextEditingController _textFieldController, _onSet) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          onChanged: (value) { },
          controller: _textFieldController,
          decoration: InputDecoration(hintText: body),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('الغاء'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('ارسال'),
            onPressed: _onSet,
          ),
        ],
      );
    },
  );
}

Future<void> showMyLoadingDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return Dialog(
        // The background color
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // The loading indicator
              CircularProgressIndicator(
                color: myColors[4]![3],
              ),
              SizedBox(
                height: 15,
              ),
              // Some text
              Text('يرجى الإنتظار...')
            ],
          ),
        ),
      );
    },
  );
}


String to24hours(TimeOfDay timeOfDay) {
  final hour = timeOfDay.hour.toString().padLeft(2, "0");
  final min = timeOfDay.minute.toString().padLeft(2, "0");
  return "$hour:$min";
}

double timeOfDayToDouble(TimeOfDay myTime) => myTime.hour + myTime.minute/60.0;

TimeOfDay stringToTimeOfDay(String timeString){
  return TimeOfDay(
      hour: int.parse(timeString.split(":")[0]),
      minute: int.parse(timeString.split(":")[1])
  );
}