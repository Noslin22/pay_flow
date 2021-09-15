import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import 'package:payflow_hive/shared/models/boleto_model.dart';
import 'package:payflow_hive/shared/theme.dart';

class BoletoTile extends StatelessWidget {
  final BoletoModel data;
  final VoidCallback? onLongPress;
  const BoletoTile({
    required this.data,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    String value = MoneyMaskedTextController(initialValue: data.value!).text;
    return AnimatedCard(
      direction: AnimatedCardDirection.right,
      child: ListTile(
        onLongPress: onLongPress,
        contentPadding: EdgeInsets.zero,
        title: Text(
          data.name!,
          style: TextStyles.titleListTile,
        ),
        subtitle: Text(
          'Vence em ${data.dueDate}',
          style: TextStyles.captionBody,
        ),
        trailing: Text.rich(
          TextSpan(
            text: "R\$ ",
            style: TextStyles.trailingRegular,
            children: [
              TextSpan(
                text: value,
                style: TextStyles.trailingBold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
