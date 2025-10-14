import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/time.dart';

class BrasileiraoService {
  Future<List<Time>> carregarTimes() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/brasileirao_2025.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> timesJson = jsonData['times'];
      
      return timesJson.map((json) => Time.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Erro ao carregar dados: $e');
    }
  }
}
