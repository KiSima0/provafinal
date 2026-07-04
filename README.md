# Study Planner

O Study Planner é um aplicativo feito em Flutter e Dart para auxiliar na organização de disciplinas e atividades acadêmicas. A ideia principal do aplicativo é permitir que o usuário cadastre suas disciplinas e, a partir de cada disciplina, cadastre atividades relacionadas a ela, como trabalhos, provas, estudos e entregas.

O aplicativo atende ao requisito de possuir CRUD de duas entidades relacionadas, sendo elas Disciplina e Atividade. A entidade Disciplina possui os campos id, nome e professor, enquanto a entidade Atividade possui id, título, descrição, data de entrega e disciplinaId. O campo disciplinaId é responsável por fazer o relacionamento entre as duas entidades, pois ele guarda o id da disciplina à qual a atividade pertence.

O banco de dados utilizado foi SQLite, com o pacote sqflite. O arquivo database_helper.dart centraliza a criação e o acesso ao banco, contendo os métodos responsáveis por inserir, listar, atualizar e excluir registros. O banco real é criado como um arquivo local no dispositivo ou computador, e o caminho é obtido com getDatabasesPath(), enquanto o join() é usado para montar o caminho completo até o arquivo study_planner.db.

Na prova final foram feitas melhorias no projeto para deixar o aplicativo mais consistente. Foram adicionadas validações nos formulários, impedindo que o usuário salve disciplinas ou atividades com campos vazios. Também foi adicionada uma confirmação antes de excluir registros, evitando exclusões acidentais. Além disso, a exclusão de disciplinas foi melhorada para remover também as atividades relacionadas, evitando registros órfãos no banco.

Outra melhoria feita foi no gerenciamento de estado do tema do aplicativo. O modo escuro passou a ser controlado com Provider, por meio da classe ThemeProvider. Com isso, o estado do tema fica separado da tela de configurações e pode ser acessado pelo aplicativo inteiro, melhorando a organização do código e facilitando a manutenção.

## Funcionalidades

- Cadastro de disciplinas
- Listagem de disciplinas
- Edição de disciplinas
- Exclusão de disciplinas
- Cadastro de atividades vinculadas a uma disciplina
- Listagem de atividades por disciplina
- Edição de atividades
- Exclusão de atividades
- Validação de campos obrigatórios
- Confirmação antes de excluir registros
- Banco de dados local SQLite
- Modo claro e modo escuro com Provider

## Estrutura principal

- main.dart: inicia o aplicativo, configura o tema e inicializa o SQLite para rodar no Windows quando necessário.
- database_helper.dart: gerencia o banco SQLite, cria as tabelas e contém os métodos de CRUD.
- home_screen.dart: tela inicial do aplicativo, mostrando informações gerais.
- disciplinas_screen.dart: tela responsável pelo CRUD de disciplinas.
- atividades_screen.dart: tela responsável pelo CRUD de atividades vinculadas a uma disciplina.
- settings_screen.dart: tela de configurações, incluindo o controle do modo escuro.
- theme_provider.dart: classe responsável por gerenciar o estado do tema do aplicativo.

## Como executar

Para executar o projeto, é necessário ter o Flutter instalado. Depois, basta rodar:

```bash
flutter pub get
flutter run