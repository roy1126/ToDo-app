import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/main_controller.dart';
import 'package:todo_app/screens/add_page.dart';
import 'package:todo_app/screens/task_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final taskController = Get.put(MainController());
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Sorry 😞',
                        textAlign: TextAlign.center,
                      ),
                      content: Text(
                        'Settings feature is currently on progress.',
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Ok'))
                      ],
                    );
                  });
            }),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 50, bottom: 30),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.2,
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tasks ',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Lists',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width * 0.2,
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.1),
            Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey[300])),
                child: TextButton(
                  onPressed: () {
                    Get.to(() => AddPage());
                  },
                  child: Icon(
                    Icons.add,
                    size: 20,
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              'Add List',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: size.height * 0.1),
            SizedBox(
              height: size.height * 0.38,
              child: ListView.separated(
                padding: EdgeInsets.only(left: 20, right: 20),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, int index) {
                  return SizedBox(
                    width: 10,
                  );
                },
                itemCount: taskController.finalTask().length,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: () {
                      taskController.replaceCurrentTask(
                          taskController.finalTask()[index]);
                      Get.to(() =>
                          TaskPage(task: taskController.finalTask()[index]));
                    },
                    child: Container(
                      width: isMobile ? 200 : size.width * 0.2,
                      decoration: BoxDecoration(
                        color: taskController.colors[index],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${taskController.finalTask()[index].title}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: taskController
                                      .finalTask()[index]
                                      .list
                                      .length,
                                  itemBuilder: (context, int j) {
                                    final e = taskController
                                        .finalTask()[index]
                                        .list[j];
                                    return CheckboxListTile(
                                      contentPadding: EdgeInsets.zero,
                                      value: e.value,
                                      onChanged: (value) {
                                        setState(() {
                                          e.value = !e.value;
                                        });
                                      },
                                      title: Text(
                                        e.label,
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
