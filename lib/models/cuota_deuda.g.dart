// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cuota_deuda.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCuotaDeudaCollection on Isar {
  IsarCollection<CuotaDeuda> get cuotaDeudas => this.collection();
}

const CuotaDeudaSchema = CollectionSchema(
  name: r'CuotaDeuda',
  id: 6223947171785365281,
  properties: {
    r'estado': PropertySchema(
      id: 0,
      name: r'estado',
      type: IsarType.string,
      enumMap: _CuotaDeudaestadoEnumValueMap,
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
    r'numeroCuota': PropertySchema(
      id: 4,
      name: r'numeroCuota',
      type: IsarType.long,
    ),
    r'saldoPendiente': PropertySchema(
      id: 5,
      name: r'saldoPendiente',
      type: IsarType.double,
    ),
    r'uuid': PropertySchema(
      id: 6,
      name: r'uuid',
      type: IsarType.string,
    ),
    r'valor': PropertySchema(
      id: 7,
      name: r'valor',
      type: IsarType.double,
    ),
    r'valorPagado': PropertySchema(
      id: 8,
      name: r'valorPagado',
      type: IsarType.double,
    )
  },
  estimateSize: _cuotaDeudaEstimateSize,
  serialize: _cuotaDeudaSerialize,
  deserialize: _cuotaDeudaDeserialize,
  deserializeProp: _cuotaDeudaDeserializeProp,
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
      id: 5740480505650448659,
      name: r'deuda',
      target: r'Deuda',
      single: true,
    ),
    r'pagos': LinkSchema(
      id: 2292245411525060663,
      name: r'pagos',
      target: r'Pago',
      single: false,
      linkName: r'cuotas',
    )
  },
  embeddedSchemas: {},
  getId: _cuotaDeudaGetId,
  getLinks: _cuotaDeudaGetLinks,
  attach: _cuotaDeudaAttach,
  version: '3.1.0+1',
);

int _cuotaDeudaEstimateSize(
  CuotaDeuda object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.estado.name.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _cuotaDeudaSerialize(
  CuotaDeuda object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.estado.name);
  writer.writeDateTime(offsets[1], object.fechaActualizacion);
  writer.writeDateTime(offsets[2], object.fechaPago);
  writer.writeDateTime(offsets[3], object.fechaRegistro);
  writer.writeLong(offsets[4], object.numeroCuota);
  writer.writeDouble(offsets[5], object.saldoPendiente);
  writer.writeString(offsets[6], object.uuid);
  writer.writeDouble(offsets[7], object.valor);
  writer.writeDouble(offsets[8], object.valorPagado);
}

CuotaDeuda _cuotaDeudaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CuotaDeuda();
  object.estado =
      _CuotaDeudaestadoValueEnumMap[reader.readStringOrNull(offsets[0])] ??
          EstadoCuota.pendiente;
  object.fechaActualizacion = reader.readDateTimeOrNull(offsets[1]);
  object.fechaPago = reader.readDateTimeOrNull(offsets[2]);
  object.fechaRegistro = reader.readDateTime(offsets[3]);
  object.id = id;
  object.numeroCuota = reader.readLong(offsets[4]);
  object.uuid = reader.readString(offsets[6]);
  object.valor = reader.readDouble(offsets[7]);
  object.valorPagado = reader.readDouble(offsets[8]);
  return object;
}

P _cuotaDeudaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_CuotaDeudaestadoValueEnumMap[reader.readStringOrNull(offset)] ??
          EstadoCuota.pendiente) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CuotaDeudaestadoEnumValueMap = {
  r'pendiente': r'pendiente',
  r'parcial': r'parcial',
  r'pagada': r'pagada',
};
const _CuotaDeudaestadoValueEnumMap = {
  r'pendiente': EstadoCuota.pendiente,
  r'parcial': EstadoCuota.parcial,
  r'pagada': EstadoCuota.pagada,
};

Id _cuotaDeudaGetId(CuotaDeuda object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cuotaDeudaGetLinks(CuotaDeuda object) {
  return [object.deuda, object.pagos];
}

void _cuotaDeudaAttach(IsarCollection<dynamic> col, Id id, CuotaDeuda object) {
  object.id = id;
  object.deuda.attach(col, col.isar.collection<Deuda>(), r'deuda', id);
  object.pagos.attach(col, col.isar.collection<Pago>(), r'pagos', id);
}

extension CuotaDeudaByIndex on IsarCollection<CuotaDeuda> {
  Future<CuotaDeuda?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  CuotaDeuda? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<CuotaDeuda?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<CuotaDeuda?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(CuotaDeuda object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(CuotaDeuda object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<CuotaDeuda> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<CuotaDeuda> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension CuotaDeudaQueryWhereSort
    on QueryBuilder<CuotaDeuda, CuotaDeuda, QWhere> {
  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CuotaDeudaQueryWhere
    on QueryBuilder<CuotaDeuda, CuotaDeuda, QWhereClause> {
  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterWhereClause> idBetween(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterWhereClause> uuidEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterWhereClause> uuidNotEqualTo(
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

extension CuotaDeudaQueryFilter
    on QueryBuilder<CuotaDeuda, CuotaDeuda, QFilterCondition> {
  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> estadoEqualTo(
    EstadoCuota value, {
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> estadoGreaterThan(
    EstadoCuota value, {
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> estadoLessThan(
    EstadoCuota value, {
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> estadoBetween(
    EstadoCuota lower,
    EstadoCuota upper, {
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> estadoStartsWith(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> estadoEndsWith(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> estadoContains(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> estadoMatches(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> estadoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estado',
        value: '',
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      estadoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'estado',
        value: '',
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      fechaActualizacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fechaActualizacion',
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      fechaActualizacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fechaActualizacion',
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      fechaActualizacionEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaActualizacion',
        value: value,
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      fechaActualizacionGreaterThan(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      fechaActualizacionLessThan(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      fechaActualizacionBetween(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      fechaPagoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fechaPago',
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      fechaPagoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fechaPago',
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> fechaPagoEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaPago',
        value: value,
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      fechaPagoGreaterThan(
    DateTime? value, {
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> fechaPagoLessThan(
    DateTime? value, {
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> fechaPagoBetween(
    DateTime? lower,
    DateTime? upper, {
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      fechaRegistroEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaRegistro',
        value: value,
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      fechaRegistroGreaterThan(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      fechaRegistroLessThan(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      fechaRegistroBetween(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      numeroCuotaEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroCuota',
        value: value,
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      numeroCuotaGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numeroCuota',
        value: value,
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      numeroCuotaLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numeroCuota',
        value: value,
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      numeroCuotaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numeroCuota',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      saldoPendienteEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'saldoPendiente',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      saldoPendienteGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'saldoPendiente',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      saldoPendienteLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'saldoPendiente',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      saldoPendienteBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'saldoPendiente',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> uuidEqualTo(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> uuidGreaterThan(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> uuidLessThan(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> uuidBetween(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> uuidStartsWith(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> uuidEndsWith(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> uuidContains(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> uuidMatches(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> valorEqualTo(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> valorGreaterThan(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> valorLessThan(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> valorBetween(
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

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      valorPagadoEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valorPagado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      valorPagadoGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valorPagado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      valorPagadoLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valorPagado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      valorPagadoBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valorPagado',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension CuotaDeudaQueryObject
    on QueryBuilder<CuotaDeuda, CuotaDeuda, QFilterCondition> {}

extension CuotaDeudaQueryLinks
    on QueryBuilder<CuotaDeuda, CuotaDeuda, QFilterCondition> {
  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> deuda(
      FilterQuery<Deuda> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'deuda');
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> deudaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'deuda', 0, true, 0, true);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> pagos(
      FilterQuery<Pago> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'pagos');
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      pagosLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pagos', length, true, length, true);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition> pagosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pagos', 0, true, 0, true);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      pagosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pagos', 0, false, 999999, true);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      pagosLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pagos', 0, true, length, include);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      pagosLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pagos', length, include, 999999, true);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterFilterCondition>
      pagosLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'pagos', lower, includeLower, upper, includeUpper);
    });
  }
}

extension CuotaDeudaQuerySortBy
    on QueryBuilder<CuotaDeuda, CuotaDeuda, QSortBy> {
  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> sortByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> sortByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy>
      sortByFechaActualizacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy>
      sortByFechaActualizacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.desc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> sortByFechaPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPago', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> sortByFechaPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPago', Sort.desc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> sortByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> sortByFechaRegistroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.desc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> sortByNumeroCuota() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroCuota', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> sortByNumeroCuotaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroCuota', Sort.desc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> sortBySaldoPendiente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saldoPendiente', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy>
      sortBySaldoPendienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saldoPendiente', Sort.desc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> sortByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> sortByValorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.desc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> sortByValorPagado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorPagado', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> sortByValorPagadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorPagado', Sort.desc);
    });
  }
}

extension CuotaDeudaQuerySortThenBy
    on QueryBuilder<CuotaDeuda, CuotaDeuda, QSortThenBy> {
  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> thenByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> thenByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy>
      thenByFechaActualizacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy>
      thenByFechaActualizacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.desc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> thenByFechaPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPago', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> thenByFechaPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPago', Sort.desc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> thenByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> thenByFechaRegistroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.desc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> thenByNumeroCuota() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroCuota', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> thenByNumeroCuotaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroCuota', Sort.desc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> thenBySaldoPendiente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saldoPendiente', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy>
      thenBySaldoPendienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saldoPendiente', Sort.desc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> thenByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> thenByValorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.desc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> thenByValorPagado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorPagado', Sort.asc);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QAfterSortBy> thenByValorPagadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorPagado', Sort.desc);
    });
  }
}

extension CuotaDeudaQueryWhereDistinct
    on QueryBuilder<CuotaDeuda, CuotaDeuda, QDistinct> {
  QueryBuilder<CuotaDeuda, CuotaDeuda, QDistinct> distinctByEstado(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estado', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QDistinct>
      distinctByFechaActualizacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaActualizacion');
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QDistinct> distinctByFechaPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaPago');
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QDistinct> distinctByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaRegistro');
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QDistinct> distinctByNumeroCuota() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroCuota');
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QDistinct> distinctBySaldoPendiente() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'saldoPendiente');
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QDistinct> distinctByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valor');
    });
  }

  QueryBuilder<CuotaDeuda, CuotaDeuda, QDistinct> distinctByValorPagado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valorPagado');
    });
  }
}

extension CuotaDeudaQueryProperty
    on QueryBuilder<CuotaDeuda, CuotaDeuda, QQueryProperty> {
  QueryBuilder<CuotaDeuda, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CuotaDeuda, EstadoCuota, QQueryOperations> estadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estado');
    });
  }

  QueryBuilder<CuotaDeuda, DateTime?, QQueryOperations>
      fechaActualizacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaActualizacion');
    });
  }

  QueryBuilder<CuotaDeuda, DateTime?, QQueryOperations> fechaPagoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaPago');
    });
  }

  QueryBuilder<CuotaDeuda, DateTime, QQueryOperations> fechaRegistroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaRegistro');
    });
  }

  QueryBuilder<CuotaDeuda, int, QQueryOperations> numeroCuotaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroCuota');
    });
  }

  QueryBuilder<CuotaDeuda, double, QQueryOperations> saldoPendienteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'saldoPendiente');
    });
  }

  QueryBuilder<CuotaDeuda, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }

  QueryBuilder<CuotaDeuda, double, QQueryOperations> valorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valor');
    });
  }

  QueryBuilder<CuotaDeuda, double, QQueryOperations> valorPagadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valorPagado');
    });
  }
}
