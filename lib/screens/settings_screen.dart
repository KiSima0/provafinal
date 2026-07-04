import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {

  bool notificacoes = true;

  String idioma = 'Português';

  @override
  Widget build(BuildContext context) {
    final themeProvider =
      Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Configurações'),
      ),

      body: ListView(
        children: [

          SwitchListTile(
            secondary:
                const Icon(Icons.color_lens),

            title:
                const Text('Tema Escuro'),

            value: themeProvider.isDark,

            onChanged: (valor) {
              themeProvider.toggleTheme(valor);
            },
          ),

          ListTile(
            leading:
                const Icon(Icons.language),

            title: Text(
              'Idioma: $idioma',
            ),

            onTap: () {

              setState(() {

                idioma =
                    idioma == 'Português'
                        ? 'English'
                        : 'Português';
              });
            },
          ),

          const ListTile(
            leading: Icon(Icons.backup),

            title: Text('Backup'),
          ),

          SwitchListTile(
            secondary:
                const Icon(Icons.notifications),

            title:
                const Text('Notificações'),

            value: notificacoes,

            onChanged: (valor) {

              setState(() {
                notificacoes = valor;
              });
            },
          ),
        ],
      ),
    );
  }
}