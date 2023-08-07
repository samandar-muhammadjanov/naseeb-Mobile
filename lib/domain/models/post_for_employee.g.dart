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
      amountMoney: fields[3] as AmountMoney,
      addressDto: fields[4] as AddressDto,
      createdDate: fields[5] as DateTime,
      updateDate: fields[6] as DateTime,
      categoryDto: fields[7] as CategoryDto,
      registerResponse: fields[8] as RegisterResponsePost,
      responseFiles: (fields[9] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Datum obj) {
    writer
      ..writeByte(10)
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
      ..write(obj.registerResponse)
      ..writeByte(9)
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

class AmountMoneyAdapter extends TypeAdapter<AmountMoney> {
  @override
  final int typeId = 2;

  @override
  AmountMoney read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AmountMoney(
      id: fields[1] as int,
      nameCode: fields[2] as String,
      money: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, AmountMoney obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.nameCode)
      ..writeByte(3)
      ..write(obj.money);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AmountMoneyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryDtoAdapter extends TypeAdapter<CategoryDto> {
  @override
  final int typeId = 3;

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

class RegisterResponsePostAdapter extends TypeAdapter<RegisterResponsePost> {
  @override
  final int typeId = 10;

  @override
  RegisterResponsePost read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegisterResponsePost(
      id: fields[0] as int,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      email: fields[3] as String,
      phone: fields[4] as String,
      active: fields[5] as String,
      roles: (fields[6] as List).cast<String>(),
      gender: fields[7] as String,
      bornYear: fields[8] as DateTime,
      description: fields[9] as String,
      address: fields[10] as AddressDto,
      responseFile: fields[11] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, RegisterResponsePost obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.active)
      ..writeByte(6)
      ..write(obj.roles)
      ..writeByte(7)
      ..write(obj.gender)
      ..writeByte(8)
      ..write(obj.bornYear)
      ..writeByte(9)
      ..write(obj.description)
      ..writeByte(10)
      ..write(obj.address)
      ..writeByte(11)
      ..write(obj.responseFile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterResponsePostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
