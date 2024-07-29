import 'package:flutter/material.dart';

import '../app_config.dart';
import '../models/task_models.dart';
import '../services/hive_db_services.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

bool isbyCall = false;
bool isbyHelpDesk = false;
bool isbyItsm = false;
bool isbyEmail = false;

class _AddTaskState extends State<AddTask> {
  TextEditingController textController = TextEditingController();
  final TaskServices _taskServices = TaskServices();
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Res.grey,
        width: .5,
      ),
    );
    InputBorder onfocusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Res.kPrimaryColor,
        width: 1,
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("Task title: "),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                width: size.width * 0.57,
                height: size.height * 0.06,
                child: TextField(
                  controller: textController,
                  cursorWidth: 0.2,
                  cursorHeight: size.height * 0.03,
                  decoration: InputDecoration(
                    enabledBorder: border,
                    focusedBorder: onfocusBorder,
                  ),
                ),
              ),
            ),
          ],
        ),
        CheckboxListTile(
          title: Text("is by Call"),
          value: isbyCall,
          onChanged: (newValue) {
            setState(() {
              isbyCall = newValue!;
              print(isbyCall);
            });
          },
          controlAffinity:
              ListTileControlAffinity.leading, //  <-- leading Checkbox
        ),
        CheckboxListTile(
          title: Text("is by HelpDesk"),
          value: isbyHelpDesk,
          onChanged: (newValue) {
            setState(() {
              isbyHelpDesk = newValue!;
            });
          },
          controlAffinity:
              ListTileControlAffinity.leading, //  <-- leading Checkbox
        ),
        CheckboxListTile(
          title: Text("is by Itsm"),
          value: isbyItsm,
          onChanged: (newValue) {
            setState(() {
              isbyItsm = newValue!;
            });
          },
          controlAffinity:
              ListTileControlAffinity.leading, //  <-- leading Checkbox
        ),
        CheckboxListTile(
          title: Text("is by Email"),
          value: isbyEmail,
          onChanged: (newValue) {
            setState(() {
              isbyEmail = newValue!;
            });
          },
          controlAffinity:
              ListTileControlAffinity.leading, //  <-- leading Checkbox
        ),
        ElevatedButton(
          onPressed: () {
            String title = textController.text;
            if (title.isNotEmpty) {
              _taskServices.addTask(Task(title: title, taskMethods: [
                if (isbyCall) Method(name: "call", counter: 0),
                if (isbyHelpDesk) Method(name: "helpDesk", counter: 0),
                if (isbyItsm) Method(name: "itsm", counter: 0),
                if (isbyEmail) Method(name: "email", counter: 0),
              ]));

              textController.clear();
            }
          },
          child: Text("save task"),
        ),
      ],
    );
  }
}
