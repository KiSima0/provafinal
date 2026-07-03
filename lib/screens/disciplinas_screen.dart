import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import 'atividades_screen.dart';

class DisciplinasScreen extends StatefulWidget {
  const DisciplinasScreen({super.key});

  @override
  State<DisciplinasScreen> createState() =>
      _DisciplinasScreenState();
}

class _DisciplinasScreenState
    extends State<DisciplinasScreen> {

  final DatabaseHelper db = DatabaseHelper.instance;

  Future<List<Map<String, dynamic>>> carregarDisciplinas() {
    return db.getDisciplinas();
  }

  Future<void> excluir(int id) async {
    await db.deleteDisciplina(id);

    setState(() {});
  }

  Future<void> abrirFormulario({
    Map<String, dynamic>? disciplina,
  }) async {

    final nomeController = TextEditingController(
      text: disciplina?['nome'] ?? '',
    );

    final professorController = TextEditingController(
      text: disciplina?['professor'] ?? '',
    );

    await showDialog(
      context: context,

      builder: (_) {
        return AlertDialog(
          title: Text(
            disciplina == null
                ? 'Nova Disciplina'
                : 'Editar Disciplina',
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
              ),

              TextField(
                controller: professorController,
                decoration: const InputDecoration(
                  labelText: 'Professor',
                ),
              ),
            ],
          ),

          actions: [

            TextButton(
              onPressed: () async {

                final dados = {
                  'nome': nomeController.text,
                  'professor': professorController.text,
                };

                if (disciplina == null) {
                  await db.insertDisciplina(dados);
                } else {
                  await db.updateDisciplina(
                    disciplina['id'],
                    dados,
                  );
                }

                if (mounted) {
                  Navigator.pop(context);
                }

                setState(() {});
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Disciplinas'),
      ),

      body: FutureBuilder(
        future: carregarDisciplinas(),

        builder: (context, snapshot) {

        if (snapshot.connectionState ==
            ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Erro: ${snapshot.error}',
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text('Sem dados'),
          );
        }

          final disciplinas =
              snapshot.data as List<Map<String, dynamic>>;

          if (disciplinas.isEmpty) {
            return const Center(
              child: Text(
                'Nenhuma disciplina cadastrada',
              ),
            );
          }

          return ListView.builder(
            itemCount: disciplinas.length,

            itemBuilder: (context, index) {

              final disciplina = disciplinas[index];

              return Card(
                margin: const EdgeInsets.all(12),

                child: ListTile(
                  title: Text(disciplina['nome']),

                  subtitle:
                      Text(disciplina['professor']),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AtividadesScreen(
                          disciplinaId:
                              disciplina['id'],
                          disciplinaNome:
                              disciplina['nome'],
                        ),
                      ),
                    );
                  },

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [

                      IconButton(
                        icon:
                            const Icon(Icons.edit),

                        onPressed: () {
                          abrirFormulario(
                            disciplina: disciplina,
                          );
                        },
                      ),

                      IconButton(
                        icon:
                            const Icon(Icons.delete),

                        onPressed: () {
                          excluir(
                            disciplina['id'],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed: () {
          abrirFormulario();
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}