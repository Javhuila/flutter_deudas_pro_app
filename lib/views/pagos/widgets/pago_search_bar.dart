import 'package:flutter/material.dart';

class PagoSearchBar extends StatelessWidget {
  const PagoSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onClear,
    this.focoNode,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final FocusNode? focoNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: SearchBar(
        controller: controller,
        focusNode: focoNode,
        hintText: 'Buscar pago...',
        leading: const Icon(Icons.search),
        trailing: [
          if (controller != null)
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller!,
              builder: (context, value, child) {
                if (value.text.isEmpty) {
                  return const SizedBox.shrink();
                }

                return IconButton(
                  onPressed: onClear,
                  icon: const Icon(Icons.close),
                  tooltip: 'Limpiar búsqueda',
                );
              },
            ),
        ],
        elevation: const WidgetStatePropertyAll(0),
        onChanged: onChanged,
      ),
    );
  }
}
