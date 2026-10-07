// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respaldo.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRespaldoCollection on Isar {
  IsarCollection<Respaldo> get respaldos => this.collection();
}

const RespaldoSchema = CollectionSchema(
  name: r'Respaldo',
  id: 408221595656152626,
  properties: {
    r'cantidadClientes': PropertySchema(
      id: 0,
      name: r'cantidadClientes',
      type: IsarType.long,
    ),
    r'cantidadDeudas': PropertySchema(
      id: 1,
      name: r'cantidadDeudas',
      type: IsarType.long,
    ),
    r'cantidadPagos': PropertySchema(
      id: 2,
      name: r'cantidadPagos',
      type: IsarType.long,
    ),
    r'duracionMs': PropertySchema(
      id: 3,
      name: r'duracionMs',
      type: IsarType.long,
    ),
    r'estado': PropertySchema(
      id: 4,
      name: r'estado',
      type: IsarType.string,
      enumMap: _RespaldoestadoEnumValueMap,
    ),
    r'fecha': PropertySchema(
      id: 5,
      name: r'fecha',
      type: IsarType.dateTime,
    ),
    r'nombreArchivo': PropertySchema(
      id: 6,
      name: r'nombreArchivo',
      type: IsarType.string,
    ),
    r'observacion': PropertySchema(
      id: 7,
      name: r'observacion',
      type: IsarType.string,
    ),
    r'rutaArchivo': PropertySchema(
      id: 8,
      name: r'rutaArchivo',
      type: IsarType.string,
    ),
    r'tamanoBytes': PropertySchema(
      id: 9,
      name: r'tamanoBytes',
      type: IsarType.long,
    ),
    r'tipo': PropertySchema(
      id: 10,
      name: r'tipo',
      type: IsarType.string,
      enumMap: _RespaldotipoEnumValueMap,
    ),
    r'uuid': PropertySchema(
      id: 11,
      name: r'uuid',
      type: IsarType.string,
    ),
    r'versionAplicacion': PropertySchema(
      id: 12,
      name: r'versionAplicacion',
      type: IsarType.string,
    )
  },
  estimateSize: _respaldoEstimateSize,
  serialize: _respaldoSerialize,
  deserialize: _respaldoDeserialize,
  deserializeProp: _respaldoDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: 2134397340427724972,
      name: r'uuid',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _respaldoGetId,
  getLinks: _respaldoGetLinks,
  attach: _respaldoAttach,
  version: '3.1.0+1',
);

int _respaldoEstimateSize(
  Respaldo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.estado.name.length * 3;
  bytesCount += 3 + object.nombreArchivo.length * 3;
  {
    final value = object.observacion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.rutaArchivo.length * 3;
  bytesCount += 3 + object.tipo.name.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  bytesCount += 3 + object.versionAplicacion.length * 3;
  return bytesCount;
}

void _respaldoSerialize(
  Respaldo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.cantidadClientes);
  writer.writeLong(offsets[1], object.cantidadDeudas);
  writer.writeLong(offsets[2], object.cantidadPagos);
  writer.writeLong(offsets[3], object.duracionMs);
  writer.writeString(offsets[4], object.estado.name);
  writer.writeDateTime(offsets[5], object.fecha);
  writer.writeString(offsets[6], object.nombreArchivo);
  writer.writeString(offsets[7], object.observacion);
  writer.writeString(offsets[8], object.rutaArchivo);
  writer.writeLong(offsets[9], object.tamanoBytes);
  writer.writeString(offsets[10], object.tipo.name);
  writer.writeString(offsets[11], object.uuid);
  writer.writeString(offsets[12], object.versionAplicacion);
}

Respaldo _respaldoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Respaldo();
  object.cantidadClientes = reader.readLong(offsets[0]);
  object.cantidadDeudas = reader.readLong(offsets[1]);
  object.cantidadPagos = reader.readLong(offsets[2]);
  object.duracionMs = reader.readLong(offsets[3]);
  object.estado =
      _RespaldoestadoValueEnumMap[reader.readStringOrNull(offsets[4])] ??
          EstadoRespaldo.exitoso;
  object.fecha = reader.readDateTime(offsets[5]);
  object.id = id;
  object.nombreArchivo = reader.readString(offsets[6]);
  object.observacion = reader.readStringOrNull(offsets[7]);
  object.rutaArchivo = reader.readString(offsets[8]);
  object.tamanoBytes = reader.readLong(offsets[9]);
  object.tipo =
      _RespaldotipoValueEnumMap[reader.readStringOrNull(offsets[10])] ??
          TipoRespaldo.manual;
  object.uuid = reader.readString(offsets[11]);
  object.versionAplicacion = reader.readString(offsets[12]);
  return object;
}

P _respaldoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (_RespaldoestadoValueEnumMap[reader.readStringOrNull(offset)] ??
          EstadoRespaldo.exitoso) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (_RespaldotipoValueEnumMap[reader.readStringOrNull(offset)] ??
          TipoRespaldo.manual) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _RespaldoestadoEnumValueMap = {
  r'exitoso': r'exitoso',
  r'error': r'error',
};
const _RespaldoestadoValueEnumMap = {
  r'exitoso': EstadoRespaldo.exitoso,
  r'error': EstadoRespaldo.error,
};
const _RespaldotipoEnumValueMap = {
  r'manual': r'manual',
  r'automatico': r'automatico',
  r'restauracion': r'restauracion',
};
const _RespaldotipoValueEnumMap = {
  r'manual': TipoRespaldo.manual,
  r'automatico': TipoRespaldo.automatico,
  r'restauracion': TipoRespaldo.restauracion,
};

Id _respaldoGetId(Respaldo object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _respaldoGetLinks(Respaldo object) {
  return [];
}

void _respaldoAttach(IsarCollection<dynamic> col, Id id, Respaldo object) {
  object.id = id;
}

extension RespaldoByIndex on IsarCollection<Respaldo> {
  Future<Respaldo?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  Respaldo? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<Respaldo?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<Respaldo?> getAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uuid', values);
  }

  Future<int> deleteAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uuid', values);
  }

  int deleteAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uuid', values);
  }

  Future<Id> putByUuid(Respaldo object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(Respaldo object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<Respaldo> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<Respaldo> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension RespaldoQueryWhereSort on QueryBuilder<Respaldo, Respaldo, QWhere> {
  QueryBuilder<Respaldo, Respaldo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RespaldoQueryWhere on QueryBuilder<Respaldo, Respaldo, QWhereClause> {
  QueryBuilder<Respaldo, Respaldo, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Respaldo, Respaldo, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterWhereClause> idBetween(
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

  QueryBuilder<Respaldo, Respaldo, QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterWhereClause> uuidNotEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ));
      }
    });
  }
}

extension RespaldoQueryFilter
    on QueryBuilder<Respaldo, Respaldo, QFilterCondition> {
  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      cantidadClientesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantidadClientes',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      cantidadClientesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantidadClientes',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      cantidadClientesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantidadClientes',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      cantidadClientesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantidadClientes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> cantidadDeudasEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantidadDeudas',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      cantidadDeudasGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantidadDeudas',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      cantidadDeudasLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantidadDeudas',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> cantidadDeudasBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantidadDeudas',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> cantidadPagosEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantidadPagos',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      cantidadPagosGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantidadPagos',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> cantidadPagosLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantidadPagos',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> cantidadPagosBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantidadPagos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> duracionMsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duracionMs',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> duracionMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duracionMs',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> duracionMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duracionMs',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> duracionMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duracionMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> estadoEqualTo(
    EstadoRespaldo value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> estadoGreaterThan(
    EstadoRespaldo value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> estadoLessThan(
    EstadoRespaldo value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> estadoBetween(
    EstadoRespaldo lower,
    EstadoRespaldo upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estado',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> estadoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> estadoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> estadoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> estadoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'estado',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> estadoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estado',
        value: '',
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> estadoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'estado',
        value: '',
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> fechaEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> fechaGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> fechaLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> fechaBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fecha',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> nombreArchivoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombreArchivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      nombreArchivoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nombreArchivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> nombreArchivoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nombreArchivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> nombreArchivoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nombreArchivo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      nombreArchivoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nombreArchivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> nombreArchivoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nombreArchivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> nombreArchivoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombreArchivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> nombreArchivoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombreArchivo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      nombreArchivoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombreArchivo',
        value: '',
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      nombreArchivoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombreArchivo',
        value: '',
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> observacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'observacion',
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      observacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'observacion',
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> observacionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'observacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      observacionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'observacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> observacionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'observacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> observacionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'observacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> observacionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'observacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> observacionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'observacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> observacionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'observacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> observacionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'observacion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> observacionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'observacion',
        value: '',
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      observacionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'observacion',
        value: '',
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> rutaArchivoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rutaArchivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      rutaArchivoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rutaArchivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> rutaArchivoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rutaArchivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> rutaArchivoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rutaArchivo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> rutaArchivoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rutaArchivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> rutaArchivoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rutaArchivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> rutaArchivoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rutaArchivo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> rutaArchivoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rutaArchivo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> rutaArchivoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rutaArchivo',
        value: '',
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      rutaArchivoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rutaArchivo',
        value: '',
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> tamanoBytesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tamanoBytes',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      tamanoBytesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tamanoBytes',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> tamanoBytesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tamanoBytes',
        value: value,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> tamanoBytesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tamanoBytes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> tipoEqualTo(
    TipoRespaldo value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> tipoGreaterThan(
    TipoRespaldo value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> tipoLessThan(
    TipoRespaldo value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> tipoBetween(
    TipoRespaldo lower,
    TipoRespaldo upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> tipoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> tipoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> tipoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> tipoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> tipoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipo',
        value: '',
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> tipoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipo',
        value: '',
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> uuidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> uuidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      versionAplicacionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionAplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      versionAplicacionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'versionAplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      versionAplicacionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'versionAplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      versionAplicacionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'versionAplicacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      versionAplicacionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'versionAplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      versionAplicacionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'versionAplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      versionAplicacionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'versionAplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      versionAplicacionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'versionAplicacion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      versionAplicacionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionAplicacion',
        value: '',
      ));
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterFilterCondition>
      versionAplicacionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'versionAplicacion',
        value: '',
      ));
    });
  }
}

extension RespaldoQueryObject
    on QueryBuilder<Respaldo, Respaldo, QFilterCondition> {}

extension RespaldoQueryLinks
    on QueryBuilder<Respaldo, Respaldo, QFilterCondition> {}

extension RespaldoQuerySortBy on QueryBuilder<Respaldo, Respaldo, QSortBy> {
  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByCantidadClientes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadClientes', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByCantidadClientesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadClientes', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByCantidadDeudas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadDeudas', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByCantidadDeudasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadDeudas', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByCantidadPagos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadPagos', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByCantidadPagosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadPagos', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByDuracionMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionMs', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByDuracionMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionMs', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByNombreArchivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreArchivo', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByNombreArchivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreArchivo', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByObservacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacion', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByObservacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacion', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByRutaArchivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rutaArchivo', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByRutaArchivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rutaArchivo', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByTamanoBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tamanoBytes', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByTamanoBytesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tamanoBytes', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByTipoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByVersionAplicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionAplicacion', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> sortByVersionAplicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionAplicacion', Sort.desc);
    });
  }
}

extension RespaldoQuerySortThenBy
    on QueryBuilder<Respaldo, Respaldo, QSortThenBy> {
  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByCantidadClientes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadClientes', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByCantidadClientesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadClientes', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByCantidadDeudas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadDeudas', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByCantidadDeudasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadDeudas', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByCantidadPagos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadPagos', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByCantidadPagosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadPagos', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByDuracionMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionMs', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByDuracionMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionMs', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByNombreArchivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreArchivo', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByNombreArchivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreArchivo', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByObservacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacion', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByObservacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacion', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByRutaArchivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rutaArchivo', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByRutaArchivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rutaArchivo', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByTamanoBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tamanoBytes', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByTamanoBytesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tamanoBytes', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByTipoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByVersionAplicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionAplicacion', Sort.asc);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QAfterSortBy> thenByVersionAplicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionAplicacion', Sort.desc);
    });
  }
}

extension RespaldoQueryWhereDistinct
    on QueryBuilder<Respaldo, Respaldo, QDistinct> {
  QueryBuilder<Respaldo, Respaldo, QDistinct> distinctByCantidadClientes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cantidadClientes');
    });
  }

  QueryBuilder<Respaldo, Respaldo, QDistinct> distinctByCantidadDeudas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cantidadDeudas');
    });
  }

  QueryBuilder<Respaldo, Respaldo, QDistinct> distinctByCantidadPagos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cantidadPagos');
    });
  }

  QueryBuilder<Respaldo, Respaldo, QDistinct> distinctByDuracionMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duracionMs');
    });
  }

  QueryBuilder<Respaldo, Respaldo, QDistinct> distinctByEstado(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estado', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QDistinct> distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<Respaldo, Respaldo, QDistinct> distinctByNombreArchivo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombreArchivo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QDistinct> distinctByObservacion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'observacion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QDistinct> distinctByRutaArchivo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rutaArchivo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QDistinct> distinctByTamanoBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tamanoBytes');
    });
  }

  QueryBuilder<Respaldo, Respaldo, QDistinct> distinctByTipo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Respaldo, Respaldo, QDistinct> distinctByVersionAplicacion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'versionAplicacion',
          caseSensitive: caseSensitive);
    });
  }
}

extension RespaldoQueryProperty
    on QueryBuilder<Respaldo, Respaldo, QQueryProperty> {
  QueryBuilder<Respaldo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Respaldo, int, QQueryOperations> cantidadClientesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantidadClientes');
    });
  }

  QueryBuilder<Respaldo, int, QQueryOperations> cantidadDeudasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantidadDeudas');
    });
  }

  QueryBuilder<Respaldo, int, QQueryOperations> cantidadPagosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantidadPagos');
    });
  }

  QueryBuilder<Respaldo, int, QQueryOperations> duracionMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duracionMs');
    });
  }

  QueryBuilder<Respaldo, EstadoRespaldo, QQueryOperations> estadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estado');
    });
  }

  QueryBuilder<Respaldo, DateTime, QQueryOperations> fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<Respaldo, String, QQueryOperations> nombreArchivoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombreArchivo');
    });
  }

  QueryBuilder<Respaldo, String?, QQueryOperations> observacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'observacion');
    });
  }

  QueryBuilder<Respaldo, String, QQueryOperations> rutaArchivoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rutaArchivo');
    });
  }

  QueryBuilder<Respaldo, int, QQueryOperations> tamanoBytesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tamanoBytes');
    });
  }

  QueryBuilder<Respaldo, TipoRespaldo, QQueryOperations> tipoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipo');
    });
  }

  QueryBuilder<Respaldo, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }

  QueryBuilder<Respaldo, String, QQueryOperations> versionAplicacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'versionAplicacion');
    });
  }
}
