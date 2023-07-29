import 'package:afisha/=models=/location.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class LocationAdapter extends TypeAdapter<Location> with EquatableMixin {
  @override
  final int typeId = 2;

  @override
  Location read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Location(
      country: fields[0] as String,
      city: fields[1] as String,
      address: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Location obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.country)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.address);
  }

  @override
  List<Object?> get props => [typeId];
}
