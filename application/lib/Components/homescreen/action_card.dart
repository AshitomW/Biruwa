import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  final String text;
  final Function ClickHandler;
  final IconData icon;
  final double Width;
  final double Height;
  ActionCard({
    super.key,
    required this.text,
    required this.ClickHandler,
    required this.icon,
    this.Width = 175,
    this.Height = 140,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ClickHandler(),
      child: Container(
        // Reduced margin
        padding: EdgeInsets.all(12), // Reduced padding
        height: Height, // Reduced height
        width: Width, // Reduced width
        decoration: BoxDecoration(
          color: Colors.white, // White background
          borderRadius: BorderRadius.circular(16), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02), // Shadow color
              offset: Offset(0, 1), // Shadow position (minor vertical offset)
              blurRadius: 1.0, // Shadow blur radius (controls the spread)
              spreadRadius: 1.0, // Shadow spread radius
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 42, // Slightly smaller icon for better balance
              color: Colors.black, // Dark color for better contrast
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
