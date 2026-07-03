import 'package:flutter/material.dart';

import 'disciplinas_screen.dart';
import 'settings_screen.dart';
import '../database/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;

  final pages = [
    const HomeContent(),
    const DisciplinasScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Disciplinas',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() =>
      _HomeContentState();
}

class _HomeContentState
    extends State<HomeContent> {

  final db = DatabaseHelper.instance;

  int totalDisciplinas = 0;
  int totalAtividades = 0;

  List<Map<String, dynamic>> atividades = [];

  @override
  void initState() {
    super.initState();

    carregarDados();
  }

  Future<void> carregarDados() async {

    totalDisciplinas =
        await db.getTotalDisciplinas();

    totalAtividades =
        await db.getTotalAtividades();

    atividades =
        await db.getUltimasAtividades();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
      Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: carregarDados,

        child: SingleChildScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(),

          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const Text(
                'Home',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Container(
                height: 180,

                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.grey.shade800
                      : const Color(0xFFD8F2F5),

                  borderRadius:
                      BorderRadius.circular(25),
                ),

                child: Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      Text(
                        'Disciplinas',
                        style: TextStyle(
                          color: Theme.of(context)
                            .colorScheme
                            .onSurface,
                          fontSize: 22,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        '$totalDisciplinas cadastradas',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context)
                            .colorScheme
                            .onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding:
                    const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: isDark
                    ? Colors.grey.shade900
                    : Colors.grey.shade100,

                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Row(
                  children: [

                    Icon(
                      Icons.assignment,
                      color: Theme.of(context)
                        .colorScheme
                        .onSurface,
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        '$totalAtividades atividades cadastradas',
                        style: TextStyle(
                          color: Theme.of(context)
                            .colorScheme
                            .onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                constraints:
                    const BoxConstraints(
                  minHeight: 180,
                ),

                padding:
                    const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: isDark
                    ? Colors.grey.shade800
                    : const Color(0xFFDDF0D0),

                  borderRadius:
                      BorderRadius.circular(25),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      'Últimas atividades',
                      style: TextStyle(
                        color: Theme.of(context)
                          .colorScheme
                          .onSurface,
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    if (atividades.isEmpty)
                      Text(
                        'Nenhuma atividade cadastrada',
                        style: TextStyle(
                          color: Theme.of(context)
                            .colorScheme
                            .onSurface,
                        ),
                      ),

                    ...atividades.map(
                      (atividade) => Padding(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          vertical: 4,
                        ),

                        child: Text(
                          '• ${atividade['titulo']}',
                          style: TextStyle(
                            color: Theme.of(context)
                              .colorScheme
                              .onSurface,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}