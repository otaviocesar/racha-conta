class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question(
      {required this.id,
      required this.question,
      required this.answer,
      required this.options});
}

const List sample_data = [
  {
    "id": 1,
    "question": "Flutter foi criado por qual empresa?",
    "options": ['Apple', 'Google', 'Facebook', 'Microsoft'],
    "answer_index": 1,
  },
  {
    "id": 2,
    "question": "Qual foi o ano de lançamento do Flutter?",
    "options": ['Jun 2017', 'Jun 2017', 'Maio 2017', 'Maio 2018'],
    "answer_index": 2,
  },
  {
    "id": 3,
    "question": "Qual a linguagem de programação utilizada no Flutter?",
    "options": ['Java', 'Dart', 'Python', 'C#'],
    "answer_index": 1,
  },
  {
    "id": 4,
    "question": "Qual o comando utilizado para rodar uma aplicação Flutter?",
    "options": ['vai teia!', 'roda ai', 'vai flutter', 'flutter run'],
    "answer_index": 3,
  },
];
