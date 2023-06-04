import 'package:classify/pages/add_class.dart';
import 'package:classify/pages/edit_class.dart';
import 'package:classify/widgets/MyCircles.dart';
import 'package:classify/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:classify/user.dart';

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  User user = User();
  late Future getUserTimelinesDataFuture;


  @override
  void initState() {
    super.initState();
    updateList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var themeid = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 30, 25, 51),
        child: Column(
          children: [
            MyCircles(themeid: themeid, title: 'الحصص'),
            FutureBuilder(
              future: getUserTimelinesDataFuture,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator(color: myColors[themeid]![2],);
                  default:
                    if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                    else return createClassesView(context, snapshot);
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: myColors[themeid]![2],
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => const AddClassPage(),
            ))
                .then((value) {
              updateList();
            });
          },
          child: const Icon(Icons.add, color: Colors.white)),
    );
  }

  Widget createClassesView(BuildContext context, AsyncSnapshot snapshot) {
    dynamic classes = snapshot.data['message']['classes'];
    int size = int.parse(snapshot.data['message']['size'].toString());
    return Flexible(
      child: ListView.builder(
        itemCount: size,
        itemBuilder: (
            BuildContext context,
            int index,
            ) {
          return Slidable(
            key: UniqueKey(),
            endActionPane: ActionPane(
              dismissible: DismissiblePane(onDismissed: () async {
                await user.deleteClass(classes[index]['id'].toString());
                updateList();
              }),
              motion: DrawerMotion(),
              children: [
                SlidableAction(
                    onPressed: (BuildContext context) async {
                      // Do Nothing
                    },
                    backgroundColor: myColors[themeid]![2],
                    foregroundColor: Colors.white,
                    icon: Icons.delete_forever_rounded,
                    borderRadius: BorderRadius.circular(10),
                    label: 'Delete'),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(20 // (index % 2 == 0) ? 80 : 20,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                    builder: (context) => EditClassPage(
                        classId: classes[index]['id'].toString(),
                        name: allClasses[int.parse(classes[index]['class_number'].toString()) -1]['value'].toString(),
                        note: classes[index]['note'],
                        classStartTime: stringToTimeOfDay(classes[index]['start_time']),
                        classEndTime: stringToTimeOfDay(classes[index]['end_time'])
                    ),
                  ))
                      .then((value) {
                    updateList();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 232, 232, 232),
                    boxShadow: [
                      BoxShadow(
                        color: myColors[themeid]![3],
                        blurRadius: 40,
                        spreadRadius: -15,
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                          ),
                          child: Text(
                            allClasses[int.parse(classes[index]['class_number'].toString()) -1]['name'].toString(),
                            // '',
                            overflow: TextOverflow.ellipsis,
                            textScaleFactor: 1.3,
                            style: TextStyle(
                              // fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: myColors[themeid]![2],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                                (int.parse(classes[index]['class_number'].toString()) != 16 && int.parse(classes[index]['class_number'].toString()) != 18)
                                  ? '${stringToTimeOfDay(classes[index]['start_time']).format(context)} - ${stringToTimeOfDay(classes[index]['end_time']).format(context)}'
                                  : '${stringToTimeOfDay(classes[index]['start_time']).format(context)}',
                              overflow: TextOverflow.ellipsis,
                              textScaleFactor: 1.3,
                              style: TextStyle(
                                // fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: myColors[themeid]![1],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 0,
                            left: 10,
                          ),
                          child: Text(
                            classes[index]['note'],
                            overflow: TextOverflow.ellipsis,
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> updateList() async {
    setState(() {
      getUserTimelinesDataFuture = user.showUserClasses();
    });
  }
}
