# Brasileirão 2025 - Aplicativo Flutter

Aplicativo mobile para acompanhamento do Campeonato Brasileiro de Futebol 2025.

# LINKS:
Linkedin: https://www.linkedin.com/pulse/brasileir%C3%A3o-flutter-luis-eduardo-onckf/?trackingId=%2Fk%2Fz9WL5%2FUsoT88HEMyN5w%3D%3D

Youtube: https://youtu.be/IGEQGPvK68c

## 📱 Funcionalidades Implementadas

### ✅ Tela de Classificação
- Lista ordenada dos 20 times por pontuação
- Exibição de: posição, escudo, nome, pontos, jogos, vitórias, empates, derrotas, gols pró, gols contra e saldo de gols
- Indicadores visuais coloridos para zonas de classificação:
  - 🔵 Azul escuro (1º-4º): Libertadores - Fase de Grupos
  - 🟢 Verde claro (5º-6º): Libertadores - Pré-Libertadores
  - 🟠 Laranja (7º-12º): Sul-Americana
  - 🔴 Vermelho (17º-20º): Rebaixamento
- Busca/filtro por nome do time em tempo real
- Design responsivo com cards elegantes

### ✅ Tela de Detalhes do Time
- Informações completas do time selecionado
- Histórico de títulos brasileiros com anos
- Estatísticas detalhadas da temporada atual:
  - Posição, pontos e aproveitamento
  - Jogos, vitórias, empates e derrotas
  - Gols pró, gols contra e saldo de gols
  - Gráficos de progresso visual
- Informações do clube: estádio, técnico e ano de fundação
- Escudo em destaque com animação Hero

### ✅ Recursos Técnicos
- Gerenciamento de estado com Provider
- Dados armazenados localmente em JSON (assets/data)
- Carregamento assíncrono com estados de loading e erro
- Tratamento de erros com opção de retry
- Animações de transição entre telas (Hero animation)
- Design Material 3 com tema personalizado
- Interface responsiva e intuitiva

## 🛠 Tecnologias Utilizadas

- **Flutter**: Framework de desenvolvimento
- **Provider**: Gerenciamento de estado
- **Material Design 3**: Design system
- **JSON**: Armazenamento local de dados

## 📂 Estrutura do Projeto

```
lib/
├── main.dart                          # Ponto de entrada do app
├── models/
│   └── time.dart                      # Modelo de dados do Time
├── providers/
│   └── brasileirao_provider.dart      # Provider para gerenciamento de estado
├── screens/
│   ├── tabela_classificacao_screen.dart  # Tela principal com a tabela
│   └── detalhes_time_screen.dart         # Tela de detalhes do time
├── services/
│   └── brasileirao_service.dart       # Serviço para carregar dados JSON
└── widgets/
    └── escudo_placeholder.dart        # Widget para exibir escudos dos times

assets/
├── data/
│   └── brasileirao_2025.json          # Dados dos 20 times
└── images/                            # Pasta para escudos (placeholders gerados)
```

## 🚀 Como Executar

1. Certifique-se de ter o Flutter instalado:
```bash
flutter --version
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Execute o aplicativo:
```bash
flutter run
```

## 📊 Dados

Os dados dos times estão armazenados em `assets/data/brasileirao_2025.json` e incluem:
- Estatísticas da temporada 2025
- Histórico de títulos brasileiros
- Informações do clube (estádio, técnico, fundação)

## 🎨 Design

O aplicativo segue as diretrizes do Material Design 3 com:
- Tema verde inspirado no futebol brasileiro
- Cards com elevação e bordas arredondadas
- Indicadores visuais coloridos para zonas de classificação
- Animações suaves de transição
- Interface limpa e intuitiva

## 📝 Observações

- Os escudos dos times são gerados como placeholders coloridos com as iniciais
- Para usar imagens reais dos escudos, adicione os arquivos PNG na pasta `assets/images/`
- Os dados são baseados na classificação final do Brasileirão 2024

## 👨‍💻 Desenvolvido por

Luis Eduardo - Atividade 04 - Programação para Dispositivos Móveis

---

**Brasileirão 2025** - Acompanhe o maior campeonato de futebol do Brasil! ⚽🇧🇷
