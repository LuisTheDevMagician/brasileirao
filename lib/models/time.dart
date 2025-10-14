class Time {
  final int id;
  final String nome;
  final String escudo;
  final int pontos;
  final int jogos;
  final int vitorias;
  final int empates;
  final int derrotas;
  final int golsPro;
  final int golsContra;
  final List<int> titulos;
  final String estadio;
  final String tecnico;
  final int fundacao;

  Time({
    required this.id,
    required this.nome,
    required this.escudo,
    required this.pontos,
    required this.jogos,
    required this.vitorias,
    required this.empates,
    required this.derrotas,
    required this.golsPro,
    required this.golsContra,
    required this.titulos,
    required this.estadio,
    required this.tecnico,
    required this.fundacao,
  });

  int get saldoGols => golsPro - golsContra;

  double get aproveitamento => (pontos / (jogos * 3)) * 100;

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      id: json['id'] as int,
      nome: json['nome'] as String,
      escudo: json['escudo'] as String,
      pontos: json['pontos'] as int,
      jogos: json['jogos'] as int,
      vitorias: json['vitorias'] as int,
      empates: json['empates'] as int,
      derrotas: json['derrotas'] as int,
      golsPro: json['golsPro'] as int,
      golsContra: json['golsContra'] as int,
      titulos: (json['titulos'] as List<dynamic>).map((e) => e as int).toList(),
      estadio: json['estadio'] as String,
      tecnico: json['tecnico'] as String,
      fundacao: json['fundacao'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'escudo': escudo,
      'pontos': pontos,
      'jogos': jogos,
      'vitorias': vitorias,
      'empates': empates,
      'derrotas': derrotas,
      'golsPro': golsPro,
      'golsContra': golsContra,
      'titulos': titulos,
      'estadio': estadio,
      'tecnico': tecnico,
      'fundacao': fundacao,
    };
  }
}
