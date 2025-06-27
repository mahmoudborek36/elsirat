import 'package:flutter/material.dart';

class arroeBackWidgeta extends StatelessWidget {
  const arroeBackWidgeta({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.all(15),
          child: Image.asset("assets/images/backButton.png"),
        ),
      ),
    ]);
  }
}
