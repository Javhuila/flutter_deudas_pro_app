import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClienteSearchBar extends ConsumerStatefulWidget {
  const ClienteSearchBar({
    super.key,
    this.textoInicial = '',
    this.onChanged,
    this.onClear,
    this.focoNode,
  });

  final String textoInicial;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final FocusNode? focoNode;

  @override
  ConsumerState<ClienteSearchBar> createState() => _ClienteSearchBarState();
}

class _ClienteSearchBarState extends ConsumerState<ClienteSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.textoInicial);
  }

  @override
  void didUpdateWidget(covariant ClienteSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.textoInicial != oldWidget.textoInicial &&
        widget.textoInicial != _controller.text) {
      _controller.value = TextEditingValue(
        text: widget.textoInicial,
        selection: TextSelection.collapsed(offset: widget.textoInicial.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: SearchBar(
        controller: _controller,
        focusNode: widget.focoNode,
        hintText: 'Buscar cliente...',
        leading: const Icon(Icons.search),
        trailing: [
          if (_controller.text.isNotEmpty)
            IconButton(
              tooltip: 'Limpiar búsqueda',
              icon: const Icon(Icons.close),
              onPressed: () {
                _controller.clear();

                widget.onClear?.call();

                setState(() {});
              },
            ),
        ],
        elevation: const WidgetStatePropertyAll(0),
        onChanged: (texto) {
          widget.onChanged?.call(texto);

          setState(() {});
        },
      ),
    );
  }
}
