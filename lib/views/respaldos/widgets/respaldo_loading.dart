import 'package:flutter/material.dart';

class RespaldoLoading extends StatelessWidget {
  const RespaldoLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      sliver: SliverList(
        delegate: SliverChildListDelegate(const [
          _RespaldoLoadingCard(),

          SizedBox(height: 12),

          _RespaldoLoadingCard(),

          SizedBox(height: 12),

          _RespaldoLoadingCard(),
        ]),
      ),
    );
  }
}

class _RespaldoLoadingCard extends StatelessWidget {
  const _RespaldoLoadingCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const _RespaldoLoadingBox(width: 44, height: 44, radius: 22),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _RespaldoLoadingBox(width: 170, height: 18),

                      SizedBox(height: 8),

                      _RespaldoLoadingBox(width: 125, height: 14),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            _RespaldoLoadingBox(
              width: double.infinity,
              height: 14,
              color: colorScheme.surfaceContainerHighest,
            ),

            const SizedBox(height: 10),

            _RespaldoLoadingBox(
              width: 220,
              height: 14,
              color: colorScheme.surfaceContainerHighest,
            ),

            const SizedBox(height: 18),

            Row(
              children: const [
                Expanded(child: _RespaldoLoadingBox(height: 42, radius: 10)),

                SizedBox(width: 12),

                Expanded(child: _RespaldoLoadingBox(height: 42, radius: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RespaldoLoadingBox extends StatelessWidget {
  const _RespaldoLoadingBox({
    this.width,
    required this.height,
    this.radius = 8,
    this.color,
  });

  final double? width;

  final double height;

  final double radius;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
