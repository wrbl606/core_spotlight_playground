import 'package:flutter/material.dart';
import 'package:flutter_core_spotlight/flutter_core_spotlight.dart';

class SpotlightAdvertising extends StatefulWidget {
  const SpotlightAdvertising({super.key, required this.child});

  final Widget child;

  @override
  State<SpotlightAdvertising> createState() => _SpotlightAdvertisingState();
}

class _SpotlightAdvertisingState extends State<SpotlightAdvertising> {
  Future<void>? cachedSetupFuture;

  Future<void> _setup(BuildContext context) => cachedSetupFuture == null
      ? cachedSetupFuture = setupSpotlightAdvertisement(context)
      : cachedSetupFuture!;

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: _setup(context),
        builder: (_, __) => widget.child,
      );
}

Future<void> setupSpotlightAdvertisement(BuildContext context) async {
  FlutterCoreSpotlight.instance.configure(
      onSearchableItemSelected: (userActivity) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Hello Spotlight!'),
      ),
    );
  });
  await FlutterCoreSpotlight.instance.indexSearchableItems(
    [
      FlutterSpotlightItem(
        uniqueIdentifier: '1',
        domainIdentifier: 'com.monterail.spotlight_demo',
        attributeTitle: 'Launch app',
        attributeDescription: 'Open home screen',
      )
    ],
  );
}
