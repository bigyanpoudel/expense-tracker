import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingAmountPercentage;
  ChartBar(this.label, this.spendingAmount, this.spendingAmountPercentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrain) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //make child to fits to the default assign width or height does not allow to grow or it shrinks
          Container(
              height: constrain.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
          SizedBox(
            height: constrain.maxHeight * 0.05,
          ),
          Container(
            height: constrain.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Color.fromRGBO(165, 165, 165, .3),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingAmountPercentage,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constrain.maxHeight * 0.05,
          ),
          Container(height: constrain.maxHeight*0.15,child: FittedBox(child: Text(label))),
        ],
      );
    });
  }
}
