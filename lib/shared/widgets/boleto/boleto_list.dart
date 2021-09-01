import 'package:flutter/material.dart';
import 'package:payflow/controllers/boleto_list_controller.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/widgets/boleto/boleto_tile.dart';

class BoletoList extends StatefulWidget {
  final BoletoController controller;
  final VoidCallback? callAlert;

  const BoletoList({
    required this.controller,
    this.callAlert,
  });
  @override
  _BoletoListState createState() => _BoletoListState();
}

class _BoletoListState extends State<BoletoList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BoletoModel>>(
        valueListenable: widget.controller.boletosNotifier,
        builder: (_, boletos, __) {
          return Column(
            children: boletos
                .map((e) => BoletoTile(
                      data: e,
                      onLongPress: widget.callAlert == null
                          ? () {
                              widget.controller.boleto = e;
                            }
                          : () {
                              widget.controller.boleto = e;
                              widget.callAlert!();
                            },
                    ))
                .toList(),
          );
        });
  }
}
