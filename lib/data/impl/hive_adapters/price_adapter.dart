import 'package:afisha/=models=/price.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class PriceAdapter extends TypeAdapter<Price> with EquatableMixin {
  @override
  final int typeId = 1;

  @override
  Price read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Price(
      minValue: fields[0] as double,
      value: fields[1] as double,
      maxValue: fields[2] as double,
      currency: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Price obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.minValue)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.maxValue)
      ..writeByte(3)
      ..write(obj.currency);
  }

  @override
  List<Object?> get props => [typeId];
}
