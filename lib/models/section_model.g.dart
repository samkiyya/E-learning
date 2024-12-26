// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SectionAdapter extends TypeAdapter<Section> {
  @override
  final int typeId = 3;

  @override
  Section read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Section(
      id: fields[0] as int,
      title: fields[1] as String,
      courseId: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Section obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.courseId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
