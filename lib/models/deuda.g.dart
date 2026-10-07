// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deuda.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDeudaCollection on Isar {
  IsarCollection<Deuda> get deudas => this.collection();
}

const DeudaSchema = CollectionSchema(
  name: r'Deuda',
  id: 3405603411988045056,
  properties: {
    r'archivada': PropertySchema(
      id: 0,
      name: r'archivada',
      type: IsarType.bool,
    ),
    r'capital': PropertySchema(
      id: 1,
      name: r'capital',
      type: IsarType.double,
    ),
    r'estado': PropertySchema(
      id: 2,
      name: r'estado',
      type: IsarType.string,
      enumMap: _DeudaestadoEnumValueMap,
    ),
    r'fechaActualizacion': PropertySchema(
      id: 3,
      name: r'fechaActualizacion',
      type: IsarType.dateTime,
    ),
    r'fechaPrestamo': PropertySchema(
      id: 4,
      name: r'fechaPrestamo',
      type: IsarType.dateTime,
    ),
    r'fechaRegistro': PropertySchema(
      id: 5,
      name: r'fechaRegistro',
      type: IsarType.dateTime,
    ),
    r'fechaVencimiento': PropertySchema(
      id: 6,
      name: r'fechaVencimiento',
      type: IsarType.dateTime,
    ),
    r'interesCalculado': PropertySchema(
      id: 7,
      name: r'interesCalculado',
      type: IsarType.double,
    ),
    r'mesesProgramados': PropertySchema(
      id: 8,
      name: r'mesesProgramados',
      type: IsarType.long,
    ),
    r'numeroCuotas': PropertySchema(
      id: 9,
      name: r'numeroCuotas',
      type: IsarType.long,
    ),
    r'numeroDeuda': PropertySchema(
      id: 10,
      name: r'numeroDeuda',
      type: IsarType.long,
    ),
    r'observacion': PropertySchema(
      id: 11,
      name: r'observacion',
      type: IsarType.string,
    ),
    r'porcentajeInteres': PropertySchema(
      id: 12,
      name: r'porcentajeInteres',
      type: IsarType.double,
    ),
    r'programada': PropertySchema(
      id: 13,
      name: r'programada',
      type: IsarType.bool,
    ),
    r'saldoPendiente': PropertySchema(
      id: 14,
      name: r'saldoPendiente',
      type: IsarType.double,
    ),
    r'tieneCuotas': PropertySchema(
      id: 15,
      name: r'tieneCuotas',
      type: IsarType.bool,
    ),
    r'total': PropertySchema(
      id: 16,
      name: r'total',
      type: IsarType.double,
    ),
    r'totalPagado': PropertySchema(
      id: 17,
      name: r'totalPagado',
      type: IsarType.double,
    ),
    r'uuid': PropertySchema(
      id: 18,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _deudaEstimateSize,
  serialize: _deudaSerialize,
  deserialize: _deudaDeserialize,
  deserializeProp: _deudaDeserializeProp,
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
    ),
    r'fechaPrestamo': IndexSchema(
      id: 5659624929976488533,
      name: r'fechaPrestamo',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'fechaPrestamo',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'cliente': LinkSchema(
      id: -8613730439457986933,
      name: r'cliente',
      target: r'Cliente',
      single: true,
    ),
    r'pagos': LinkSchema(
      id: 8487911070100643633,
      name: r'pagos',
      target: r'Pago',
      single: false,
      linkName: r'deuda',
    ),
    r'intereses': LinkSchema(
      id: 3425120234337129914,
      name: r'intereses',
      target: r'InteresDeuda',
      single: false,
      linkName: r'deuda',
    ),
    r'cuotas': LinkSchema(
      id: -1204183589043154431,
      name: r'cuotas',
      target: r'CuotaDeuda',
      single: false,
      linkName: r'deuda',
    )
  },
  embeddedSchemas: {},
  getId: _deudaGetId,
  getLinks: _deudaGetLinks,
  attach: _deudaAttach,
  version: '3.1.0+1',
);

int _deudaEstimateSize(
  Deuda object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.estado.name.length * 3;
  {
    final value = object.observacion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _deudaSerialize(
  Deuda object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.archivada);
  writer.writeDouble(offsets[1], object.capital);
  writer.writeString(offsets[2], object.estado.name);
  writer.writeDateTime(offsets[3], object.fechaActualizacion);
  writer.writeDateTime(offsets[4], object.fechaPrestamo);
  writer.writeDateTime(offsets[5], object.fechaRegistro);
  writer.writeDateTime(offsets[6], object.fechaVencimiento);
  writer.writeDouble(offsets[7], object.interesCalculado);
  writer.writeLong(offsets[8], object.mesesProgramados);
  writer.writeLong(offsets[9], object.numeroCuotas);
  writer.writeLong(offsets[10], object.numeroDeuda);
  writer.writeString(offsets[11], object.observacion);
  writer.writeDouble(offsets[12], object.porcentajeInteres);
  writer.writeBool(offsets[13], object.programada);
  writer.writeDouble(offsets[14], object.saldoPendiente);
  writer.writeBool(offsets[15], object.tieneCuotas);
  writer.writeDouble(offsets[16], object.total);
  writer.writeDouble(offsets[17], object.totalPagado);
  writer.writeString(offsets[18], object.uuid);
}

Deuda _deudaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Deuda();
  object.archivada = reader.readBool(offsets[0]);
  object.capital = reader.readDouble(offsets[1]);
  object.estado =
      _DeudaestadoValueEnumMap[reader.readStringOrNull(offsets[2])] ??
          EstadoDeuda.pendiente;
  object.fechaActualizacion = reader.readDateTimeOrNull(offsets[3]);
  object.fechaPrestamo = reader.readDateTime(offsets[4]);
  object.fechaRegistro = reader.readDateTime(offsets[5]);
  object.fechaVencimiento = reader.readDateTimeOrNull(offsets[6]);
  object.id = id;
  object.interesCalculado = reader.readDouble(offsets[7]);
  object.mesesProgramados = reader.readLong(offsets[8]);
  object.numeroCuotas = reader.readLong(offsets[9]);
  object.numeroDeuda = reader.readLong(offsets[10]);
  object.observacion = reader.readStringOrNull(offsets[11]);
  object.porcentajeInteres = reader.readDouble(offsets[12]);
  object.programada = reader.readBool(offsets[13]);
  object.saldoPendiente = reader.readDouble(offsets[14]);
  object.tieneCuotas = reader.readBool(offsets[15]);
  object.total = reader.readDouble(offsets[16]);
  object.totalPagado = reader.readDouble(offsets[17]);
  object.uuid = reader.readString(offsets[18]);
  return object;
}

P _deudaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (_DeudaestadoValueEnumMap[reader.readStringOrNull(offset)] ??
          EstadoDeuda.pendiente) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readDouble(offset)) as P;
    case 13:
      return (reader.readBool(offset)) as P;
    case 14:
      return (reader.readDouble(offset)) as P;
    case 15:
      return (reader.readBool(offset)) as P;
    case 16:
      return (reader.readDouble(offset)) as P;
    case 17:
      return (reader.readDouble(offset)) as P;
    case 18:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _DeudaestadoEnumValueMap = {
  r'pendiente': r'pendiente',
  r'pagada': r'pagada',
  r'vencida': r'vencida',
};
const _DeudaestadoValueEnumMap = {
  r'pendiente': EstadoDeuda.pendiente,
  r'pagada': EstadoDeuda.pagada,
  r'vencida': EstadoDeuda.vencida,
};

Id _deudaGetId(Deuda object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _deudaGetLinks(Deuda object) {
  return [object.cliente, object.pagos, object.intereses, object.cuotas];
}

void _deudaAttach(IsarCollection<dynamic> col, Id id, Deuda object) {
  object.id = id;
  object.cliente.attach(col, col.isar.collection<Cliente>(), r'cliente', id);
  object.pagos.attach(col, col.isar.collection<Pago>(), r'pagos', id);
  object.intereses
      .attach(col, col.isar.collection<InteresDeuda>(), r'intereses', id);
  object.cuotas.attach(col, col.isar.collection<CuotaDeuda>(), r'cuotas', id);
}

extension DeudaByIndex on IsarCollection<Deuda> {
  Future<Deuda?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  Deuda? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<Deuda?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<Deuda?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(Deuda object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(Deuda object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<Deuda> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<Deuda> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension DeudaQueryWhereSort on QueryBuilder<Deuda, Deuda, QWhere> {
  QueryBuilder<Deuda, Deuda, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterWhere> anyFechaPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'fechaPrestamo'),
      );
    });
  }
}

extension DeudaQueryWhere on QueryBuilder<Deuda, Deuda, QWhereClause> {
  QueryBuilder<Deuda, Deuda, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Deuda, Deuda, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterWhereClause> idBetween(
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

  QueryBuilder<Deuda, Deuda, QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterWhereClause> uuidNotEqualTo(String uuid) {
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

  QueryBuilder<Deuda, Deuda, QAfterWhereClause> fechaPrestamoEqualTo(
      DateTime fechaPrestamo) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fechaPrestamo',
        value: [fechaPrestamo],
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterWhereClause> fechaPrestamoNotEqualTo(
      DateTime fechaPrestamo) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fechaPrestamo',
              lower: [],
              upper: [fechaPrestamo],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fechaPrestamo',
              lower: [fechaPrestamo],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fechaPrestamo',
              lower: [fechaPrestamo],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fechaPrestamo',
              lower: [],
              upper: [fechaPrestamo],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterWhereClause> fechaPrestamoGreaterThan(
    DateTime fechaPrestamo, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fechaPrestamo',
        lower: [fechaPrestamo],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterWhereClause> fechaPrestamoLessThan(
    DateTime fechaPrestamo, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fechaPrestamo',
        lower: [],
        upper: [fechaPrestamo],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterWhereClause> fechaPrestamoBetween(
    DateTime lowerFechaPrestamo,
    DateTime upperFechaPrestamo, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fechaPrestamo',
        lower: [lowerFechaPrestamo],
        includeLower: includeLower,
        upper: [upperFechaPrestamo],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DeudaQueryFilter on QueryBuilder<Deuda, Deuda, QFilterCondition> {
  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> archivadaEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'archivada',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> capitalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'capital',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> capitalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'capital',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> capitalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'capital',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> capitalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'capital',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> estadoEqualTo(
    EstadoDeuda value, {
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> estadoGreaterThan(
    EstadoDeuda value, {
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> estadoLessThan(
    EstadoDeuda value, {
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> estadoBetween(
    EstadoDeuda lower,
    EstadoDeuda upper, {
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> estadoStartsWith(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> estadoEndsWith(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> estadoContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> estadoMatches(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> estadoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estado',
        value: '',
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> estadoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'estado',
        value: '',
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> fechaActualizacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fechaActualizacion',
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition>
      fechaActualizacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fechaActualizacion',
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> fechaActualizacionEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaActualizacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition>
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> fechaActualizacionLessThan(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> fechaActualizacionBetween(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> fechaPrestamoEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaPrestamo',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> fechaPrestamoGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaPrestamo',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> fechaPrestamoLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaPrestamo',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> fechaPrestamoBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaPrestamo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> fechaRegistroEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaRegistro',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> fechaRegistroGreaterThan(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> fechaRegistroLessThan(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> fechaRegistroBetween(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> fechaVencimientoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fechaVencimiento',
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition>
      fechaVencimientoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fechaVencimiento',
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> fechaVencimientoEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaVencimiento',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> fechaVencimientoGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaVencimiento',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> fechaVencimientoLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaVencimiento',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> fechaVencimientoBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaVencimiento',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> interesCalculadoEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interesCalculado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> interesCalculadoGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interesCalculado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> interesCalculadoLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interesCalculado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> interesCalculadoBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interesCalculado',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> mesesProgramadosEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mesesProgramados',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> mesesProgramadosGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mesesProgramados',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> mesesProgramadosLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mesesProgramados',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> mesesProgramadosBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mesesProgramados',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> numeroCuotasEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroCuotas',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> numeroCuotasGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numeroCuotas',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> numeroCuotasLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numeroCuotas',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> numeroCuotasBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numeroCuotas',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> numeroDeudaEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroDeuda',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> numeroDeudaGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numeroDeuda',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> numeroDeudaLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numeroDeuda',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> numeroDeudaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numeroDeuda',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> observacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'observacion',
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> observacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'observacion',
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> observacionEqualTo(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> observacionGreaterThan(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> observacionLessThan(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> observacionBetween(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> observacionStartsWith(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> observacionEndsWith(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> observacionContains(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> observacionMatches(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> observacionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'observacion',
        value: '',
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> observacionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'observacion',
        value: '',
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> porcentajeInteresEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'porcentajeInteres',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition>
      porcentajeInteresGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'porcentajeInteres',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> porcentajeInteresLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'porcentajeInteres',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> porcentajeInteresBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'porcentajeInteres',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> programadaEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'programada',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> saldoPendienteEqualTo(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> saldoPendienteGreaterThan(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> saldoPendienteLessThan(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> saldoPendienteBetween(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> tieneCuotasEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tieneCuotas',
        value: value,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> totalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'total',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> totalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'total',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> totalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'total',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> totalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'total',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> totalPagadoEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalPagado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> totalPagadoGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalPagado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> totalPagadoLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalPagado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> totalPagadoBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalPagado',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> uuidEqualTo(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> uuidGreaterThan(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> uuidLessThan(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> uuidBetween(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> uuidStartsWith(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> uuidEndsWith(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> uuidContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> uuidMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension DeudaQueryObject on QueryBuilder<Deuda, Deuda, QFilterCondition> {}

extension DeudaQueryLinks on QueryBuilder<Deuda, Deuda, QFilterCondition> {
  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> cliente(
      FilterQuery<Cliente> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'cliente');
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> clienteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cliente', 0, true, 0, true);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> pagos(FilterQuery<Pago> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'pagos');
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> pagosLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pagos', length, true, length, true);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> pagosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pagos', 0, true, 0, true);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> pagosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pagos', 0, false, 999999, true);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> pagosLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pagos', 0, true, length, include);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> pagosLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pagos', length, include, 999999, true);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> pagosLengthBetween(
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

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> intereses(
      FilterQuery<InteresDeuda> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'intereses');
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> interesesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'intereses', length, true, length, true);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> interesesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'intereses', 0, true, 0, true);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> interesesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'intereses', 0, false, 999999, true);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> interesesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'intereses', 0, true, length, include);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> interesesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'intereses', length, include, 999999, true);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> interesesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'intereses', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> cuotas(
      FilterQuery<CuotaDeuda> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'cuotas');
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> cuotasLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cuotas', length, true, length, true);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> cuotasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cuotas', 0, true, 0, true);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> cuotasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cuotas', 0, false, 999999, true);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> cuotasLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cuotas', 0, true, length, include);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> cuotasLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cuotas', length, include, 999999, true);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterFilterCondition> cuotasLengthBetween(
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

extension DeudaQuerySortBy on QueryBuilder<Deuda, Deuda, QSortBy> {
  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByArchivada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'archivada', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByArchivadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'archivada', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByCapital() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capital', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByCapitalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capital', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByFechaActualizacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByFechaActualizacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByFechaPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPrestamo', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByFechaPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPrestamo', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByFechaRegistroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByFechaVencimiento() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaVencimiento', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByFechaVencimientoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaVencimiento', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByInteresCalculado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interesCalculado', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByInteresCalculadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interesCalculado', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByMesesProgramados() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mesesProgramados', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByMesesProgramadosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mesesProgramados', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByNumeroCuotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroCuotas', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByNumeroCuotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroCuotas', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByNumeroDeuda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroDeuda', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByNumeroDeudaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroDeuda', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByObservacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacion', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByObservacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacion', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByPorcentajeInteres() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'porcentajeInteres', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByPorcentajeInteresDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'porcentajeInteres', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByProgramada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'programada', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByProgramadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'programada', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortBySaldoPendiente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saldoPendiente', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortBySaldoPendienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saldoPendiente', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByTieneCuotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneCuotas', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByTieneCuotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneCuotas', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByTotalPagado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPagado', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByTotalPagadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPagado', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension DeudaQuerySortThenBy on QueryBuilder<Deuda, Deuda, QSortThenBy> {
  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByArchivada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'archivada', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByArchivadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'archivada', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByCapital() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capital', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByCapitalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capital', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByFechaActualizacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByFechaActualizacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaActualizacion', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByFechaPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPrestamo', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByFechaPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPrestamo', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByFechaRegistroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByFechaVencimiento() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaVencimiento', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByFechaVencimientoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaVencimiento', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByInteresCalculado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interesCalculado', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByInteresCalculadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interesCalculado', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByMesesProgramados() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mesesProgramados', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByMesesProgramadosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mesesProgramados', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByNumeroCuotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroCuotas', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByNumeroCuotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroCuotas', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByNumeroDeuda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroDeuda', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByNumeroDeudaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroDeuda', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByObservacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacion', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByObservacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacion', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByPorcentajeInteres() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'porcentajeInteres', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByPorcentajeInteresDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'porcentajeInteres', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByProgramada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'programada', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByProgramadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'programada', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenBySaldoPendiente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saldoPendiente', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenBySaldoPendienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saldoPendiente', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByTieneCuotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneCuotas', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByTieneCuotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneCuotas', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByTotalPagado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPagado', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByTotalPagadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPagado', Sort.desc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Deuda, Deuda, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension DeudaQueryWhereDistinct on QueryBuilder<Deuda, Deuda, QDistinct> {
  QueryBuilder<Deuda, Deuda, QDistinct> distinctByArchivada() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'archivada');
    });
  }

  QueryBuilder<Deuda, Deuda, QDistinct> distinctByCapital() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'capital');
    });
  }

  QueryBuilder<Deuda, Deuda, QDistinct> distinctByEstado(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estado', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Deuda, Deuda, QDistinct> distinctByFechaActualizacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaActualizacion');
    });
  }

  QueryBuilder<Deuda, Deuda, QDistinct> distinctByFechaPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaPrestamo');
    });
  }

  QueryBuilder<Deuda, Deuda, QDistinct> distinctByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaRegistro');
    });
  }

  QueryBuilder<Deuda, Deuda, QDistinct> distinctByFechaVencimiento() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaVencimiento');
    });
  }

  QueryBuilder<Deuda, Deuda, QDistinct> distinctByInteresCalculado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'interesCalculado');
    });
  }

  QueryBuilder<Deuda, Deuda, QDistinct> distinctByMesesProgramados() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mesesProgramados');
    });
  }

  QueryBuilder<Deuda, Deuda, QDistinct> distinctByNumeroCuotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroCuotas');
    });
  }

  QueryBuilder<Deuda, Deuda, QDistinct> distinctByNumeroDeuda() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroDeuda');
    });
  }

  QueryBuilder<Deuda, Deuda, QDistinct> distinctByObservacion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'observacion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Deuda, Deuda, QDistinct> distinctByPorcentajeInteres() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'porcentajeInteres');
    });
  }

  QueryBuilder<Deuda, Deuda, QDistinct> distinctByProgramada() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'programada');
    });
  }

  QueryBuilder<Deuda, Deuda, QDistinct> distinctBySaldoPendiente() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'saldoPendiente');
    });
  }

  QueryBuilder<Deuda, Deuda, QDistinct> distinctByTieneCuotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tieneCuotas');
    });
  }

  QueryBuilder<Deuda, Deuda, QDistinct> distinctByTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'total');
    });
  }

  QueryBuilder<Deuda, Deuda, QDistinct> distinctByTotalPagado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalPagado');
    });
  }

  QueryBuilder<Deuda, Deuda, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension DeudaQueryProperty on QueryBuilder<Deuda, Deuda, QQueryProperty> {
  QueryBuilder<Deuda, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Deuda, bool, QQueryOperations> archivadaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'archivada');
    });
  }

  QueryBuilder<Deuda, double, QQueryOperations> capitalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'capital');
    });
  }

  QueryBuilder<Deuda, EstadoDeuda, QQueryOperations> estadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estado');
    });
  }

  QueryBuilder<Deuda, DateTime?, QQueryOperations>
      fechaActualizacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaActualizacion');
    });
  }

  QueryBuilder<Deuda, DateTime, QQueryOperations> fechaPrestamoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaPrestamo');
    });
  }

  QueryBuilder<Deuda, DateTime, QQueryOperations> fechaRegistroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaRegistro');
    });
  }

  QueryBuilder<Deuda, DateTime?, QQueryOperations> fechaVencimientoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaVencimiento');
    });
  }

  QueryBuilder<Deuda, double, QQueryOperations> interesCalculadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interesCalculado');
    });
  }

  QueryBuilder<Deuda, int, QQueryOperations> mesesProgramadosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mesesProgramados');
    });
  }

  QueryBuilder<Deuda, int, QQueryOperations> numeroCuotasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroCuotas');
    });
  }

  QueryBuilder<Deuda, int, QQueryOperations> numeroDeudaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroDeuda');
    });
  }

  QueryBuilder<Deuda, String?, QQueryOperations> observacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'observacion');
    });
  }

  QueryBuilder<Deuda, double, QQueryOperations> porcentajeInteresProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'porcentajeInteres');
    });
  }

  QueryBuilder<Deuda, bool, QQueryOperations> programadaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'programada');
    });
  }

  QueryBuilder<Deuda, double, QQueryOperations> saldoPendienteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'saldoPendiente');
    });
  }

  QueryBuilder<Deuda, bool, QQueryOperations> tieneCuotasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tieneCuotas');
    });
  }

  QueryBuilder<Deuda, double, QQueryOperations> totalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'total');
    });
  }

  QueryBuilder<Deuda, double, QQueryOperations> totalPagadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalPagado');
    });
  }

  QueryBuilder<Deuda, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
