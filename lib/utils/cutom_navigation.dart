// Importing Flutter's material design package
import 'package:flutter/material.dart';

// Function to navigate to a new screen with a fade transition
// Executes a callback function after returning to the previous screen
void navigationScreen(
    BuildContext context, Function getData, Widget routeName) async {
  // Use Navigator to push the new screen onto the navigation stack
  await Navigator.push(
    context,
    PageRouteBuilder(
      // Specify the page to navigate to
      pageBuilder: (context, animation, secondaryAnimation) => routeName,

      // Define a custom transition effect (fade transition)
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation, // Apply the animation to the screen's opacity
        child: child, // The child widget is the new screen
      ),
    ),
  );

  // Call the callback function to refresh or fetch data after navigation
  getData();
}
