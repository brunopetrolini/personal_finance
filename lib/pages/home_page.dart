import 'dart:math';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

// Models imports
import '../models/transaction.dart';

// Widgets imports
import '../widgets/custom_floatingbutton.dart';
import '../widgets/expense_card.dart';
import '../widgets/expense_chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  List<Transaction> _transactions = [];

  void _addNewExpense(String description, double value) {
    final newExpense = Transaction(
      id: Random().nextDouble().toString(),
      description: description,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newExpense);
    });
  }

  void _onExpenseDismiss(String id) {
    _transactions.removeWhere((item) => item.id == id);
  }

  void _showExpenseInput(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) => Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              blurRadius: 50,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(0.3),
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xFFFFFFFF),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFF9FAFC),
                ),
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'digite a descrição...',
                    prefixIcon: Icon(FeatherIcons.edit),
                  ),
                  keyboardType: TextInputType.text,
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFF9FAFC),
                ),
                child: TextField(
                  controller: valueController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'digite o valor...',
                    prefixIcon: Icon(FeatherIcons.dollarSign),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
              SizedBox(height: 16),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () {
                  if (descriptionController.text.isNotEmpty &&
                      valueController.text.isNotEmpty) {
                    _addNewExpense(descriptionController.text,
                        double.parse(valueController.text));
                  }

                  Navigator.of(context).pop();

                  descriptionController.clear();
                  valueController.clear();
                },
                child: Text(
                  'Adicionar Despesa',
                  style: TextStyle(
                    color: const Color(0xFFE53935),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF9FAFC),
        title: Text(
          'Despesas Pessoais',
          style: TextStyle(
            color: const Color(0xFF000000),
          ),
        ),
      ),
      floatingActionButton: CustomFloatingButton(
        onPressed: (context) => _showExpenseInput(context),
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 8, 0, 8),
                  child: Text(
                    'Gráfico de gastos semanal',
                    style: TextStyle(
                      color: const Color(0xFF545454),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ExpenseChart(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 30, 0, 8),
            child: Text(
              'Listagem de despesas',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: const Color(0xFF545454),
              ),
            ),
          ),
          ..._transactions
              .map((item) => ExpenseCard(
                    onDismissible: _onExpenseDismiss,
                    id: item.id,
                    description: item.description,
                    date: item.date,
                    value: item.value,
                  ))
              .toList(),
        ],
      ),
    );
  }
}
