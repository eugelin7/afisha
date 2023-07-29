import 'package:afisha/=models=/event.dart';
import 'package:afisha/=models=/location.dart';
import 'package:afisha/=models=/price.dart';
import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

class EventAdapter extends TypeAdapter<Event> with EquatableMixin {
  @override
  final int typeId = 3;

  @override
  Event read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Event(
      id: fields[0] as String,
      creatorId: fields[1] as String,
      title: fields[2] as String,
      description: fields[3] as String,
      date: fields[4] as DateTime?,
      durationInSeconds: fields[5] as int,
      image: fields[6] as String?,
      location: fields[7] as Location,
      price: fields[8] as Price?,
      url: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Event obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.creatorId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.durationInSeconds)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.location)
      ..writeByte(8)
      ..write(obj.price)
      ..writeByte(9)
      ..write(obj.url);
  }

  @override
  List<Object?> get props => [typeId];
}
