import 'package:flutter/material.dart';

class AboutTheApp extends StatelessWidget {
  const AboutTheApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About This App"),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: const Text(
              "This app is designed for Help Desk professionals to track their completed tasks and generate statistical reports in an Excel sheet within a specific time frame."),
        ),
      ),
    );
  }
}
