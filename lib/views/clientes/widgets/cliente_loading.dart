import 'package:flutter/material.dart';

class ClienteLoading extends StatelessWidget {
  const ClienteLoading({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList.separated(
        itemCount: itemCount,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (_, _) {
          return const _ClienteLoadingCard();
        },
      ),
    );
  }
}

class _ClienteLoadingCard extends StatelessWidget {
  const _ClienteLoadingCard();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceContainerHighest;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 24, backgroundColor: color),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PlaceholderBox(width: 160, height: 18, color: color),

                  const SizedBox(height: 10),

                  _PlaceholderBox(width: 130, height: 14, color: color),

                  const SizedBox(height: 8),

                  _PlaceholderBox(width: 190, height: 14, color: color),

                  const SizedBox(height: 18),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _PlaceholderBox(width: 90, height: 30, color: color),

                      _PlaceholderBox(width: 100, height: 30, color: color),

                      _PlaceholderBox(width: 80, height: 30, color: color),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            _PlaceholderBox(width: 24, height: 24, color: color),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderBox extends StatelessWidget {
  const _PlaceholderBox({
    required this.width,
    required this.height,
    required this.color,
  });

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
