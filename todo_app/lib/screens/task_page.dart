import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/main_controller.dart';
import 'package:todo_app/controller/text_controller.dart';
import 'package:todo_app/model/checkbox_model.dart';
import 'package:todo_app/model/task_model.dart';

class TaskPage extends StatefulWidget {
  final Task task;

  TaskPage({@required this.task});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  bool _editTitle = false;
  bool _editMode = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mainController = Get.find<MainController>();
    final textController = Get.put(TextController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.red),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.offNamed('/home');
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _editMode = !_editMode;
              });
            },
            child: _editMode == true
                ? Text(
                    'Safe Mode',
                    style: TextStyle(color: Colors.blue),
                  )
                : Text('Edit Mode'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          textController.taskController.clear();
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              context: context,
              builder: (context) {
                return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Add Task',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: textController.taskController,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          ),
                          Row(
                            children: [
                              Spacer(),
                              ElevatedButton(
                                  onPressed: () {
                                    mainController.addToListOfTask(ToDoCheckbox(
                                        label:
                                            textController.taskController.text,
                                        value: false));
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TaskPage(
                                                task: mainController
                                                    .currentTask)));
                                  },
                                  child: Text('Save')),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                  onPressed: () {
                                    textController.taskController.clear();
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'))
                            ],
                          )
                        ]));
              });
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(20, 50, 0, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _editTitle
                    ? Flexible(
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          controller: textController.titleController,
                        ),
                      )
                    : Flexible(
                        child: Text(
                          widget.task.title,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                if (_editMode)
                  _editTitle
                      ? TextButton(
                          onPressed: () {
                            mainController.editTitleTask(widget.task,
                                textController.titleController.text);
                            setState(() {
                              _editTitle = false;
                            });
                          },
                          child: Text('Done'))
                      : TextButton(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(20, 20)),
                          onPressed: () {
                            textController.editTitle(widget.task.title);
                            setState(() {
                              _editTitle = true;
                            });
                          },
                          child: Icon(
                            Icons.edit,
                            size: 18,
                          ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '${mainController.getAllTrue(widget.task).toString()} of ${widget.task.list.length} tasks',
              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: SizedBox(
                height: widget.task.list.length * 60.toDouble(),
                width: double.infinity,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.task.list.length,
                    itemBuilder: (context, int index) {
                      final e = widget.task.list[index];
                      return SizedBox(
                        height: 60,
                        child: Card(
                          elevation: 3,
                          child: CheckboxListTile(
                            contentPadding:
                                EdgeInsets.only(left: 20, right: 20),
                            value: e.value,
                            onChanged: (value) {
                              setState(() {
                                e.value = !e.value;
                              });
                            },
                            title: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    e.label,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                if (_editMode)
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size(20, 20)),
                                      onPressed: () {
                                        textController.editTask(e.label);
                                        showModalBottomSheet(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(
                                                  builder: (context, setState) {
                                                return Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        'Edit Task',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      TextFormField(
                                                        controller:
                                                            textController
                                                                .taskController,
                                                        decoration: InputDecoration(
                                                            border:
                                                                OutlineInputBorder()),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Spacer(),
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                mainController.editToDoTask(
                                                                    e,
                                                                    textController
                                                                        .taskController
                                                                        .text);

                                                                Navigator.pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                TaskPage(task: mainController.currentTask)));
                                                                //  Get.to(() => TaskPage(task: taskController.tasks[index]));
                                                              },
                                                              child:
                                                                  Text('Save')),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          TextButton(
                                                              onPressed: () {
                                                                textController
                                                                    .taskController
                                                                    .clear();
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                  'Cancel'))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                            });
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        size: 15,
                                      ))
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              // child: Column(
              //   children: widget.task.list
              //       .map((e) => Card(
              //             elevation: 5,
              //             child: CheckboxListTile(
              //               contentPadding:
              //                   EdgeInsets.only(left: 20, right: 20),
              //               value: e.value,
              //               onChanged: (value) {
              //                 setState(() {
              //                   e.value = !e.value;
              //                 });
              //               },
              //               title: Row(
              //                 children: [
              //                   Flexible(
              //                     child: Text(
              //                       e.label,
              //                       overflow: TextOverflow.ellipsis,
              //                       style: TextStyle(
              //                         fontSize: 15,
              //                       ),
              //                     ),
              //                   ),
              //                   if (_editMode)
              //                     TextButton(
              //                         style: TextButton.styleFrom(
              //                             padding: EdgeInsets.zero,
              //                             minimumSize: Size(20, 20)),
              //                         onPressed: () {
              //                           textController.editTask(e.label);
              //                           showModalBottomSheet(
              //                               shape: RoundedRectangleBorder(
              //                                 borderRadius:
              //                                     BorderRadius.circular(20.0),
              //                               ),
              //                               context: context,
              //                               builder: (context) {
              //                                 return StatefulBuilder(
              //                                     builder: (context, setState) {
              //                                   return Padding(
              //                                     padding: const EdgeInsets.all(
              //                                         20.0),
              //                                     child: Column(
              //                                       mainAxisAlignment:
              //                                           MainAxisAlignment
              //                                               .spaceEvenly,
              //                                       children: [
              //                                         Text(
              //                                           'Edit Task',
              //                                           style: TextStyle(
              //                                               fontSize: 20,
              //                                               fontWeight:
              //                                                   FontWeight
              //                                                       .bold),
              //                                         ),
              //                                         TextFormField(
              //                                           controller:
              //                                               textController
              //                                                   .taskController,
              //                                           decoration: InputDecoration(
              //                                               border:
              //                                                   OutlineInputBorder()),
              //                                         ),
              //                                         Row(
              //                                           children: [
              //                                             Spacer(),
              //                                             ElevatedButton(
              //                                                 onPressed: () {
              //                                                   mainController.editToDoTask(
              //                                                       e,
              //                                                       textController
              //                                                           .taskController
              //                                                           .text);

              //                                                   Navigator.pushReplacement(
              //                                                       context,
              //                                                       MaterialPageRoute(
              //                                                           builder:
              //                                                               (context) =>
              //                                                                   TaskPage(task: mainController.currentTask)));
              //                                                   //  Get.to(() => TaskPage(task: taskController.tasks[index]));
              //                                                 },
              //                                                 child:
              //                                                     Text('Save')),
              //                                             SizedBox(
              //                                               width: 10,
              //                                             ),
              //                                             TextButton(
              //                                                 onPressed: () {
              //                                                   textController
              //                                                       .taskController
              //                                                       .clear();
              //                                                   Navigator.pop(
              //                                                       context);
              //                                                 },
              //                                                 child: Text(
              //                                                     'Cancel'))
              //                                           ],
              //                                         )
              //                                       ],
              //                                     ),
              //                                   );
              //                                 });
              //                               });
              //                         },
              //                         child: Icon(
              //                           Icons.edit,
              //                           size: 15,
              //                         ))
              //                 ],
              //               ),
              //             ),
              //           ))
              //       .toList(),
              // ),
            )
          ],
        ),
      ),
    );
  }
}
