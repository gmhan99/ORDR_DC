import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:ordr_dc/l10n/app_localizations.dart';

class Layout extends ConsumerWidget{
  const Layout({super.key, required this.child});

  final Widget child;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context);

    return NavigationView(
      appBar: NavigationAppBar(
        title: Text(locale.side_button_home),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(children: [
            const Text('ORDR Season 2'),
          ]),
        ),
      ),
      content: material.Material(
        color: Colors.transparent,
        child: child,
      ),
    );
  }
}