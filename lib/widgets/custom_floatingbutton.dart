import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final void Function(BuildContext) onPressed;

  const CustomFloatingButton({Key key, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            blurRadius: 25,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: FloatingActionButton(
        child: Icon(
          FeatherIcons.upload,
          color: const Color(0xFF545454),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        highlightElevation: 0,
        elevation: 0,
        tooltip: 'Adicionar despesa',
        onPressed: () => onPressed(context),
      ),
    );
  }
}
