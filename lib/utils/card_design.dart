// Importing Flutter's material design package
import 'package:flutter/material.dart';

// Stateless widget representing an individual credential item
class PasswordListItem extends StatelessWidget {
  // The name of the service associated with the credential
  final String serviceName;

  // The username associated with the credential
  final String username;

  // The password associated with the credential
  final String password;

  // Whether the password is currently visible
  final bool isPasswordVisible;

  // Callback function for toggling password visibility
  final VoidCallback onTogglePasswordVisibility;

  // Callback function for editing the credential
  final VoidCallback onEdit;

  // Callback function for deleting the credential
  final VoidCallback onDelete;

  const PasswordListItem({
    required this.serviceName,
    required this.username,
    required this.password,
    required this.isPasswordVisible,
    required this.onTogglePasswordVisibility,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Background color for the card
      color: Colors.lightBlue.shade50,
      // Margin around the card
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      // Elevation for shadow effect
      elevation: 3,
      // Rounded corners for the card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        // Padding inside the card
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the service name with an icon
            Row(
              children: [
                Icon(
                  Icons.lock_outline,
                  color: Colors.blue[400],
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    serviceName,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),

            // Display the username with an icon
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  color: Colors.grey[600],
                  size: 18.0,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    username,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[700],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),

            // Display the password with visibility toggle
            Row(
              children: [
                Icon(
                  Icons.vpn_key_outlined,
                  color: Colors.grey[600],
                  size: 18.0,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    isPasswordVisible ? password : '•' * 12,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[700],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  // Toggle visibility icon
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey[600],
                  ),
                  // Call the visibility toggle callback
                  onPressed: onTogglePasswordVisibility,
                ),
              ],
            ),
            const Divider(thickness: 1.0, height: 20.0, color: Colors.grey),

            // Buttons for editing and deleting the credential
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Edit button
                TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  label: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                // Delete button
                TextButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete, color: Colors.red),
                  label: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
