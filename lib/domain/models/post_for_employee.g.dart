// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_for_employee.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DatumAdapter extends TypeAdapter<Datum> {
  @override
  final int typeId = 0;

  @override
  Datum read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Datum(
      id: fields[0] as int,
      description: fields[1] as String,
      fixedTime: fields[2] as DateTime,
      amountMoney: fields[3] as double,
      addressDto: fields[4] as AddressDto,
      createdDate: fields[5] as DateTime,
      updateDate: fields[6] as DateTime,
      categoryDto: fields[7] as CategoryDto,
      responseFiles: (fields[8] as List).cast<ResponseFile>(),
    );
  }

  @override
  void write(BinaryWriter writer, Datum obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.fixedTime)
      ..writeByte(3)
      ..write(obj.amountMoney)
      ..writeByte(4)
      ..write(obj.addressDto)
      ..writeByte(5)
      ..write(obj.createdDate)
      ..writeByte(6)
      ..write(obj.updateDate)
      ..writeByte(7)
      ..write(obj.categoryDto)
      ..writeByte(8)
      ..write(obj.responseFiles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AddressDtoAdapter extends TypeAdapter<AddressDto> {
  @override
  final int typeId = 1;

  @override
  AddressDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddressDto(
      id: fields[0] as int,
      region: fields[1] as String,
      city: fields[2] as String,
      latitude: fields[3] as double,
      longitude: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, AddressDto obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.region)
      ..writeByte(2)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryDtoAdapter extends TypeAdapter<CategoryDto> {
  @override
  final int typeId = 2;

  @override
  CategoryDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryDto(
      id: fields[0] as int,
      nameUz: fields[1] as String,
      nameRu: fields[2] as String,
      active: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryDto obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nameUz)
      ..writeByte(2)
      ..write(obj.nameRu)
      ..writeByte(3)
      ..write(obj.active);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ResponseFileAdapter extends TypeAdapter<ResponseFile> {
  @override
  final int typeId = 3;

  @override
  ResponseFile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResponseFile(
      name: fields[0] as String,
      url: fields[1] as String,
      type: fields[2] as String,
      size: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ResponseFile obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.size);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseFileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
