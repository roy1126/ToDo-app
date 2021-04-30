import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/main_controller.dart';
import 'package:todo_app/controller/text_controller.dart';
import 'package:todo_app/model/checkbox_model.dart';
import 'package:todo_app/model/task_model.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  List<ToDoCheckbox> _todos = [];
  @override
  Widget build(BuildContext context) {
    final textController = Get.put(TextController());
    final mainController = Get.put(MainController());

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.red),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.offNamed('/home');
            // Get.toNamed('/home');
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                mainController.addTask(Task(
                    id: mainController.tasks.length + 1,
                    title: textController.titleController.text,
                    list: _todos));
                Get.offNamed('/home');
              },
              child: Text('Save'))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
                                    setState(() {
                                      _todos.add(ToDoCheckbox(
                                          label: textController
                                              .taskController.text,
                                          value: false));
                                    });
                                    Navigator.pop(context);
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
        padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Add ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Task',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 24,
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            TextFormField(
              controller: textController.titleController,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  errorStyle:
                      TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
                  contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  alignLabelWithHint: true,
                  hintText: 'Title',
                  hintStyle: TextStyle(
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey),
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            _todos.isEmpty
                ? Center(
                    heightFactor: 5,
                    child: Text(
                      'No task to shown. Click Add Button.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ))
                : Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(
                      children: _todos
                          .map((e) => Card(
                                elevation: 5,
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
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
