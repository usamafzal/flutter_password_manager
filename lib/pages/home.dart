// Importing Flutter's material design package
import 'package:flutter/material.dart';
// Importing database helper for database operations
import 'package:password_saving/database/db_helper.dart';
// Importing the Credential model class
import 'package:password_saving/model/credentials_model.dart';
// Importing the detailed screen for viewing and editing credentials
import 'package:password_saving/pages/detailed_screen.dart';
// Importing custom navigation utilities
import 'package:password_saving/utils/cutom_navigation.dart';

// Importing a utility for card design
import '../utils/card_design.dart';

// HomePage widget as the main screen
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// State for HomePage
class _HomePageState extends State<HomePage> {
  // Instance of the DatabaseHelper for interacting with the database
  DatabaseHelper databaseHelper = DatabaseHelper.getInstance;

  // List to store fetched credentials from the database
  List<Credential>? credential;

  // Map to track the visibility status of passwords
  Map<int, bool> isPasswordVisibility = {};

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is initialized
    _getData();
  }

  // Fetches data from the database and initializes the visibility map
  void _getData() async {
    credential = await databaseHelper.getAllData();
    // Initialize the visibility map with all passwords set to hidden
    isPasswordVisibility = {for (final i in credential!) i.id!: false};
    setState(() {});
  }

  // Toggles the visibility of a password for a specific credential
  void toggleVisibilityDetector(int id) {
    setState(() {
      isPasswordVisibility[id] = !isPasswordVisibility[id]!;
    });
  }

  // Navigates to the add credential screen
  void addData() {
    navigationScreen(context, _getData, const DetailedScreen());
  }

  // Navigates to the update credential screen with the selected credential
  void updateData(Credential credential) {
    navigationScreen(
        context,
        _getData,
        DetailedScreen(
          credential: credential,
        ));
  }

  // Deletes a credential by ID and refreshes the list
  void deleteData(int id) async {
    await databaseHelper.deleteData(id);
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // AppBar with a title
        title: const Text(
          "Credentials",
          style: TextStyle(fontFamily: "roboto"),
        ),
        centerTitle: true,
      ),
      body: credential != null
          ? credential!.isEmpty
              // Display a message if no credentials are found
              ? const Center(
                  child: Text(
                    "No Credential Data Found🔒",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              // Display a list of credentials
              : SafeArea(
                  child: ListView.builder(
                    itemCount: credential!.length,
                    itemBuilder: (context, index) {
                      final data = credential![index];
                      bool isPasswordVisible =
                          isPasswordVisibility[data.id] ?? false;

                      // Custom widget for displaying a credential item
                      return PasswordListItem(
                        serviceName: data.servicename!,
                        username: data.username!,
                        password: data.password!,
                        isPasswordVisible: isPasswordVisible,
                        // Toggle password visibility
                        onTogglePasswordVisibility: () {
                          toggleVisibilityDetector(data.id!);
                        },
                        // Edit the selected credential
                        onEdit: () {
                          updateData(data);
                        },
                        // Delete the selected credential with confirmation
                        onDelete: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Delete"),
                                content: const Text(
                                    "Are you sure you want to delete?"),
                                actions: [
                                  GestureDetector(
                                    onTap: () {
                                      deleteData(data.id!);
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Ok",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.red),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.green),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                )
          // Display a loading spinner while fetching data
          : const Center(
              child: CircularProgressIndicator(),
            ),
      // Floating action button for adding a new credential
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
