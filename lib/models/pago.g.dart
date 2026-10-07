// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pago.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPagoCollection on Isar {
  IsarCollection<Pago> get pagos => this.collection();
}

const PagoSchema = CollectionSchema(
  name: r'Pago',
  id: 6195413862887410600,
  properties: {
    r'eliminado': PropertySchema(
      id: 0,
      name: r'eliminado',
      type: IsarType.bool,
    ),
    r'fechaActualizacion': PropertySchema(
      id: 1,
      name: r'fechaActualizacion',
      type: IsarType.dateTime,
    ),
    r'fechaPago': PropertySchema(
      id: 2,
      name: r'fechaPago',
      type: IsarType.dateTime,
    ),
    r'fechaRegistro': PropertySchema(
      id: 3,
      name: r'fechaRegistro',
      type: IsarType.dateTime,
    ),
    r'metodoPago': PropertySchema(
      id: 4,
      name: r'metodoPago',
      type: IsarType.string,
      enumMap: _PagometodoPagoEnumValueMap,
    ),
    r'numeroPago': PropertySchema(
      id: 5,
      name: r'numeroPago',
      type: IsarType.long,
    ),
    r'observacion': PropertySchema(
      id: 6,
      name: r'observacion',
      type: IsarType.string,
    ),
    r'referencia': PropertySchema(
      id: 7,
      name: r'referencia',
      type: IsarType.string,
    ),
    r'tipoPago': PropertySchema(
      id: 8,
      name: r'tipoPago',
      type: IsarType.string,
      enumMap: _PagotipoPagoEnumValueMap,
    ),
    r'uuid': PropertySchema(
      id: 9,
      name: r'uuid',
      type: IsarType.string,
    ),
    r'valor': PropertySchema(
      id: 10,
      name: r'valor',
      type: IsarType.double,
    )
  },
  estimateSize: _pagoEstimateSize,
  serialize: _pagoSerialize,
  deserialize: _pagoDeserialize,
  deserializeProp: _pagoDeserializeProp,
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
  links: {
    r'deuda': LinkSchema(
      id: 8272584257092508709,
      name: r'deuda',
      target: r'Deuda',
      single: true,
    ),
    r'interes': LinkSchema(
      id: -2484100453083547695,
      name: r'interes',
      target: r'InteresDeuda',
      single: true,
    ),
    r'cuotas': LinkSchema(
      id: -1151395737355890426,
      name: r'cuotas',
      target: r'CuotaDeuda',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _pagoGetId,
  getLinks: _pagoGetLinks,
  attach: _pagoAttach,
  version: '3.1.0+1',
);

int _pagoEstimateSize(
  Pago object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.metodoPago.name.length * 3;
  {
    final value = object.observacion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.referencia;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.tipoPago.name.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _pagoSerialize(
  Pago object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.eliminado);
  writer.writeDateTime(offsets[1], object.fechaActualizacion);
  writer.writeDateTime(offsets[2], object.fechaPago);
  writer.writeDateTime(offsets[3], object.fechaRegistro);
  writer.writeString(offsets[4], object.metodoPago.name);
  writer.writeLong(offsets[5], object.numeroPago);
  writer.writeString(offsets[6], object.observacion);
  writer.writeString(offsets[7], object.referencia);
  writer.writeString(offsets[8], object.tipoPago.name);
  writer.writeString(offsets[9], object.uuid);
  writer.writeDouble(offsets[10], object.valor);
}

Pago _pagoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Pago();
  object.eliminado = reader.readBool(offsets[0]);
  object.fechaActualizacion = reader.readDateTimeOrNull(offsets[1]);
  object.fechaPago = reader.readDateTime(offsets[2]);
  object.fechaRegistro = reader.readDateTime(offsets[3]);
  object.id = id;
  object.metodoPago =
      _PagometodoPagoValueEnumMap[reader.readStringOrNull(offsets[4])] ??
          MetodoPago.efectivo;
  object.numeroPago = reader.readLong(offsets[5]);
  object.observacion = reader.readStringOrNull(offsets[6]);
  object.referencia = reader.readStringOrNull(offsets[7]);
  object.tipoPago =
      _PagotipoPagoValueEnumMap[reader.readStringOrNull(offsets[8])] ??
          TipoPago.interes;
  object.uuid = reader.readString(offsets[9]);
  object.valor = reader.readDouble(offsets[10]);
  return object;
}

P _pagoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (_PagometodoPagoValueEnumMap[reader.readStringOrNull(offset)] ??
          MetodoPago.efectivo) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (_PagotipoPagoValueEnumMap[reader.readStringOrNull(offset)] ??
          TipoPago.interes) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PagometodoPagoEnumValueMap = {
  r'efectivo': r'efectivo',
  r'transferencia': r'transferencia',
  r'nequi': r'nequi',
  r'bancolombia': r'bancolombia',
  r'bbva': r'bbva',
  r'bancoCajaSocial': r'bancoCajaSocial',
  r'daviplata': r'daviplata',
  r'otro': r'otro',
};
const _PagometodoPagoValueEnumMap = {
  r'efectivo': MetodoPago.efectivo,
  r'transferencia': MetodoPago.transferencia,
  r'nequi': MetodoPago.nequi,
  r'bancolombia': MetodoPago.bancolombia,
  r'bbva': MetodoPago.bbva,
  r'bancoCajaSocial': MetodoPago.bancoCajaSocial,
  r'daviplata': MetodoPago.daviplata,
  r'otro': MetodoPago.otro,
};
const _PagotipoPagoEnumValueMap = {
  r'interes': r'interes',
  r'capital': r'capital',
};
const _PagotipoPagoValueEnumMap = {
  r'interes': TipoPago.interes,
  r'capital': TipoPago.capital,
};

Id _pagoGetId(Pago object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pagoGetLinks(Pago object) {
  return [object.deuda, object.interes, object.cuotas];
}

void _pagoAttach(IsarCollection<dynamic> col, Id id, Pago object) {
  object.id = id;
  object.deuda.attach(col, col.isar.collection<Deuda>(), r'deuda', id);
  object.interes
      .attach(col, col.isar.collection<InteresDeuda>(), r'interes', id);
  object.cuotas.attach(col, col.isar.collection<CuotaDeuda>(), r'cuotas', id);
}

extension PagoByIndex on IsarCollection<Pago> {
  Future<Pago?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  Pago? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<Pago?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<Pago?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(Pago object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(Pago object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<Pago> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<Pago> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension PagoQueryWhereSort on QueryBuilder<Pago, Pago, QWhere> {
  QueryBuilder<Pago, Pago, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PagoQueryWhere on QueryBuilder<Pago, Pago, QWhereClause> {
  QueryBuilder<Pago, Pago, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Pago, Pago, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Pago, Pago, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Pago, Pago, QAfterWhereClause> idBetween(
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

  QueryBuilder<Pago, Pago, QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterWhereClause> uuidNotEqualTo(String uuid) {
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

extension PagoQueryFilter on QueryBuilder<Pago, Pago, QFilterCondition> {
  QueryBuilder<Pago, Pago, QAfterFilterCondition> eliminadoEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eliminado',
        value: value,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> fechaActualizacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fechaActualizacion',
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition>
      fechaActualizacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fechaActualizacion',
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> fechaActualizacionEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaActualizacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> fechaActualizacionGreaterThan(
    DateTime? value, {
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> fechaActualizacionLessThan(
    DateTime? value, {
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> fechaActualizacionBetween(
    DateTime? lower,
    DateTime? upper, {
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> fechaPagoEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaPago',
        value: value,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> fechaPagoGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaPago',
        value: value,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> fechaPagoLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaPago',
        value: value,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> fechaPagoBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaPago',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> fechaRegistroEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaRegistro',
        value: value,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> fechaRegistroGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaRegistro',
        value: value,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> fechaRegistroLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaRegistro',
        value: value,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> fechaRegistroBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaRegistro',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> metodoPagoEqualTo(
    MetodoPago value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'metodoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> metodoPagoGreaterThan(
    MetodoPago value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'metodoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> metodoPagoLessThan(
    MetodoPago value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'metodoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> metodoPagoBetween(
    MetodoPago lower,
    MetodoPago upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'metodoPago',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> metodoPagoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'metodoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> metodoPagoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'metodoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> metodoPagoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'metodoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> metodoPagoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'metodoPago',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> metodoPagoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'metodoPago',
        value: '',
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> metodoPagoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'metodoPago',
        value: '',
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> numeroPagoEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroPago',
        value: value,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> numeroPagoGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numeroPago',
        value: value,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> numeroPagoLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numeroPago',
        value: value,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> numeroPagoBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numeroPago',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> observacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'observacion',
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> observacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'observacion',
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> observacionEqualTo(
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> observacionGreaterThan(
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> observacionLessThan(
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> observacionBetween(
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> observacionStartsWith(
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> observacionEndsWith(
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> observacionContains(
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> observacionMatches(
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> observacionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'observacion',
        value: '',
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> observacionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'observacion',
        value: '',
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> referenciaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'referencia',
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> referenciaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'referencia',
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> referenciaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'referencia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> referenciaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'referencia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> referenciaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'referencia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> referenciaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'referencia',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> referenciaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'referencia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> referenciaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'referencia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> referenciaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'referencia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> referenciaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'referencia',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> referenciaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'referencia',
        value: '',
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> referenciaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'referencia',
        value: '',
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> tipoPagoEqualTo(
    TipoPago value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> tipoPagoGreaterThan(
    TipoPago value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> tipoPagoLessThan(
    TipoPago value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> tipoPagoBetween(
    TipoPago lower,
    TipoPago upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipoPago',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> tipoPagoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> tipoPagoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> tipoPagoContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> tipoPagoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipoPago',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> tipoPagoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoPago',
        value: '',
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> tipoPagoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoPago',
        value: '',
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> uuidEqualTo(
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> uuidGreaterThan(
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> uuidLessThan(
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> uuidBetween(
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> uuidStartsWith(
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> uuidEndsWith(
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

  QueryBuilder<Pago, Pago, QAfterFilterCondition> uuidContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> uuidMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> valorEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valor',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> valorGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valor',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> valorLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valor',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> valorBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension PagoQueryObject on QueryBuilder<Pago, Pago, QFilterCondition> {}

extension PagoQueryLinks on QueryBuilder<Pago, Pago, QFilterCondition> {
  QueryBuilder<Pago, Pago, QAfterFilterCondition> deuda(FilterQuery<Deuda> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'deuda');
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> deudaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'deuda', 0, true, 0, true);
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> interes(
      FilterQuery<InteresDeuda> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'interes');
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> interesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'interes', 0, true, 0, true);
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> cuotas(
      FilterQuery<CuotaDeuda> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'cuotas');
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> cuotasLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cuotas', length, true, length, true);
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> cuotasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cuotas', 0, true, 0, true);
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> cuotasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cuotas', 0, false, 999999, true);
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> cuotasLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cuotas', 0, true, length, include);
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> cuotasLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cuotas', length, include, 999999, true);
    });
  }

  QueryBuilder<Pago, Pago, QAfterFilterCondition> cuotasLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'cuotas', lower, includeLower, upper, includeUpper);
    });
  }
}

extension PagoQuerySortBy on QueryBuilder<Pago, Pago, QSortBy> {
  QueryBuilder<Pago, Pago, QAfterSortBy> sortByEliminado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eliminado', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByEliminadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eliminado', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByFechaActualizacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByFechaActualizacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByFechaPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPago', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByFechaPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPago', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByFechaRegistroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByMetodoPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metodoPago', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByMetodoPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metodoPago', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByNumeroPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroPago', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByNumeroPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroPago', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByObservacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacion', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByObservacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacion', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByReferencia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referencia', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByReferenciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referencia', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByTipoPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoPago', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByTipoPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoPago', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> sortByValorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.desc);
    });
  }
}

extension PagoQuerySortThenBy on QueryBuilder<Pago, Pago, QSortThenBy> {
  QueryBuilder<Pago, Pago, QAfterSortBy> thenByEliminado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eliminado', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByEliminadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eliminado', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByFechaActualizacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByFechaActualizacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByFechaPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPago', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByFechaPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPago', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByFechaRegistroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByMetodoPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metodoPago', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByMetodoPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metodoPago', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByNumeroPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroPago', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByNumeroPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroPago', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByObservacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacion', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByObservacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacion', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByReferencia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referencia', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByReferenciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referencia', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByTipoPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoPago', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByTipoPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoPago', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.asc);
    });
  }

  QueryBuilder<Pago, Pago, QAfterSortBy> thenByValorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.desc);
    });
  }
}

extension PagoQueryWhereDistinct on QueryBuilder<Pago, Pago, QDistinct> {
  QueryBuilder<Pago, Pago, QDistinct> distinctByEliminado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eliminado');
    });
  }

  QueryBuilder<Pago, Pago, QDistinct> distinctByFechaActualizacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaActualizacion');
    });
  }

  QueryBuilder<Pago, Pago, QDistinct> distinctByFechaPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaPago');
    });
  }

  QueryBuilder<Pago, Pago, QDistinct> distinctByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaRegistro');
    });
  }

  QueryBuilder<Pago, Pago, QDistinct> distinctByMetodoPago(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'metodoPago', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Pago, Pago, QDistinct> distinctByNumeroPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroPago');
    });
  }

  QueryBuilder<Pago, Pago, QDistinct> distinctByObservacion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'observacion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Pago, Pago, QDistinct> distinctByReferencia(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'referencia', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Pago, Pago, QDistinct> distinctByTipoPago(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoPago', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Pago, Pago, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Pago, Pago, QDistinct> distinctByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valor');
    });
  }
}

extension PagoQueryProperty on QueryBuilder<Pago, Pago, QQueryProperty> {
  QueryBuilder<Pago, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Pago, bool, QQueryOperations> eliminadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eliminado');
    });
  }

  QueryBuilder<Pago, DateTime?, QQueryOperations> fechaActualizacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaActualizacion');
    });
  }

  QueryBuilder<Pago, DateTime, QQueryOperations> fechaPagoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaPago');
    });
  }

  QueryBuilder<Pago, DateTime, QQueryOperations> fechaRegistroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaRegistro');
    });
  }

  QueryBuilder<Pago, MetodoPago, QQueryOperations> metodoPagoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'metodoPago');
    });
  }

  QueryBuilder<Pago, int, QQueryOperations> numeroPagoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroPago');
    });
  }

  QueryBuilder<Pago, String?, QQueryOperations> observacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'observacion');
    });
  }

  QueryBuilder<Pago, String?, QQueryOperations> referenciaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'referencia');
    });
  }

  QueryBuilder<Pago, TipoPago, QQueryOperations> tipoPagoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoPago');
    });
  }

  QueryBuilder<Pago, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }

  QueryBuilder<Pago, double, QQueryOperations> valorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valor');
    });
  }
}
