import 'package:flutter/material.dart';
import '../model/todo.dart'; // Import ToDo model class
import '../widgets/todo_items.dart'; // Import ToDoItem widget

// Enumeration to represent different task categories
enum TaskCategory {
  all,
  completed,
  pending,
}

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<ToDo> todosList = ToDo.todoList(); // List of all tasks
  List<ToDo> _foundToDo = []; // List of tasks to display based on category
  TaskCategory _selectedCategory =
      TaskCategory.all; // Default selected category

  @override
  void initState() {
    _updateTasks();
    // Initialize tasks based on selected category
    super.initState();
  }

  // Method to update the displayed tasks based on selected category
  void _updateTasks() {
    setState(() {
      switch (_selectedCategory) {
        case TaskCategory.all:
          _foundToDo = todosList; // Display all tasks
          break;
        case TaskCategory.completed:
          _foundToDo = todosList
              .where((todo) => todo.isDone)
              .toList(); // Display completed tasks
          break;
        case TaskCategory.pending:
          _foundToDo = todosList
              .where((todo) => !todo.isDone)
              .toList(); // Display pending tasks
          break;
      }
    });
  }

  // Method to handle task completion status change
  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone; // Toggle completion status
      _updateTasks(); // Update displayed tasks after status change
    });
  }

// Method to handle when the Help button is tapped
  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Help'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This is where you can find instructions or guidance on how to use the app. ',
              ),
              GestureDetector(
                onTap: () {
                  // Define the action you want to take when the link is clicked
                  // For example, you can navigate to a help screen.
                  Navigator.pushNamed(context, '/help');
                },
                child: Text(
                  'www.linkedin.com.',
                  style: TextStyle(
                    color: Color.fromARGB(
                        255, 34, 9, 155), // Style the link text color
                    decoration: TextDecoration.underline, // Underline the link
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Method to handle task deletion
  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id); // Remove task from list
      _updateTasks(); // Update displayed tasks after deletion
    });
  }

  // Method to show dialog for adding a new task
  Future<void> _showAddTaskDialog(BuildContext context) async {
    String newTaskText = ''; // Text entered by the user for the new task

    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Add New Task'),
          content: TextField(
            autofocus: true,
            onChanged: (value) {
              newTaskText = value; // Update newTaskText as the user types
            },
            decoration: InputDecoration(hintText: 'Enter task...'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add the new task to the list and update the tasks
                _addNewTask(newTaskText);
                Navigator.pop(dialogContext); // Close the dialog
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Method to add a new task to the list
  void _addNewTask(String taskText) {
    if (taskText.isNotEmpty) {
      // Generate a unique ID for the new task (you may use a different approach for IDs)
      String newTaskId = UniqueKey().toString();

      // Create a new ToDo object for the new task
      ToDo newTask = ToDo(
        id: newTaskId,
        todoText: taskText,
        isDone: false,
      );

      // Add the new task to the todosList
      setState(() {
        todosList.add(newTask);
        _updateTasks(); // Update the displayed tasks list
      });
    }
  }

  // Method to set the selected task category
  void _setSelectedCategory(TaskCategory category, BuildContext context) {
    setState(() {
      _selectedCategory = category; // Update selected category
      _updateTasks(); // Update displayed tasks based on new category
    });

    // Close the drawer and navigate to the tasks screen
    Navigator.pop(context); // Close the drawer
  }

// Method to handle logout action
  void _logout(BuildContext context) {
    // Perform logout actions here, such as clearing user data, navigating to login screen, etc.
    // For example:
    Navigator.pushReplacementNamed(context,
        '/login'); // Navigate to login screen and remove tasks screen from navigation stack
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Icon(Icons.assignment),
            ),
            SizedBox(width: 8),
            Text(
              'To-Do App',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 34, 167, 58),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        elevation: 0,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/pic.jpeg"),
              ),
              accountName: Text("Elias"),
              accountEmail: Text("eliaskaimenyi@gmail.com"),
            ),
            // Drawer menu items for different task categories
            ListTile(
              title: Text("All Tasks"),
              leading: Icon(Icons.menu_outlined),
              onTap: () => _setSelectedCategory(TaskCategory.all, context),
            ),
            ListTile(
              title: Text("Completed Tasks"),
              leading: Icon(Icons.check_box),
              onTap: () =>
                  _setSelectedCategory(TaskCategory.completed, context),
            ),
            ListTile(
              title: Text("Pending Tasks"),
              leading: Icon(Icons.incomplete_circle),
              onTap: () => _setSelectedCategory(TaskCategory.pending, context),
            ),
            // Inside your drawer's ListTile for the Help button
            ListTile(
              title: Text("Help"),
              leading: Icon(Icons.help_center),
              onTap: () => _showHelpDialog(context),
            ),
            ListTile(
              title: Text("Logout"),
              leading: Icon(Icons.logout),
              onTap: () => _logout(context), // Invoke the logout method here
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            // Search bar for filtering tasks (optional)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Color.fromARGB(248, 215, 241, 229),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                onChanged: (keyword) {
                  setState(() {
                    // Filter the todosList based on the keyword
                    _foundToDo = todosList
                        .where((todo) => todo.todoText
                            .toLowerCase()
                            .contains(keyword.toLowerCase()))
                        .toList();
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: const Color(0xFF272626),
                    size: 20,
                  ),
                  prefixIconConstraints:
                      BoxConstraints(maxHeight: 20, minWidth: 25),
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle:
                      TextStyle(color: const Color.fromARGB(255, 13, 12, 12)),
                ),
              ),
            ),

            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _foundToDo.length,
                itemBuilder: (context, index) => ToDoItem(
                  todo: _foundToDo[index],
                  onToDoChanged: _handleToDoChange,
                  onDeleteItem: _deleteToDoItem,
                ),
              ),
            ),
          ],
        ),
      ),
      // Floating action button to add new task
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show the dialog to add a new task
          _showAddTaskDialog(context);
        },
        tooltip: 'Add New Task',
        child: Icon(Icons.add),
      ),
      backgroundColor: Color.fromARGB(255, 136, 245, 131),
    );
  }
}
