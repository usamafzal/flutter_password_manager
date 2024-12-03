// Importing Flutter's material design package
import 'package:flutter/material.dart';
// Importing database helper for database operations
import 'package:password_saving/database/db_helper.dart';
// Importing the Credential model class
import 'package:password_saving/model/credentials_model.dart';
// Importing custom text field widget
import 'package:password_saving/utils/custom_text_field.dart';

// Detailed screen for adding or updating credentials
class DetailedScreen extends StatefulWidget {
  final Credential?
      credential; // Credential data for editing, null for new entry

  const DetailedScreen({super.key, this.credential});

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

// State class for DetailedScreen
class _DetailedScreenState extends State<DetailedScreen> {
  // Database helper instance
  DatabaseHelper helper = DatabaseHelper.getInstance;

  // Key for form validation
  final key = GlobalKey<FormState>();

  // Variables to hold form field values
  String serviceName = "";
  String username = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    // Populate form fields if editing an existing credential
    if (widget.credential?.servicename != null &&
        widget.credential?.username != null &&
        widget.credential?.password != null) {
      serviceName = widget.credential!.servicename!;
      username = widget.credential!.username!;
      password = widget.credential!.password!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Display appropriate title based on whether adding or editing
        title: Text(widget.credential == null
            ? "Add Credentials"
            : "Update Credentials"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Form(
            key: key, // Attach key to the form for validation
            child: Column(
              children: [
                // Service name field
                CustomTextFormField(
                  initialValue: serviceName,
                  labelText: "Service Name",
                  hintText: "Facebook, Google, Netflix",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Service Name is required";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    serviceName = value;
                  },
                ),
                const SizedBox(height: 20),

                // Username field
                CustomTextFormField(
                  initialValue: username,
                  labelText: "Username",
                  hintText: "abc01 or abc@gmail.com",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Username is required";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    username = value;
                  },
                ),
                const SizedBox(height: 20),

                // Password field with secure input
                CustomTextFormField(
                  initialValue: password,
                  labelText: "Password",
                  hintText: "******",
                  secure: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is required";
                    } else if (value.length < 6) {
                      return "Password length must be greater than 6 characters";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 20),

                // Submit button for adding or updating the credential
                ElevatedButton(
                  onPressed: () async {
                    // Validate form fields
                    if (key.currentState!.validate()) {
                      // Create a Credential object with form values
                      Credential credential = Credential(
                          servicename: serviceName,
                          username: username,
                          password: password);

                      // Add or update the credential based on the current mode
                      if (widget.credential == null) {
                        await helper.addData(credential); // Add new data
                      } else {
                        credential.id =
                            widget.credential!.id; // Use existing ID
                        await helper.updateDate(credential); // Update data
                      }

                      // Navigate back to the previous screen
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      // Style for the button
                      backgroundColor: Colors.cyan.shade300,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      minimumSize: const Size(double.infinity, 50)),
                  child: Text(
                    widget.credential == null ? "Add Data" : "Update Data",
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
