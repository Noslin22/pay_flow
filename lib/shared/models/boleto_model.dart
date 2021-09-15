import 'package:hive/hive.dart';
part 'boleto_model.g.dart';

@HiveType(typeId: 0)
class BoletoModel {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? dueDate;
  @HiveField(2)
  final double? value;
  @HiveField(3)
  final String? barcode;
  @HiveField(4)
  final String? email;

  BoletoModel({
    this.name,
    this.dueDate,
    this.value,
    this.barcode,
    this.email,
  });

  bool get isEmpty =>
      name == null &&
      dueDate == null &&
      value == null &&
      barcode == null &&
      email == null;

  @override
  String toString() =>
      "Name: $email, Due date: $dueDate, Value: ${value.toString()}, Barcode: $barcode, Email: $email";
}
