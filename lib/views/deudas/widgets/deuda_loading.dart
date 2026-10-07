import 'package:flutter/material.dart';

class DeudaLoading extends StatelessWidget {
  const DeudaLoading({super.key, this.itemCount = 5});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList.separated(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return const _DeudaLoadingCard();
        },
        separatorBuilder: (_, _) {
          return const SizedBox(height: 12);
        },
      ),
    );
  }
}

class _DeudaLoadingCard extends StatelessWidget {
  const _DeudaLoadingCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _LoadingBox(width: 48, height: 48, radius: 24),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _LoadingBox(width: 170, height: 18),

                      SizedBox(height: 8),

                      _LoadingBox(width: 130, height: 14),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                const _LoadingBox(width: 32, height: 32, radius: 16),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: const [
                Expanded(child: _LoadingBox(height: 62)),

                SizedBox(width: 12),

                Expanded(child: _LoadingBox(height: 62)),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              children: const [
                _LoadingBox(width: 90, height: 32, radius: 16),

                Spacer(),

                _LoadingBox(width: 85, height: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingBox extends StatelessWidget {
  const _LoadingBox({this.width, required this.height, this.radius = 8});

  final double? width;

  final double height;

  final double radius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
