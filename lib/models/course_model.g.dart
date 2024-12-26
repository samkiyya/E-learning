// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseAdapter extends TypeAdapter<Course> {
  @override
  final int typeId = 0;

  @override
  Course read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Course(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      language: fields[3] as String,
      thumbnail: fields[4] as String?,
      categoryId: fields[5] as int,
      price: fields[6] as double,
      outcomes: (fields[7] as Map).cast<String, String>(),
      section: fields[8] as String,
      requirements: (fields[9] as Map).cast<String, String>(),
      discountFlag: fields[10] as bool,
      discountedPrice: fields[11] as double,
      courseType: fields[12] as String,
      isTopCourse: fields[13] as bool,
      status: fields[14] as String,
      pdf: fields[15] as String?,
      videoUrl: fields[16] as String?,
      isFreeCourse: fields[17] as bool,
      createdAt: fields[18] as DateTime,
      updatedAt: fields[19] as DateTime,
      category: fields[20] as Category,
    );
  }

  @override
  void write(BinaryWriter writer, Course obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.language)
      ..writeByte(4)
      ..write(obj.thumbnail)
      ..writeByte(5)
      ..write(obj.categoryId)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.outcomes)
      ..writeByte(8)
      ..write(obj.section)
      ..writeByte(9)
      ..write(obj.requirements)
      ..writeByte(10)
      ..write(obj.discountFlag)
      ..writeByte(11)
      ..write(obj.discountedPrice)
      ..writeByte(12)
      ..write(obj.courseType)
      ..writeByte(13)
      ..write(obj.isTopCourse)
      ..writeByte(14)
      ..write(obj.status)
      ..writeByte(15)
      ..write(obj.pdf)
      ..writeByte(16)
      ..write(obj.videoUrl)
      ..writeByte(17)
      ..write(obj.isFreeCourse)
      ..writeByte(18)
      ..write(obj.createdAt)
      ..writeByte(19)
      ..write(obj.updatedAt)
      ..writeByte(20)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 1;

  @override
  Category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category(
      id: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
