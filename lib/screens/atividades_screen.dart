import 'package:flutter/material.dart';

import '../database/database_helper.dart';

class AtividadesScreen extends StatefulWidget {

  final int disciplinaId;
  final String disciplinaNome;

  const AtividadesScreen({
    super.key,
    required this.disciplinaId,
    required this.disciplinaNome,
  });

  @override
  State<AtividadesScreen> createState() =>
      _AtividadesScreenState();
}

class _AtividadesScreenState
    extends State<AtividadesScreen> {

  final DatabaseHelper db =
      DatabaseHelper.instance;

  Future<List<Map<String, dynamic>>>
      carregarAtividades() {
    return db.getAtividades(
      widget.disciplinaId,
    );
  }

  Future<void> excluir(int id) async {
    await db.deleteAtividade(id);

    setState(() {});
  }

  Future<void> abrirFormulario({
    Map<String, dynamic>? atividade,
  }) async {

    final tituloController =
        TextEditingController(
      text: atividade?['titulo'] ?? '',
    );

    final descricaoController =
        TextEditingController(
      text: atividade?['descricao'] ?? '',
    );

    final dataController =
        TextEditingController(
      text: atividade?['dataEntrega'] ?? '',
    );

    await showDialog(
      context: context,

      builder: (_) {
        return AlertDialog(
          title: Text(
            atividade == null
                ? 'Nova Atividade'
                : 'Editar Atividade',
          ),

          content: SingleChildScrollView(
            child: Column(
              children: [

                TextField(
                  controller:
                      tituloController,
                  decoration:
                      const InputDecoration(
                    labelText: 'Título',
                  ),
                ),

                TextField(
                  controller:
                      descricaoController,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Descrição',
                  ),
                ),

                TextField(
                  controller: dataController,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Data Entrega',
                  ),
                ),
              ],
            ),
          ),

          actions: [

            TextButton(
              onPressed: () async {

                final dados = {
                  'titulo':
                      tituloController.text,

                  'descricao':
                      descricaoController.text,

                  'dataEntrega':
                      dataController.text,

                  'disciplinaId':
                      widget.disciplinaId,
                };

                if (atividade == null) {

                  await db.insertAtividade(
                    dados,
                  );

                } else {

                  await db.updateAtividade(
                    atividade['id'],
                    dados,
                  );
                }

                if (mounted) {
                  Navigator.pop(context);
                }

                setState(() {});
              },
              child: const Text(
                'Salvar',
              ),
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
        title: Text(
          widget.disciplinaNome,
        ),
      ),

      body: FutureBuilder(
        future: carregarAtividades(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          final atividades =
              snapshot.data
                  as List<Map<String, dynamic>>;

          if (atividades.isEmpty) {

            return const Center(
              child: Text(
                'Nenhuma atividade cadastrada',
              ),
            );
          }

          return ListView.builder(
            itemCount: atividades.length,

            itemBuilder:
                (context, index) {

              final atividade =
                  atividades[index];

              return Card(
                margin:
                    const EdgeInsets.all(
                  12,
                ),

                child: ListTile(
                  title: Text(
                    atividade['titulo'],
                  ),

                  subtitle: Text(
                    atividade['dataEntrega'],
                  ),

                  trailing: Row(
                    mainAxisSize:
                        MainAxisSize.min,

                    children: [

                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                        ),

                        onPressed: () {
                          abrirFormulario(
                            atividade:
                                atividade,
                          );
                        },
                      ),

                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                        ),

                        onPressed: () {
                          excluir(
                            atividade['id'],
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