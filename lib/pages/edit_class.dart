import 'package:flutter/material.dart';
import '../user.dart';
import '../widgets/utils.dart';

class EditClassPage extends StatefulWidget {

  String classId;
  String name;
  String note;
  TimeOfDay classStartTime;
  TimeOfDay classEndTime;

  EditClassPage({Key? key, required this.classId, required this.name, required this.note, required this.classEndTime, required this.classStartTime}) : super(key: key);

  @override
  State<EditClassPage> createState() => _EditClassPageState();
}

class _EditClassPageState extends State<EditClassPage> {
  TextEditingController noteController = TextEditingController();
  late DropdownMenuItem selectedClass;
  bool isTimeRangeValid = true;

  var themeid = 4;

  @override
  void initState() {
    super.initState();
    selectedClass = allClassesDropdown[int.parse(widget.name) - 1];
    noteController.text = widget.note;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل بيانات الحصة'),
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
                  widget.classStartTime.format(context),
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
                    initialTime: widget.classStartTime,
                    initialEntryMode: TimePickerEntryMode.input,
                  ))!;
                  setState(() {
                    widget.classStartTime = time;
                    isTimeRangeValid =
                      (selectedClass.value != 16 && selectedClass.value != 18) ?
                        timeOfDayToDouble(widget.classStartTime) < timeOfDayToDouble(widget.classEndTime) :
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
                        widget.classEndTime.format(context),
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
                          initialTime: widget.classEndTime,
                          initialEntryMode: TimePickerEntryMode.input,
                        ))!;
                        setState(() {
                          widget.classEndTime = time;
                          isTimeRangeValid =
                            (selectedClass.value != 16 && selectedClass.value != 18) ?
                              timeOfDayToDouble(widget.classStartTime) < timeOfDayToDouble(widget.classEndTime) :
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
                      textScaleFactor: 1.3,
                      overflow: TextOverflow.fade,
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
            // final todoController =
            //     Provider.of<TodoController>(context, listen: false);
            // todoController.addTodo(
            //   title: classNameController.text,
            //   description: noteController.text,
            // );
            User user = User();
            BackendMessage response = await user.editClass(widget.classId, selectedClass.value.toString(), noteController.text, to24hours(widget.classStartTime), to24hours(widget.classEndTime) );
            Navigator.pop(context);
            if (response.status == 'success'){
              Navigator.pop(context);
            } else {
              showMyDialog(context, 'Error', response.message);
            }
          }
        },
        child: isTimeRangeValid ? const Icon(Icons.edit): const Icon(Icons.error,),
      ),
    );
  }
}
