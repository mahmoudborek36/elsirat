// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DateModelAdapter extends TypeAdapter<DateModel> {
  @override
  final int typeId = 1;

  @override
  DateModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DateModel(
      date: fields[0] as String,
      fajr: fields[1] as String,
      sunrise: fields[2] as String?,
      dhuhr: fields[3] as String,
      asr: fields[4] as String,
      maghrib: fields[5] as String,
      isha: fields[6] as String,
      isCompelete: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DateModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.fajr)
      ..writeByte(2)
      ..write(obj.sunrise)
      ..writeByte(3)
      ..write(obj.dhuhr)
      ..writeByte(4)
      ..write(obj.asr)
      ..writeByte(5)
      ..write(obj.maghrib)
      ..writeByte(6)
      ..write(obj.isha)
      ..writeByte(7)
      ..write(obj.isCompelete);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
