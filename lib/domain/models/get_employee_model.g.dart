// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_employee_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeDatumAdapter extends TypeAdapter<EmployeeDatum> {
  @override
  final int typeId = 4;

  @override
  EmployeeDatum read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeDatum(
      id: fields[0] as int,
      description: fields[1] as String,
      workType: fields[2] as String,
      languagesResponse: (fields[3] as List).cast<dynamic>(),
      experienceResponses: (fields[4] as List).cast<ExperienceResponse>(),
      educationResponse: (fields[5] as List).cast<dynamic>(),
      categoryResponse: fields[6] as CategoryResponse,
      salaryResponse: fields[7] as SalaryResponse,
      certificateFile: (fields[8] as List).cast<dynamic>(),
      sampleFile: (fields[9] as List).cast<dynamic>(),
      registerResponse: fields[10] as RegisterResponse,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeDatum obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.workType)
      ..writeByte(3)
      ..write(obj.languagesResponse)
      ..writeByte(4)
      ..write(obj.experienceResponses)
      ..writeByte(5)
      ..write(obj.educationResponse)
      ..writeByte(6)
      ..write(obj.categoryResponse)
      ..writeByte(7)
      ..write(obj.salaryResponse)
      ..writeByte(8)
      ..write(obj.certificateFile)
      ..writeByte(9)
      ..write(obj.sampleFile)
      ..writeByte(10)
      ..write(obj.registerResponse);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeDatumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryResponseAdapter extends TypeAdapter<CategoryResponse> {
  @override
  final int typeId = 5;

  @override
  CategoryResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryResponse(
      id: fields[0] as int,
      nameUz: fields[1] as String,
      nameRu: fields[2] as String,
      active: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryResponse obj) {
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
      other is CategoryResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExperienceResponseAdapter extends TypeAdapter<ExperienceResponse> {
  @override
  final int typeId = 6;

  @override
  ExperienceResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExperienceResponse(
      id: fields[0] as int,
      level: fields[1] as String,
      begin: fields[2] as DateTime,
      end: fields[3] as DateTime,
      asWho: fields[4] as String,
      company: fields[5] as String,
      description: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExperienceResponse obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.level)
      ..writeByte(2)
      ..write(obj.begin)
      ..writeByte(3)
      ..write(obj.end)
      ..writeByte(4)
      ..write(obj.asWho)
      ..writeByte(5)
      ..write(obj.company)
      ..writeByte(6)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExperienceResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RegisterResponseAdapter extends TypeAdapter<RegisterResponse> {
  @override
  final int typeId = 7;

  @override
  RegisterResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegisterResponse(
      id: fields[0] as int,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      email: fields[3] as String,
      phone: fields[4] as String,
      active: fields[5] as String,
      roles: (fields[6] as List).cast<String>(),
      gender: fields[7] as String,
      language: fields[8] as dynamic,
      bornYear: fields[9] as DateTime,
      description: fields[10] as String,
      address: fields[12] as Address,
      responseFile: fields[13] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, RegisterResponse obj) {
    writer
      ..writeByte(13)
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
      ..write(obj.language)
      ..writeByte(9)
      ..write(obj.bornYear)
      ..writeByte(10)
      ..write(obj.description)
      ..writeByte(12)
      ..write(obj.address)
      ..writeByte(13)
      ..write(obj.responseFile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AddressAdapter extends TypeAdapter<Address> {
  @override
  final int typeId = 8;

  @override
  Address read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Address(
      id: fields[0] as int,
      region: fields[1] as String,
      city: fields[2] as String,
      latitude: fields[3] as double,
      longitude: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Address obj) {
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
      other is AddressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SalaryResponseAdapter extends TypeAdapter<SalaryResponse> {
  @override
  final int typeId = 9;

  @override
  SalaryResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SalaryResponse(
      id: fields[0] as int,
      nameCode: fields[1] as String,
      money: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SalaryResponse obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nameCode)
      ..writeByte(2)
      ..write(obj.money);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalaryResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
