import 'package:flutter/material.dart';

import 'app_config.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

bool isbyCall = false;
bool isbyHelpDesk = false;
bool isbyItsm = false;
bool isbyEmail = false;

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextEditingController controller = TextEditingController();

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

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
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
                        controller: controller,
                        cursorWidth: 0.2,
                        cursorHeight: size.height * 0.03,
                        decoration: InputDecoration(
                          enabledBorder: border,
                          focusedBorder: onfocusBorder,
                        )),
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
              onPressed: () {},
              child: Text("save task"),
            ),
          ],
        ),
      ),
    );
  }
}
