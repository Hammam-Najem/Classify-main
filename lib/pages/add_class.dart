import 'package:flutter/material.dart';
import '../user.dart';
import '../widgets/utils.dart';

class AddClassPage extends StatefulWidget {
  const AddClassPage({Key? key}) : super(key: key);

  @override
  State<AddClassPage> createState() => _AddClassPageState();
}

class _AddClassPageState extends State<AddClassPage> {
  TextEditingController noteController = TextEditingController();
  TimeOfDay classStartTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay classEndTime = TimeOfDay(hour: 12, minute: 0);
  late DropdownMenuItem selectedClass;
  bool isTimeRangeValid = true;

  var themeid = 4;

  @override
  void initState() {
    super.initState();
    selectedClass = availableClasses[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة حصة'),
        backgroundColor: myColors[themeid]![3],
        centerTitle: true,
      ),
      body: Container(
        color: Color.fromARGB(255, 224, 227, 255),
        child: Column(
          children: <Widget>[
            // class name
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    items: availableClasses,
                    value: selectedClass.value,
                    isExpanded: true,
                    isDense: true,
                    menuMaxHeight: MediaQuery.of(context).size.height/2,
                    iconSize: 50,
                    iconEnabledColor: myColors[themeid]![1],
                    dropdownColor: myColors[themeid]![0],
                    onChanged: (value) {
                      setState(() {
                        selectedClass = allClassesDropdown[value -1 ];
                      });
                    },
                  ),
              ),
              // child: TextField(
              //   controller: classNameController,
              //   decoration: const InputDecoration(
              //     labelText: 'إسم الحصة',
              //   ),
              // ),
            ),
            // note
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                controller: noteController,
                decoration: const InputDecoration(
                  labelText: 'ملاحظة',
                ),
              ),
            ),
            // class start time
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListTile(
                  leading: Text(
                    'وقت البدء:',
                    textScaleFactor: 2.0,
                    style: TextStyle(
                      // fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: myColors[themeid]![1],
                    ),
                  ),
                  title: Text(
                    classStartTime.format(context),
                    textScaleFactor: 2.0,
                    style: TextStyle(
                      // fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: myColors[themeid]![1],
                    ),
                  ),
                  trailing: Icon(Icons.access_time, color: myColors[themeid]![0]),
                  dense: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(32), bottomRight: Radius.circular(32)),
                    side: BorderSide(color: myColors[themeid]![3], width: 1),
                  ),
                  onTap: () async {
                    final time = (await showTimePicker(
                      context: context,
                      initialTime: classStartTime,
                      initialEntryMode: TimePickerEntryMode.input,
                    ))!;
                    setState(() {
                      classStartTime = time;
                      isTimeRangeValid =
                        (selectedClass.value != 16 && selectedClass.value != 18) ?
                          timeOfDayToDouble(classStartTime) < timeOfDayToDouble(classEndTime) :
                          true
                      ;
                    });
                  }
              ),
            ),
            // class end time
            ( selectedClass.value != 16 && selectedClass.value != 18)
                ?
                    Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListTile(
                  leading: Text(
                    'وقت الإنتهاء:',
                    textScaleFactor: 2.0,
                    style: TextStyle(
                      // fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: myColors[themeid]![1],
                    ),
                  ),
                  title: Text(
                    classEndTime.format(context),
                    textScaleFactor: 2.0,
                    style: TextStyle(
                      // fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: myColors[themeid]![1],
                    ),
                  ),
                  trailing: Icon(Icons.access_time, color: myColors[themeid]![0]),
                  dense: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(32), bottomRight: Radius.circular(32)),
                    side: BorderSide(color: myColors[themeid]![3], width: 1),
                  ),
                  onTap: () async {
                    final time = (await showTimePicker(
                      context: context,
                      initialTime: classEndTime,
                      initialEntryMode: TimePickerEntryMode.input,
                    ))!;
                    setState(() {
                      classEndTime = time;
                      isTimeRangeValid =
                        (selectedClass.value != 16 && selectedClass.value != 18) ?
                          timeOfDayToDouble(classStartTime) < timeOfDayToDouble(classEndTime) :
                          true
                      ;
                    });
                  }
              ),
            )
                :
                    SizedBox(),
            // error massage if needed
            !isTimeRangeValid ?
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'يجب أن يكون وقت الإنتهاء أكبر من وقت البدء !!',
                      overflow: TextOverflow.fade,
                      textScaleFactor: 1.3,
                      style: TextStyle(
                        // fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
            )
            : SizedBox(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: myColors[themeid]![3],
        onPressed: () async {
          if(isTimeRangeValid){
            showMyLoadingDialog(context);
            User user = User();
            BackendMessage response = await user.addClass(selectedClass.value.toString(), noteController.text, to24hours(classStartTime), to24hours(classEndTime) );
            Navigator.pop(context);
            if (response.status == 'success'){
              Navigator.pop(context);
            } else {
              showMyDialog(context, 'خطأ', response.message);
            }
          }
        },
        child: isTimeRangeValid ? const Icon(Icons.add,): const Icon(Icons.error,),
      ),
    );
  }


}
