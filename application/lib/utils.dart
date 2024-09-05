import 'package:flutter/material.dart';

void PopTillFirst(BuildContext context) {
  Navigator.popUntil(context, (route) => route.isFirst);
}
