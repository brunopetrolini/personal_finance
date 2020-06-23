import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  final String id;
  final String description;
  final DateTime date;
  final double value;
  final Function(String) onDismissible;

  const ExpenseCard({
    Key key,
    @required this.id,
    @required this.description,
    @required this.date,
    @required this.value,
    @required this.onDismissible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      onDismissed: (direction) {
        onDismissible(id);
      },
      direction: DismissDirection.endToStart,
      background: Icon(
        FeatherIcons.trash2,
        color: const Color(0xFFE53935),
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
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
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide.none,
          ),
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  FeatherIcons.dollarSign,
                  color: const Color(0xFFE8EAED),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Data: ${DateFormat('d MMM y').format(date)}',
                        style: TextStyle(
                          color: const Color(0xFF545454),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFE53935),
                      width: 1.2,
                    ),
                  ),
                  child: Text(
                    'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: const Color(0xFFE53935),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
