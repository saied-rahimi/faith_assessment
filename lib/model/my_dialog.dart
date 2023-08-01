import 'package:flutter/material.dart';

void showSnackBarText(String text, context) {

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(milliseconds: 1500),
      content: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
            color: Colors.black.withOpacity(0.1),
          ),
          margin: const EdgeInsets.symmetric(vertical: 250),
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 7),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: 'Iransans',
                color: Colors.grey,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ),
  );
}