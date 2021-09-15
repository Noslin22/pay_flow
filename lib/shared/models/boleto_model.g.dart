// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boleto_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BoletoModelAdapter extends TypeAdapter<BoletoModel> {
  @override
  final int typeId = 0;

  @override
  BoletoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BoletoModel(
      name: fields[0] as String?,
      dueDate: fields[1] as String?,
      value: fields[2] as double?,
      barcode: fields[3] as String?,
      email: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BoletoModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.dueDate)
      ..writeByte(2)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.barcode)
      ..writeByte(4)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoletoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
