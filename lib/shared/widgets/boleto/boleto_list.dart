import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:payflow_mobx/controllers/boleto_list_controller.dart';
import 'package:payflow_mobx/shared/widgets/boleto/boleto_tile.dart';

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
    return Observer(
        builder: (_) {
          return Column(
            children: widget.controller.boletos
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
