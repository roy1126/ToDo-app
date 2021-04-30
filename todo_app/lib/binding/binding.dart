import 'package:get/instance_manager.dart';
import 'package:todo_app/controller/main_controller.dart';

class TaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
  }
}
