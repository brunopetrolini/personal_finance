import 'package:flutter/material.dart';

class ExpenseChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 25,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide.none,
        ),
        elevation: 0,
        color: const Color(0xFFFFFFFF),
        child: Text('Gráfico'),
      ),
    );
  }
}
