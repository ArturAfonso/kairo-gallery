import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Extensão customizada que permite acessar as cores do Kairo Gallery diretamente.
/// Com isso, você evita condicionais (if/else) nos seus Widgets.
class KairoColors extends ThemeExtension<KairoColors> {
  final Color cream;
  final Color areia;
  final Color areiaProfunda;
  final Color terracota;
  final Color terracotaEscuro;
  final Color oliva;
  final Color cafe;
  final Color cardBackground;

  const KairoColors({
    required this.cream,
    required this.areia,
    required this.areiaProfunda,
    required this.terracota,
    required this.terracotaEscuro,
    required this.oliva,
    required this.cafe,
    required this.cardBackground,
  });

  @override
  KairoColors copyWith({
    Color? cream,
    Color? areia,
    Color? areiaProfunda,
    Color? terracota,
    Color? terracotaEscuro,
    Color? oliva,
    Color? cafe,
    Color? cardBackground,
  }) {
    return KairoColors(
      cream: cream ?? this.cream,
      areia: areia ?? this.areia,
      areiaProfunda: areiaProfunda ?? this.areiaProfunda,
      terracota: terracota ?? this.terracota,
      terracotaEscuro: terracotaEscuro ?? this.terracotaEscuro,
      oliva: oliva ?? this.oliva,
      cafe: cafe ?? this.cafe,
      cardBackground: cardBackground ?? this.cardBackground,
    );
  }

  @override
  KairoColors lerp(ThemeExtension<KairoColors>? other, double t) {
    if (other is! KairoColors) return this;
    return KairoColors(
      cream: Color.lerp(cream, other.cream, t)!,
      areia: Color.lerp(areia, other.areia, t)!,
      areiaProfunda: Color.lerp(areiaProfunda, other.areiaProfunda, t)!,
      terracota: Color.lerp(terracota, other.terracota, t)!,
      terracotaEscuro: Color.lerp(terracotaEscuro, other.terracotaEscuro, t)!,
      oliva: Color.lerp(oliva, other.oliva, t)!,
      cafe: Color.lerp(cafe, other.cafe, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
    );
  }
}

/// Classe principal que seu MaterialApp vai consumir através do Cubit
class AppTheme {
  // Paleta de cores estáticas extraídas do design system
  static const _cream = Color(0xFFFAF6F0);
  static const _areia = Color(0xFFF2E8DC);
  static const _areiaProfunda = Color(0xFFE8DCC8);
  static const _terracota = Color(0xFFB5654A);
  static const _terracotaEscuro = Color(0xFF8C4A32);
  static const _oliva = Color(0xFF6B7A5E);
  static const _cafe = Color(0xFF2B211C);

  // Cor do card para o modo dark (baseado nas variáveis oklch do styles.css)
  static const _cardDark = Color(0xFF423732);

  /// --- CONFIGURAÇÃO LIGHT THEME ---
  static ThemeData get light {
    return _buildTheme(
      brightness: Brightness.light,
      background: _cream,
      foreground: _cafe,
      cardBg: const Color(0xFFFCFAF7), // Fundo de card sutilmente mais claro no modo claro
      surfaceContainer: _areia,
      mutedText: _cafe.withOpacity(0.6),
    );
  }

  /// --- CONFIGURAÇÃO DARK THEME ---
  static ThemeData get dark {
    return _buildTheme(
      brightness: Brightness.dark,
      background: _cafe, // No modo dark o fundo vira o café[cite: 1]
      foreground: _cream, // O texto vira o cream[cite: 1]
      cardBg: _cardDark, // Tom do container interno escuro[cite: 1]
      surfaceContainer: const Color(0xFF3B312C),
      mutedText: const Color(0xFFB5A8A0),
    );
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color background,
    required Color foreground,
    required Color cardBg,
    required Color surfaceContainer,
    required Color mutedText,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: background,

      colorScheme: ColorScheme(
        brightness: brightness,
        primary: _terracota,
        onPrimary: _cream,
        secondary: _oliva,
        onSecondary: _cream,
        error: _terracotaEscuro,
        onError: _cream,
        surface: background,
        onSurface: foreground,
        surfaceContainer: surfaceContainer,
        surfaceContainerHighest: surfaceContainer,
      ),

      textTheme: TextTheme(
        displayMedium: GoogleFonts.fraunces(fontSize: 32, fontWeight: FontWeight.bold, color: foreground),
        titleLarge: GoogleFonts.fraunces(fontSize: 24, fontWeight: FontWeight.w600, color: foreground),
        bodyLarge: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.normal, color: foreground),
        bodyMedium: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.normal, color: mutedText),
        labelLarge: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.bold, color: foreground),
      ),

      // Injeção automática da extensão correspondente a este tema
      extensions: [
        KairoColors(
          cream: _cream,
          areia: _areia,
          areiaProfunda: _areiaProfunda,
          terracota: _terracota,
          terracotaEscuro: _terracotaEscuro,
          oliva: _oliva,
          cafe: _cafe,
          cardBackground: cardBg,
        ),
      ],
    );
  }
}

/// Extensão utilitária para chamar as cores de forma muito veloz via context
extension KairoThemeBuildContextProps on BuildContext {
  KairoColors get kairoColors => Theme.of(this).extension<KairoColors>()!;
  TextTheme get kairoText => Theme.of(this).textTheme;
}


/**
 * Container(
  decoration: BoxDecoration(
    // Retorna #FCFAF7 no Light ou #423732 no Dark! Sem IF nenhum!
    color: context.kairoColors.cardBackground, 
    borderRadius: BorderRadius.circular(16),
  ),
  padding: const EdgeInsets.all(16),
  child: Row(
    children: [
      Text(
        'IMG_0020.jpg',
        style: context.kairoText.bodyLarge, // Tipografia Nunito dinâmica
      ),
    ],
  ),
);


ou


Icon(
  Icons.delete,
  color: context.kairoColors.terracota, // Sempre trará o #B5654A independente do tema
)
 */