import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentageOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child:
              FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}')),
        ),
        SizedBox(height: 4),
        Container(
          height: 70,
          width: 15,
          // stack--> two dimensional spaces, overlapping each other
          child: Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // this allows to create a box that is sized as a fraction of another value
            FractionallySizedBox(
              heightFactor: spendingPercentageOfTotal,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
              ),
            )
          ]),
        ),
        SizedBox(height: 4),
        Text(label)
      ],
    );
  }
}
