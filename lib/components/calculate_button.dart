import 'package:flutter/material.dart';

import '../constants.dart';


class CalculateButtonComponent extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback? onTap;
  final bool state;
  CalculateButtonComponent({required this.buttonTitle, required this.onTap, required this.state});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            buttonTitle,
            style: kLargeButtonStyle,
          ),
        ),
        color: state ? mDisabled : mButtonColor,
        margin: EdgeInsets.only(top: kMarginContainer),
        padding: EdgeInsets.only(bottom: 5.0),
        width: double.infinity,
        height: kButtonContainerHeight,
      ),
    );
  }
}