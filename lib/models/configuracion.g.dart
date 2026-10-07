// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuracion.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetConfiguracionCollection on Isar {
  IsarCollection<Configuracion> get configuracions => this.collection();
}

const ConfiguracionSchema = CollectionSchema(
  name: r'Configuracion',
  id: 5910711714536764601,
  properties: {
    r'backupAutomatico': PropertySchema(
      id: 0,
      name: r'backupAutomatico',
      type: IsarType.bool,
    ),
    r'carpetaBackup': PropertySchema(
      id: 1,
      name: r'carpetaBackup',
      type: IsarType.string,
    ),
    r'carpetaBackupUri': PropertySchema(
      id: 2,
      name: r'carpetaBackupUri',
      type: IsarType.string,
    ),
    r'diasAnticipacion': PropertySchema(
      id: 3,
      name: r'diasAnticipacion',
      type: IsarType.long,
    ),
    r'exportarExcel': PropertySchema(
      id: 4,
      name: r'exportarExcel',
      type: IsarType.bool,
    ),
    r'exportarPdf': PropertySchema(
      id: 5,
      name: r'exportarPdf',
      type: IsarType.bool,
    ),
    r'fechaActualizacion': PropertySchema(
      id: 6,
      name: r'fechaActualizacion',
      type: IsarType.dateTime,
    ),
    r'fechaCreacion': PropertySchema(
      id: 7,
      name: r'fechaCreacion',
      type: IsarType.dateTime,
    ),
    r'frecuenciaBackup': PropertySchema(
      id: 8,
      name: r'frecuenciaBackup',
      type: IsarType.string,
      enumMap: _ConfiguracionfrecuenciaBackupEnumValueMap,
    ),
    r'horaBackup': PropertySchema(
      id: 9,
      name: r'horaBackup',
      type: IsarType.long,
    ),
    r'horaNotificacion': PropertySchema(
      id: 10,
      name: r'horaNotificacion',
      type: IsarType.long,
    ),
    r'maximoBackups': PropertySchema(
      id: 11,
      name: r'maximoBackups',
      type: IsarType.long,
    ),
    r'minutoBackup': PropertySchema(
      id: 12,
      name: r'minutoBackup',
      type: IsarType.long,
    ),
    r'minutoNotificacion': PropertySchema(
      id: 13,
      name: r'minutoNotificacion',
      type: IsarType.long,
    ),
    r'notificacionesActivas': PropertySchema(
      id: 14,
      name: r'notificacionesActivas',
      type: IsarType.bool,
    ),
    r'notificarDeudasVencidas': PropertySchema(
      id: 15,
      name: r'notificarDeudasVencidas',
      type: IsarType.bool,
    ),
    r'notificarPagosPendientes': PropertySchema(
      id: 16,
      name: r'notificarPagosPendientes',
      type: IsarType.bool,
    ),
    r'primeraEjecucion': PropertySchema(
      id: 17,
      name: r'primeraEjecucion',
      type: IsarType.bool,
    ),
    r'siguienteNumeroDeuda': PropertySchema(
      id: 18,
      name: r'siguienteNumeroDeuda',
      type: IsarType.long,
    ),
    r'siguienteNumeroPago': PropertySchema(
      id: 19,
      name: r'siguienteNumeroPago',
      type: IsarType.long,
    ),
    r'temaOscuro': PropertySchema(
      id: 20,
      name: r'temaOscuro',
      type: IsarType.bool,
    ),
    r'ultimoBackup': PropertySchema(
      id: 21,
      name: r'ultimoBackup',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _configuracionEstimateSize,
  serialize: _configuracionSerialize,
  deserialize: _configuracionDeserialize,
  deserializeProp: _configuracionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _configuracionGetId,
  getLinks: _configuracionGetLinks,
  attach: _configuracionAttach,
  version: '3.1.0+1',
);

int _configuracionEstimateSize(
  Configuracion object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.carpetaBackup;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.carpetaBackupUri;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.frecuenciaBackup.name.length * 3;
  return bytesCount;
}

void _configuracionSerialize(
  Configuracion object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.backupAutomatico);
  writer.writeString(offsets[1], object.carpetaBackup);
  writer.writeString(offsets[2], object.carpetaBackupUri);
  writer.writeLong(offsets[3], object.diasAnticipacion);
  writer.writeBool(offsets[4], object.exportarExcel);
  writer.writeBool(offsets[5], object.exportarPdf);
  writer.writeDateTime(offsets[6], object.fechaActualizacion);
  writer.writeDateTime(offsets[7], object.fechaCreacion);
  writer.writeString(offsets[8], object.frecuenciaBackup.name);
  writer.writeLong(offsets[9], object.horaBackup);
  writer.writeLong(offsets[10], object.horaNotificacion);
  writer.writeLong(offsets[11], object.maximoBackups);
  writer.writeLong(offsets[12], object.minutoBackup);
  writer.writeLong(offsets[13], object.minutoNotificacion);
  writer.writeBool(offsets[14], object.notificacionesActivas);
  writer.writeBool(offsets[15], object.notificarDeudasVencidas);
  writer.writeBool(offsets[16], object.notificarPagosPendientes);
  writer.writeBool(offsets[17], object.primeraEjecucion);
  writer.writeLong(offsets[18], object.siguienteNumeroDeuda);
  writer.writeLong(offsets[19], object.siguienteNumeroPago);
  writer.writeBool(offsets[20], object.temaOscuro);
  writer.writeDateTime(offsets[21], object.ultimoBackup);
}

Configuracion _configuracionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Configuracion();
  object.backupAutomatico = reader.readBool(offsets[0]);
  object.carpetaBackup = reader.readStringOrNull(offsets[1]);
  object.carpetaBackupUri = reader.readStringOrNull(offsets[2]);
  object.diasAnticipacion = reader.readLong(offsets[3]);
  object.exportarExcel = reader.readBool(offsets[4]);
  object.exportarPdf = reader.readBool(offsets[5]);
  object.fechaActualizacion = reader.readDateTime(offsets[6]);
  object.fechaCreacion = reader.readDateTime(offsets[7]);
  object.frecuenciaBackup = _ConfiguracionfrecuenciaBackupValueEnumMap[
          reader.readStringOrNull(offsets[8])] ??
      FrecuenciaBackup.diaria;
  object.horaBackup = reader.readLong(offsets[9]);
  object.horaNotificacion = reader.readLong(offsets[10]);
  object.id = id;
  object.maximoBackups = reader.readLong(offsets[11]);
  object.minutoBackup = reader.readLong(offsets[12]);
  object.minutoNotificacion = reader.readLong(offsets[13]);
  object.notificacionesActivas = reader.readBool(offsets[14]);
  object.notificarDeudasVencidas = reader.readBool(offsets[15]);
  object.notificarPagosPendientes = reader.readBool(offsets[16]);
  object.primeraEjecucion = reader.readBool(offsets[17]);
  object.siguienteNumeroDeuda = reader.readLong(offsets[18]);
  object.siguienteNumeroPago = reader.readLong(offsets[19]);
  object.temaOscuro = reader.readBool(offsets[20]);
  object.ultimoBackup = reader.readDateTimeOrNull(offsets[21]);
  return object;
}

P _configuracionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    case 8:
      return (_ConfiguracionfrecuenciaBackupValueEnumMap[
              reader.readStringOrNull(offset)] ??
          FrecuenciaBackup.diaria) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    case 14:
      return (reader.readBool(offset)) as P;
    case 15:
      return (reader.readBool(offset)) as P;
    case 16:
      return (reader.readBool(offset)) as P;
    case 17:
      return (reader.readBool(offset)) as P;
    case 18:
      return (reader.readLong(offset)) as P;
    case 19:
      return (reader.readLong(offset)) as P;
    case 20:
      return (reader.readBool(offset)) as P;
    case 21:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ConfiguracionfrecuenciaBackupEnumValueMap = {
  r'diaria': r'diaria',
  r'semanal': r'semanal',
  r'mensual': r'mensual',
};
const _ConfiguracionfrecuenciaBackupValueEnumMap = {
  r'diaria': FrecuenciaBackup.diaria,
  r'semanal': FrecuenciaBackup.semanal,
  r'mensual': FrecuenciaBackup.mensual,
};

Id _configuracionGetId(Configuracion object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _configuracionGetLinks(Configuracion object) {
  return [];
}

void _configuracionAttach(
    IsarCollection<dynamic> col, Id id, Configuracion object) {
  object.id = id;
}

extension ConfiguracionQueryWhereSort
    on QueryBuilder<Configuracion, Configuracion, QWhere> {
  QueryBuilder<Configuracion, Configuracion, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ConfiguracionQueryWhere
    on QueryBuilder<Configuracion, Configuracion, QWhereClause> {
  QueryBuilder<Configuracion, Configuracion, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ConfiguracionQueryFilter
    on QueryBuilder<Configuracion, Configuracion, QFilterCondition> {
  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      backupAutomaticoEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'backupAutomatico',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'carpetaBackup',
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'carpetaBackup',
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carpetaBackup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'carpetaBackup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'carpetaBackup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'carpetaBackup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'carpetaBackup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'carpetaBackup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'carpetaBackup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'carpetaBackup',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carpetaBackup',
        value: '',
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'carpetaBackup',
        value: '',
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupUriIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'carpetaBackupUri',
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupUriIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'carpetaBackupUri',
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupUriEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carpetaBackupUri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupUriGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'carpetaBackupUri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupUriLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'carpetaBackupUri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupUriBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'carpetaBackupUri',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupUriStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'carpetaBackupUri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupUriEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'carpetaBackupUri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupUriContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'carpetaBackupUri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupUriMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'carpetaBackupUri',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupUriIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carpetaBackupUri',
        value: '',
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      carpetaBackupUriIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'carpetaBackupUri',
        value: '',
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      diasAnticipacionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diasAnticipacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      diasAnticipacionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'diasAnticipacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      diasAnticipacionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'diasAnticipacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      diasAnticipacionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'diasAnticipacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      exportarExcelEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exportarExcel',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      exportarPdfEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exportarPdf',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      fechaActualizacionEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaActualizacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      fechaActualizacionGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaActualizacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      fechaActualizacionLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaActualizacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      fechaActualizacionBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaActualizacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      fechaCreacionEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaCreacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      fechaCreacionGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaCreacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      fechaCreacionLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaCreacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      fechaCreacionBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaCreacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      frecuenciaBackupEqualTo(
    FrecuenciaBackup value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frecuenciaBackup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      frecuenciaBackupGreaterThan(
    FrecuenciaBackup value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frecuenciaBackup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      frecuenciaBackupLessThan(
    FrecuenciaBackup value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frecuenciaBackup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      frecuenciaBackupBetween(
    FrecuenciaBackup lower,
    FrecuenciaBackup upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frecuenciaBackup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      frecuenciaBackupStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'frecuenciaBackup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      frecuenciaBackupEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'frecuenciaBackup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      frecuenciaBackupContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'frecuenciaBackup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      frecuenciaBackupMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'frecuenciaBackup',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      frecuenciaBackupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frecuenciaBackup',
        value: '',
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      frecuenciaBackupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'frecuenciaBackup',
        value: '',
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      horaBackupEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'horaBackup',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      horaBackupGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'horaBackup',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      horaBackupLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'horaBackup',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      horaBackupBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'horaBackup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      horaNotificacionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'horaNotificacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      horaNotificacionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'horaNotificacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      horaNotificacionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'horaNotificacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      horaNotificacionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'horaNotificacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      maximoBackupsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maximoBackups',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      maximoBackupsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maximoBackups',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      maximoBackupsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maximoBackups',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      maximoBackupsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maximoBackups',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      minutoBackupEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minutoBackup',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      minutoBackupGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minutoBackup',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      minutoBackupLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minutoBackup',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      minutoBackupBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minutoBackup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      minutoNotificacionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minutoNotificacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      minutoNotificacionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minutoNotificacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      minutoNotificacionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minutoNotificacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      minutoNotificacionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minutoNotificacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      notificacionesActivasEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificacionesActivas',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      notificarDeudasVencidasEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificarDeudasVencidas',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      notificarPagosPendientesEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificarPagosPendientes',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      primeraEjecucionEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primeraEjecucion',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      siguienteNumeroDeudaEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'siguienteNumeroDeuda',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      siguienteNumeroDeudaGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'siguienteNumeroDeuda',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      siguienteNumeroDeudaLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'siguienteNumeroDeuda',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      siguienteNumeroDeudaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'siguienteNumeroDeuda',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      siguienteNumeroPagoEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'siguienteNumeroPago',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      siguienteNumeroPagoGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'siguienteNumeroPago',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      siguienteNumeroPagoLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'siguienteNumeroPago',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      siguienteNumeroPagoBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'siguienteNumeroPago',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      temaOscuroEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'temaOscuro',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      ultimoBackupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ultimoBackup',
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      ultimoBackupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ultimoBackup',
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      ultimoBackupEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ultimoBackup',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      ultimoBackupGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ultimoBackup',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      ultimoBackupLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ultimoBackup',
        value: value,
      ));
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
      ultimoBackupBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ultimoBackup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ConfiguracionQueryObject
    on QueryBuilder<Configuracion, Configuracion, QFilterCondition> {}

extension ConfiguracionQueryLinks
    on QueryBuilder<Configuracion, Configuracion, QFilterCondition> {}

extension ConfiguracionQuerySortBy
    on QueryBuilder<Configuracion, Configuracion, QSortBy> {
  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByBackupAutomatico() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backupAutomatico', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByBackupAutomaticoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backupAutomatico', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByCarpetaBackup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carpetaBackup', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByCarpetaBackupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carpetaBackup', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByCarpetaBackupUri() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carpetaBackupUri', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByCarpetaBackupUriDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carpetaBackupUri', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByDiasAnticipacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diasAnticipacion', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByDiasAnticipacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diasAnticipacion', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByExportarExcel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportarExcel', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByExportarExcelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportarExcel', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy> sortByExportarPdf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportarPdf', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByExportarPdfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportarPdf', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByFechaActualizacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByFechaActualizacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByFechaCreacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByFrecuenciaBackup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecuenciaBackup', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByFrecuenciaBackupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecuenciaBackup', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy> sortByHoraBackup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaBackup', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByHoraBackupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaBackup', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByHoraNotificacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaNotificacion', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByHoraNotificacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaNotificacion', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByMaximoBackups() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maximoBackups', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByMaximoBackupsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maximoBackups', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByMinutoBackup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minutoBackup', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByMinutoBackupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minutoBackup', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByMinutoNotificacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minutoNotificacion', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByMinutoNotificacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minutoNotificacion', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByNotificacionesActivas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificacionesActivas', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByNotificacionesActivasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificacionesActivas', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByNotificarDeudasVencidas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificarDeudasVencidas', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByNotificarDeudasVencidasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificarDeudasVencidas', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByNotificarPagosPendientes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificarPagosPendientes', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByNotificarPagosPendientesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificarPagosPendientes', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByPrimeraEjecucion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primeraEjecucion', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByPrimeraEjecucionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primeraEjecucion', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortBySiguienteNumeroDeuda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteNumeroDeuda', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortBySiguienteNumeroDeudaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteNumeroDeuda', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortBySiguienteNumeroPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteNumeroPago', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortBySiguienteNumeroPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteNumeroPago', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy> sortByTemaOscuro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temaOscuro', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByTemaOscuroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temaOscuro', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByUltimoBackup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ultimoBackup', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      sortByUltimoBackupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ultimoBackup', Sort.desc);
    });
  }
}

extension ConfiguracionQuerySortThenBy
    on QueryBuilder<Configuracion, Configuracion, QSortThenBy> {
  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByBackupAutomatico() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backupAutomatico', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByBackupAutomaticoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backupAutomatico', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByCarpetaBackup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carpetaBackup', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByCarpetaBackupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carpetaBackup', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByCarpetaBackupUri() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carpetaBackupUri', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByCarpetaBackupUriDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carpetaBackupUri', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByDiasAnticipacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diasAnticipacion', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByDiasAnticipacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diasAnticipacion', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByExportarExcel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportarExcel', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByExportarExcelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportarExcel', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy> thenByExportarPdf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportarPdf', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByExportarPdfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportarPdf', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByFechaActualizacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByFechaActualizacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByFechaCreacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByFrecuenciaBackup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecuenciaBackup', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByFrecuenciaBackupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecuenciaBackup', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy> thenByHoraBackup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaBackup', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByHoraBackupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaBackup', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByHoraNotificacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaNotificacion', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByHoraNotificacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaNotificacion', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByMaximoBackups() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maximoBackups', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByMaximoBackupsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maximoBackups', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByMinutoBackup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minutoBackup', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByMinutoBackupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minutoBackup', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByMinutoNotificacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minutoNotificacion', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByMinutoNotificacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minutoNotificacion', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByNotificacionesActivas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificacionesActivas', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByNotificacionesActivasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificacionesActivas', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByNotificarDeudasVencidas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificarDeudasVencidas', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByNotificarDeudasVencidasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificarDeudasVencidas', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByNotificarPagosPendientes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificarPagosPendientes', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByNotificarPagosPendientesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificarPagosPendientes', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByPrimeraEjecucion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primeraEjecucion', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByPrimeraEjecucionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primeraEjecucion', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenBySiguienteNumeroDeuda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteNumeroDeuda', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenBySiguienteNumeroDeudaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteNumeroDeuda', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenBySiguienteNumeroPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteNumeroPago', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenBySiguienteNumeroPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteNumeroPago', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy> thenByTemaOscuro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temaOscuro', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByTemaOscuroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temaOscuro', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByUltimoBackup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ultimoBackup', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
      thenByUltimoBackupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ultimoBackup', Sort.desc);
    });
  }
}

extension ConfiguracionQueryWhereDistinct
    on QueryBuilder<Configuracion, Configuracion, QDistinct> {
  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctByBackupAutomatico() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'backupAutomatico');
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct> distinctByCarpetaBackup(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carpetaBackup',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctByCarpetaBackupUri({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carpetaBackupUri',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctByDiasAnticipacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diasAnticipacion');
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctByExportarExcel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exportarExcel');
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctByExportarPdf() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exportarPdf');
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctByFechaActualizacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaActualizacion');
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaCreacion');
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctByFrecuenciaBackup({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frecuenciaBackup',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct> distinctByHoraBackup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'horaBackup');
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctByHoraNotificacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'horaNotificacion');
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctByMaximoBackups() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maximoBackups');
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctByMinutoBackup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minutoBackup');
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctByMinutoNotificacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minutoNotificacion');
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctByNotificacionesActivas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificacionesActivas');
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctByNotificarDeudasVencidas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificarDeudasVencidas');
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctByNotificarPagosPendientes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificarPagosPendientes');
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctByPrimeraEjecucion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'primeraEjecucion');
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctBySiguienteNumeroDeuda() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'siguienteNumeroDeuda');
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctBySiguienteNumeroPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'siguienteNumeroPago');
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct> distinctByTemaOscuro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'temaOscuro');
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
      distinctByUltimoBackup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ultimoBackup');
    });
  }
}

extension ConfiguracionQueryProperty
    on QueryBuilder<Configuracion, Configuracion, QQueryProperty> {
  QueryBuilder<Configuracion, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Configuracion, bool, QQueryOperations>
      backupAutomaticoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'backupAutomatico');
    });
  }

  QueryBuilder<Configuracion, String?, QQueryOperations>
      carpetaBackupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carpetaBackup');
    });
  }

  QueryBuilder<Configuracion, String?, QQueryOperations>
      carpetaBackupUriProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carpetaBackupUri');
    });
  }

  QueryBuilder<Configuracion, int, QQueryOperations>
      diasAnticipacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diasAnticipacion');
    });
  }

  QueryBuilder<Configuracion, bool, QQueryOperations> exportarExcelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exportarExcel');
    });
  }

  QueryBuilder<Configuracion, bool, QQueryOperations> exportarPdfProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exportarPdf');
    });
  }

  QueryBuilder<Configuracion, DateTime, QQueryOperations>
      fechaActualizacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaActualizacion');
    });
  }

  QueryBuilder<Configuracion, DateTime, QQueryOperations>
      fechaCreacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaCreacion');
    });
  }

  QueryBuilder<Configuracion, FrecuenciaBackup, QQueryOperations>
      frecuenciaBackupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frecuenciaBackup');
    });
  }

  QueryBuilder<Configuracion, int, QQueryOperations> horaBackupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'horaBackup');
    });
  }

  QueryBuilder<Configuracion, int, QQueryOperations>
      horaNotificacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'horaNotificacion');
    });
  }

  QueryBuilder<Configuracion, int, QQueryOperations> maximoBackupsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maximoBackups');
    });
  }

  QueryBuilder<Configuracion, int, QQueryOperations> minutoBackupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minutoBackup');
    });
  }

  QueryBuilder<Configuracion, int, QQueryOperations>
      minutoNotificacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minutoNotificacion');
    });
  }

  QueryBuilder<Configuracion, bool, QQueryOperations>
      notificacionesActivasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificacionesActivas');
    });
  }

  QueryBuilder<Configuracion, bool, QQueryOperations>
      notificarDeudasVencidasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificarDeudasVencidas');
    });
  }

  QueryBuilder<Configuracion, bool, QQueryOperations>
      notificarPagosPendientesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificarPagosPendientes');
    });
  }

  QueryBuilder<Configuracion, bool, QQueryOperations>
      primeraEjecucionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'primeraEjecucion');
    });
  }

  QueryBuilder<Configuracion, int, QQueryOperations>
      siguienteNumeroDeudaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'siguienteNumeroDeuda');
    });
  }

  QueryBuilder<Configuracion, int, QQueryOperations>
      siguienteNumeroPagoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'siguienteNumeroPago');
    });
  }

  QueryBuilder<Configuracion, bool, QQueryOperations> temaOscuroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'temaOscuro');
    });
  }

  QueryBuilder<Configuracion, DateTime?, QQueryOperations>
      ultimoBackupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ultimoBackup');
    });
  }
}
