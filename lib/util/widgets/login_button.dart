import 'package:flutter/material.dart';
import '../../Constants/theme_data.dart';


class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.txtColor,
    required this.btnColor,
  });

  final Function onTap;
  final String title;
  final Color txtColor;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: btnColor),
      child: SizedBox(
        height: 20,
        width: double.infinity,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: txtColor,
              fontFamily: fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}