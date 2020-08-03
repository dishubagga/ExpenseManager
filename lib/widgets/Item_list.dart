import 'package:expenseManager/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemList extends StatelessWidget {
  final List<Transaction> _transaction;
  final Function _deleteTrx;
  ItemList(this._transaction, this._deleteTrx);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: LayoutBuilder(builder: (ctx, constraints) {
        return Container(
          height: constraints.maxHeight,
          child: SingleChildScrollView(
            child: Column(
              children: _transaction.map((trx) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: FittedBox(
                      child: Text(
                        "\$" + trx.amount.round().toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  title: Text(trx.title),
                  subtitle: Text(
                    DateFormat().format(trx.date),
                  ),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => _deleteTrx(trx.id)),
                );
              }).toList(),
            ),
          ),
        );
      }),
    );
  }
}
