// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interes_deuda.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetInteresDeudaCollection on Isar {
  IsarCollection<InteresDeuda> get interesDeudas => this.collection();
}

const InteresDeudaSchema = CollectionSchema(
  name: r'InteresDeuda',
  id: 2467320323728468542,
  properties: {
    r'fechaActualizacion': PropertySchema(
      id: 0,
      name: r'fechaActualizacion',
      type: IsarType.dateTime,
    ),
    r'fechaFin': PropertySchema(
      id: 1,
      name: r'fechaFin',
      type: IsarType.dateTime,
    ),
    r'fechaInicio': PropertySchema(
      id: 2,
      name: r'fechaInicio',
      type: IsarType.dateTime,
    ),
    r'fechaPago': PropertySchema(
      id: 3,
      name: r'fechaPago',
      type: IsarType.dateTime,
    ),
    r'fechaRegistro': PropertySchema(
      id: 4,
      name: r'fechaRegistro',
      type: IsarType.dateTime,
    ),
    r'numeroPeriodo': PropertySchema(
      id: 5,
      name: r'numeroPeriodo',
      type: IsarType.long,
    ),
    r'pagado': PropertySchema(
      id: 6,
      name: r'pagado',
      type: IsarType.bool,
    ),
    r'porcentaje': PropertySchema(
      id: 7,
      name: r'porcentaje',
      type: IsarType.double,
    ),
    r'saldoPendiente': PropertySchema(
      id: 8,
      name: r'saldoPendiente',
      type: IsarType.double,
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
    ),
    r'valorPagado': PropertySchema(
      id: 11,
      name: r'valorPagado',
      type: IsarType.double,
    )
  },
  estimateSize: _interesDeudaEstimateSize,
  serialize: _interesDeudaSerialize,
  deserialize: _interesDeudaDeserialize,
  deserializeProp: _interesDeudaDeserializeProp,
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
      id: 4859438053296511894,
      name: r'deuda',
      target: r'Deuda',
      single: true,
    ),
    r'pagos': LinkSchema(
      id: -1587628684968289477,
      name: r'pagos',
      target: r'Pago',
      single: false,
      linkName: r'interes',
    )
  },
  embeddedSchemas: {},
  getId: _interesDeudaGetId,
  getLinks: _interesDeudaGetLinks,
  attach: _interesDeudaAttach,
  version: '3.1.0+1',
);

int _interesDeudaEstimateSize(
  InteresDeuda object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _interesDeudaSerialize(
  InteresDeuda object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.fechaActualizacion);
  writer.writeDateTime(offsets[1], object.fechaFin);
  writer.writeDateTime(offsets[2], object.fechaInicio);
  writer.writeDateTime(offsets[3], object.fechaPago);
  writer.writeDateTime(offsets[4], object.fechaRegistro);
  writer.writeLong(offsets[5], object.numeroPeriodo);
  writer.writeBool(offsets[6], object.pagado);
  writer.writeDouble(offsets[7], object.porcentaje);
  writer.writeDouble(offsets[8], object.saldoPendiente);
  writer.writeString(offsets[9], object.uuid);
  writer.writeDouble(offsets[10], object.valor);
  writer.writeDouble(offsets[11], object.valorPagado);
}

InteresDeuda _interesDeudaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InteresDeuda();
  object.fechaActualizacion = reader.readDateTimeOrNull(offsets[0]);
  object.fechaFin = reader.readDateTime(offsets[1]);
  object.fechaInicio = reader.readDateTime(offsets[2]);
  object.fechaPago = reader.readDateTimeOrNull(offsets[3]);
  object.fechaRegistro = reader.readDateTime(offsets[4]);
  object.id = id;
  object.numeroPeriodo = reader.readLong(offsets[5]);
  object.pagado = reader.readBool(offsets[6]);
  object.porcentaje = reader.readDouble(offsets[7]);
  object.uuid = reader.readString(offsets[9]);
  object.valor = reader.readDouble(offsets[10]);
  object.valorPagado = reader.readDouble(offsets[11]);
  return object;
}

P _interesDeudaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readDouble(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _interesDeudaGetId(InteresDeuda object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _interesDeudaGetLinks(InteresDeuda object) {
  return [object.deuda, object.pagos];
}

void _interesDeudaAttach(
    IsarCollection<dynamic> col, Id id, InteresDeuda object) {
  object.id = id;
  object.deuda.attach(col, col.isar.collection<Deuda>(), r'deuda', id);
  object.pagos.attach(col, col.isar.collection<Pago>(), r'pagos', id);
}

extension InteresDeudaByIndex on IsarCollection<InteresDeuda> {
  Future<InteresDeuda?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  InteresDeuda? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<InteresDeuda?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<InteresDeuda?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(InteresDeuda object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(InteresDeuda object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<InteresDeuda> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<InteresDeuda> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension InteresDeudaQueryWhereSort
    on QueryBuilder<InteresDeuda, InteresDeuda, QWhere> {
  QueryBuilder<InteresDeuda, InteresDeuda, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension InteresDeudaQueryWhere
    on QueryBuilder<InteresDeuda, InteresDeuda, QWhereClause> {
  QueryBuilder<InteresDeuda, InteresDeuda, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterWhereClause> idBetween(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterWhereClause> uuidEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterWhereClause> uuidNotEqualTo(
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

extension InteresDeudaQueryFilter
    on QueryBuilder<InteresDeuda, InteresDeuda, QFilterCondition> {
  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      fechaActualizacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fechaActualizacion',
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      fechaActualizacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fechaActualizacion',
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      fechaActualizacionEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaActualizacion',
        value: value,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      fechaFinEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaFin',
        value: value,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      fechaFinGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaFin',
        value: value,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      fechaFinLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaFin',
        value: value,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      fechaFinBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaFin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      fechaInicioEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaInicio',
        value: value,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      fechaInicioGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaInicio',
        value: value,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      fechaInicioLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaInicio',
        value: value,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      fechaInicioBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaInicio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      fechaPagoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fechaPago',
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      fechaPagoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fechaPago',
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      fechaPagoEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaPago',
        value: value,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      fechaPagoLessThan(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      fechaPagoBetween(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      fechaRegistroEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaRegistro',
        value: value,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition> idBetween(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      numeroPeriodoEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroPeriodo',
        value: value,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      numeroPeriodoGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numeroPeriodo',
        value: value,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      numeroPeriodoLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numeroPeriodo',
        value: value,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      numeroPeriodoBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numeroPeriodo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition> pagadoEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pagado',
        value: value,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      porcentajeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'porcentaje',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      porcentajeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'porcentaje',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      porcentajeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'porcentaje',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      porcentajeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'porcentaje',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition> uuidEqualTo(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      uuidGreaterThan(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition> uuidLessThan(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition> uuidBetween(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      uuidStartsWith(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition> uuidEndsWith(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition> uuidContains(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition> uuidMatches(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition> valorEqualTo(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      valorGreaterThan(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition> valorLessThan(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition> valorBetween(
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
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

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
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

extension InteresDeudaQueryObject
    on QueryBuilder<InteresDeuda, InteresDeuda, QFilterCondition> {}

extension InteresDeudaQueryLinks
    on QueryBuilder<InteresDeuda, InteresDeuda, QFilterCondition> {
  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition> deuda(
      FilterQuery<Deuda> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'deuda');
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      deudaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'deuda', 0, true, 0, true);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition> pagos(
      FilterQuery<Pago> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'pagos');
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      pagosLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pagos', length, true, length, true);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      pagosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pagos', 0, true, 0, true);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      pagosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pagos', 0, false, 999999, true);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      pagosLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pagos', 0, true, length, include);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
      pagosLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pagos', length, include, 999999, true);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterFilterCondition>
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

extension InteresDeudaQuerySortBy
    on QueryBuilder<InteresDeuda, InteresDeuda, QSortBy> {
  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy>
      sortByFechaActualizacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy>
      sortByFechaActualizacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> sortByFechaFin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFin', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> sortByFechaFinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFin', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> sortByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy>
      sortByFechaInicioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> sortByFechaPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPago', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> sortByFechaPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPago', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> sortByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy>
      sortByFechaRegistroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> sortByNumeroPeriodo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroPeriodo', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy>
      sortByNumeroPeriodoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroPeriodo', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> sortByPagado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pagado', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> sortByPagadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pagado', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> sortByPorcentaje() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'porcentaje', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy>
      sortByPorcentajeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'porcentaje', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy>
      sortBySaldoPendiente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saldoPendiente', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy>
      sortBySaldoPendienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saldoPendiente', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> sortByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> sortByValorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> sortByValorPagado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorPagado', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy>
      sortByValorPagadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorPagado', Sort.desc);
    });
  }
}

extension InteresDeudaQuerySortThenBy
    on QueryBuilder<InteresDeuda, InteresDeuda, QSortThenBy> {
  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy>
      thenByFechaActualizacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy>
      thenByFechaActualizacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> thenByFechaFin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFin', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> thenByFechaFinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFin', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> thenByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy>
      thenByFechaInicioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> thenByFechaPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPago', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> thenByFechaPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPago', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> thenByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy>
      thenByFechaRegistroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> thenByNumeroPeriodo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroPeriodo', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy>
      thenByNumeroPeriodoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroPeriodo', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> thenByPagado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pagado', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> thenByPagadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pagado', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> thenByPorcentaje() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'porcentaje', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy>
      thenByPorcentajeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'porcentaje', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy>
      thenBySaldoPendiente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saldoPendiente', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy>
      thenBySaldoPendienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saldoPendiente', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> thenByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> thenByValorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.desc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy> thenByValorPagado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorPagado', Sort.asc);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QAfterSortBy>
      thenByValorPagadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorPagado', Sort.desc);
    });
  }
}

extension InteresDeudaQueryWhereDistinct
    on QueryBuilder<InteresDeuda, InteresDeuda, QDistinct> {
  QueryBuilder<InteresDeuda, InteresDeuda, QDistinct>
      distinctByFechaActualizacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaActualizacion');
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QDistinct> distinctByFechaFin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaFin');
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QDistinct> distinctByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaInicio');
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QDistinct> distinctByFechaPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaPago');
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QDistinct>
      distinctByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaRegistro');
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QDistinct>
      distinctByNumeroPeriodo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroPeriodo');
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QDistinct> distinctByPagado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pagado');
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QDistinct> distinctByPorcentaje() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'porcentaje');
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QDistinct>
      distinctBySaldoPendiente() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'saldoPendiente');
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QDistinct> distinctByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valor');
    });
  }

  QueryBuilder<InteresDeuda, InteresDeuda, QDistinct> distinctByValorPagado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valorPagado');
    });
  }
}

extension InteresDeudaQueryProperty
    on QueryBuilder<InteresDeuda, InteresDeuda, QQueryProperty> {
  QueryBuilder<InteresDeuda, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<InteresDeuda, DateTime?, QQueryOperations>
      fechaActualizacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaActualizacion');
    });
  }

  QueryBuilder<InteresDeuda, DateTime, QQueryOperations> fechaFinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaFin');
    });
  }

  QueryBuilder<InteresDeuda, DateTime, QQueryOperations> fechaInicioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaInicio');
    });
  }

  QueryBuilder<InteresDeuda, DateTime?, QQueryOperations> fechaPagoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaPago');
    });
  }

  QueryBuilder<InteresDeuda, DateTime, QQueryOperations>
      fechaRegistroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaRegistro');
    });
  }

  QueryBuilder<InteresDeuda, int, QQueryOperations> numeroPeriodoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroPeriodo');
    });
  }

  QueryBuilder<InteresDeuda, bool, QQueryOperations> pagadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pagado');
    });
  }

  QueryBuilder<InteresDeuda, double, QQueryOperations> porcentajeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'porcentaje');
    });
  }

  QueryBuilder<InteresDeuda, double, QQueryOperations>
      saldoPendienteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'saldoPendiente');
    });
  }

  QueryBuilder<InteresDeuda, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }

  QueryBuilder<InteresDeuda, double, QQueryOperations> valorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valor');
    });
  }

  QueryBuilder<InteresDeuda, double, QQueryOperations> valorPagadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valorPagado');
    });
  }
}
