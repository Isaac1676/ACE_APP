import 'package:flutter/material.dart';

class MyListile extends StatelessWidget {
  final String title;
  final String subtitle;
  final void Function()? onPressed;
  final bool isConfirmed;

  const MyListile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    required this.isConfirmed
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return ListTile(
        leading: const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.person_4,
              color: Colors.white,
            )),
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400),
        ),
        trailing: MaterialButton(
          onPressed: onPressed,
          color: isConfirmed ? Colors.grey : Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 0,
          child: Text(
            "Confirmer",
            style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.03,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w300),
          ),
        ));
  }
}
