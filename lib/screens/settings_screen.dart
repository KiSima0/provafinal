import 'package:flutter/material.dart';
import '../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {

  bool temaEscuro = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    temaEscuro =
      Theme.of(context).brightness ==
      Brightness.dark;
  }

  bool notificacoes = true;

  String idioma = 'Português';

  @override
  Widget build(BuildContext context) {

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

            value: temaEscuro,

          onChanged: (valor) {

          setState(() {
            temaEscuro = valor;
          });

          StudyPlannerApp.of(context)
            ?.toggleTheme(valor);
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