import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/time.dart';
import '../services/brasileirao_service.dart';

class BrasileiraoProvider extends ChangeNotifier {
  final BrasileiraoService _service = BrasileiraoService();

  List<Time> _times = [];
  List<Time> _timesFiltrados = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';

  List<Time> get times => _timesFiltrados;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;

  // Theme state
  bool _isDark = false;
  bool get isDark => _isDark;

  static const String _prefKeyIsDark = 'isDarkTheme';

  BrasileiraoProvider() {
    _loadThemeFromPrefs();
  }

  Future<void> _loadThemeFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDark = prefs.getBool(_prefKeyIsDark) ?? false;
      notifyListeners();
    } catch (_) {
      // ignore errors, keep default
    }
  }

  Future<void> toggleTheme() async {
    _isDark = !_isDark;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefKeyIsDark, _isDark);
    } catch (_) {
      // ignore
    }
  }

  Future<void> carregarTimes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _times = await _service.carregarTimes();
      _times.sort((a, b) {
        if (b.pontos != a.pontos) {
          return b.pontos.compareTo(a.pontos);
        }
        if (b.vitorias != a.vitorias) {
          return b.vitorias.compareTo(a.vitorias);
        }
        if (b.saldoGols != a.saldoGols) {
          return b.saldoGols.compareTo(a.saldoGols);
        }
        return b.golsPro.compareTo(a.golsPro);
      });
      _timesFiltrados = List.from(_times);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void buscarTime(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _timesFiltrados = List.from(_times);
    } else {
      _timesFiltrados = _times
          .where(
            (time) => time.nome.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }

  void limparBusca() {
    _searchQuery = '';
    _timesFiltrados = List.from(_times);
    notifyListeners();
  }

  int getPosicao(Time time) {
    return _times.indexOf(time) + 1;
  }

  String getZonaClassificacao(int posicao) {
    if (posicao <= 4) {
      return 'Libertadores (Fase de Grupos)';
    } else if (posicao <= 6) {
      return 'Libertadores (Pré-Libertadores)';
    } else if (posicao <= 12) {
      return 'Sul-Americana';
    } else if (posicao >= 17) {
      return 'Rebaixamento';
    }
    return '';
  }
}
