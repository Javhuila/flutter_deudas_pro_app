import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/cliente.dart';
import '../../providers/cliente_provider.dart';

class ClienteFormPage extends ConsumerStatefulWidget {
  const ClienteFormPage({super.key, this.cliente});

  final Cliente? cliente;

  bool get isEditing => cliente != null;

  @override
  ConsumerState<ClienteFormPage> createState() => _ClienteFormPageState();
}

class _ClienteFormPageState extends ConsumerState<ClienteFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _guardando = false;

  late final TextEditingController _nombreController;
  late final TextEditingController _telefonoController;
  late final TextEditingController _direccionController;
  late final TextEditingController _observacionController;

  bool _activo = true;

  @override
  void initState() {
    super.initState();

    final cliente = widget.cliente;

    _nombreController = TextEditingController(text: cliente?.nombre ?? '');

    _telefonoController = TextEditingController(text: cliente?.telefono ?? '');

    _direccionController = TextEditingController(
      text: cliente?.direccion ?? '',
    );

    _observacionController = TextEditingController(
      text: cliente?.observacion ?? '',
    );

    _activo = cliente?.activo ?? true;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    _observacionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.isEditing;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar cliente' : 'Nuevo cliente'),
      ),

      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: FilledButton.icon(
          onPressed: _guardando ? null : _guardar,
          icon: _guardando
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.save),
          label: Text(
            widget.isEditing ? 'Guardar cambios' : 'Registrar cliente',
          ),
        ),
      ),

      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nombreController,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            labelText: 'Nombre completo',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Ingrese el nombre.';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _telefonoController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Teléfono',
                            prefixIcon: Icon(Icons.phone_outlined),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return null;
                            }

                            if (value.trim().length < 7) {
                              return 'Teléfono inválido.';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _direccionController,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            labelText: 'Dirección',
                            prefixIcon: Icon(Icons.location_on_outlined),
                          ),
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _observacionController,
                          textInputAction: TextInputAction.done,
                          minLines: 3,
                          maxLines: 5,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            labelText: 'Observaciones',
                            prefixIcon: Icon(Icons.notes_outlined),
                            alignLabelWithHint: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Card(
                  child: SwitchListTile(
                    value: _activo,
                    onChanged: (value) {
                      setState(() {
                        _activo = value;
                      });
                    },
                    secondary: const Icon(Icons.verified_user_outlined),
                    title: const Text('Cliente activo'),
                    subtitle: const Text(
                      'Permite registrar nuevas deudas para este cliente.',
                    ),
                  ),
                ),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _guardando = true;
    });

    try {
      final notifier = ref.read(clienteProvider.notifier);

      final cliente = widget.cliente ?? Cliente();

      cliente.nombre = _nombreController.text.trim();
      cliente.telefono = _telefonoController.text.trim();
      cliente.direccion = _direccionController.text.trim();
      cliente.observacion = _observacionController.text.trim();
      cliente.activo = _activo;

      if (widget.isEditing) {
        await notifier.actualizar(cliente);
      } else {
        await notifier.guardar(cliente);
      }

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          _guardando = false;
        });
      }
    }
  }
}
