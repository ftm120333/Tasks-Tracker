# task_counter

  Tasks Tracker is a simple task management app built using Flutter.
  The main goal of the app is to count the tasks that are done by employee in the help desk from different methods. 

## Features
   - Add and manage tasks easily
   - Track task counters with increment and decrement functionality
   - User-friendly interface with customizable task details
   - Data persistence using Hive for offline access
   - Drawer navigation with access to different sections

## Prerequisites
   - Flutter: Ensure Flutter is installed on your system. 
     You can download and set it up by following the instructions on the official Flutter website.
   - Git: Ensure Git is installed to clone the repository. Download Git here.
   - Hive: This project uses Hive for local data storage. No additional installation is required other than running the pub get command.

## Getting Started

To use this repo follow this steps

- Open a terminal and run the following command to clone the repository:

  git clone https://github.com/ftm120333/Task_counter

- Install dependencies: Run the following command to install all necessary packages and generate the files:
    
    flutter pub get
    flutter pub run build-runner build 
    flutter run

## Project Structure
  Here's an overview of the main folders and files in the project:
  
  - lib: Contains the main application code.
  - models: Holds the data models used in the app.
  - screens: Includes all the screens of the application.
  - services: Contains services like Hive operations for data handling.
  - components: Reusable UI components used throughout the app.
  - assets: Contains images, icons, and other assets used in the app.

# Usage
  - Manage Tasks: Add new tasks by using the "Add Task" button on the dashboard.
  - Track Counters: Each task has a counter that can be incremented or decremented based on the actions performed.
  - Navigation: Use the drawer to navigate between different sections of the app, such as task management, counters, and about information.
    Contributing
