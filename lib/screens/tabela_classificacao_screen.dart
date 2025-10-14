import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/brasileirao_provider.dart';
import '../models/time.dart';
import '../widgets/escudo_placeholder.dart';
import 'detalhes_time_screen.dart';

class TabelaClassificacaoScreen extends StatefulWidget {
  const TabelaClassificacaoScreen({super.key});

  @override
  State<TabelaClassificacaoScreen> createState() =>
      _TabelaClassificacaoScreenState();
}

class _TabelaClassificacaoScreenState extends State<TabelaClassificacaoScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BrasileiraoProvider>().carregarTimes();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Color _getCorZona(int posicao) {
    if (posicao <= 4) {
      return const Color(0xFF1E88E5); // Azul para Libertadores
    } else if (posicao <= 6) {
      return Colors.green.shade400;
    } else if (posicao <= 12) {
      return Colors.orange.shade600;
    } else if (posicao >= 17) {
      return Colors.red.shade700;
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Brasileirão 2025',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        actions: [
          Consumer<BrasileiraoProvider>(
            builder: (context, prov, child) {
              return IconButton(
                tooltip: prov.isDark ? 'Usar tema claro' : 'Usar tema escuro',
                icon: Icon(prov.isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: () => prov.toggleTheme(),
              );
            },
          ),
        ],
      ),
      body: Consumer<BrasileiraoProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Carregando dados...'),
                ],
              ),
            );
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Erro ao carregar dados',
                    style: TextStyle(fontSize: 18, color: Colors.red[700]),
                  ),
                  const SizedBox(height: 8),
                  Text(provider.errorMessage!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.carregarTimes(),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Container(
                color: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _searchController,
                  onChanged: provider.buscarTime,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Buscar time...',
                    hintStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    suffixIcon: provider.searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.white),
                            onPressed: () {
                              _searchController.clear();
                              provider.limparBusca();
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: provider.times.isEmpty
                    ? const Center(child: Text('Nenhum time encontrado'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: provider.times.length,
                        itemBuilder: (context, index) {
                          final time = provider.times[index];
                          final posicao = provider.getPosicao(time);
                          return _buildTimeCard(
                            context,
                            time,
                            posicao,
                            provider,
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTimeCard(
    BuildContext context,
    Time time,
    int posicao,
    BrasileiraoProvider provider,
  ) {
    final corZona = _getCorZona(posicao);
    final zonaDescricao = provider.getZonaClassificacao(posicao);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: corZona,
          width: corZona != Colors.transparent ? 3 : 0,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DetalhesTimeScreen(time: time, posicao: posicao),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: corZona != Colors.transparent
                          ? corZona
                          : Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$posicao',
                        style: TextStyle(
                          color: corZona != Colors.transparent
                              ? Colors.white
                              : Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  EscudoPlaceholder(
                    nomeTime: time.nome,
                    size: 40,
                    escudoPath: time.escudo,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          time.nome,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (zonaDescricao.isNotEmpty)
                          Text(
                            zonaDescricao,
                            style: TextStyle(
                              fontSize: 11,
                              color: corZona,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${time.pontos}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('J', time.jogos.toString()),
                  _buildStatItem('V', time.vitorias.toString(), Colors.green),
                  _buildStatItem('E', time.empates.toString(), Colors.orange),
                  _buildStatItem('D', time.derrotas.toString(), Colors.red),
                  _buildStatItem('GP', time.golsPro.toString()),
                  _buildStatItem('GC', time.golsContra.toString()),
                  _buildStatItem(
                    'SG',
                    time.saldoGols > 0
                        ? '+${time.saldoGols}'
                        : '${time.saldoGols}',
                    time.saldoGols > 0
                        ? Colors.green
                        : (time.saldoGols < 0 ? Colors.red : null),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, [Color? valueColor]) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor ?? Colors.black87,
          ),
        ),
      ],
    );
  }
}
