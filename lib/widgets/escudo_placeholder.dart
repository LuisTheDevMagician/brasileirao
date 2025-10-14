import 'package:flutter/material.dart';

class EscudoPlaceholder extends StatelessWidget {
  final String nomeTime;
  final double size;
  final String? escudoPath;

  const EscudoPlaceholder({
    super.key,
    required this.nomeTime,
    this.size = 50,
    this.escudoPath,
  });

  Color _getColorForTeam(String nome) {
    final colors = {
      'Palmeiras': Colors.green,
      'Flamengo': Colors.red,
      'Cruzeiro': Colors.blue,
      'Mirassol': Colors.yellow,
      'Botafogo': Colors.black,
      'Bahia': Colors.blue,
      'Fluminense': Colors.green,
      'São Paulo': Colors.red,
      'Bragantino': Colors.red,
      'Ceará': Colors.black,
      'Vasco da Gama': Colors.black,
      'Corinthians': Colors.black,
      'Grêmio': Colors.blue,
      'Atlético-MG': Colors.black,
      'Internacional': Colors.red,
      'Santos': Colors.white,
      'Vitória': Colors.red,
      'Fortaleza': Colors.blue,
      'Juventude': Colors.green,
      'Sport Recife': Colors.red,
    };
    return colors[nome] ?? Colors.grey;
  }

  String _getInitials(String nome) {
    final words = nome.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return nome.substring(0, nome.length >= 2 ? 2 : 1).toUpperCase();
  }

  Widget _buildPlaceholder() {
    final color = _getColorForTeam(nomeTime);
    final initials = _getInitials(nomeTime);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: color == Colors.white || color == Colors.yellow
                ? Colors.black
                : Colors.white,
            fontSize: size * 0.35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (escudoPath == null || escudoPath!.isEmpty) {
      return _buildPlaceholder();
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          escudoPath!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholder();
          },
        ),
      ),
    );
  }
}
