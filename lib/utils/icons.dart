class AppIcons {
  static const Map<int, String> availableIcons = {
    0: 'assets/svgs/categoryIcons/bicicleta.svg',
    1: 'assets/svgs/categoryIcons/bus.svg',
    2: 'assets/svgs/categoryIcons/car.svg',
    3: 'assets/svgs/categoryIcons/cash.svg',
    4: 'assets/svgs/categoryIcons/comida.svg',
    5: 'assets/svgs/categoryIcons/face.svg',
    6: 'assets/svgs/categoryIcons/hearth.svg',
    7: 'assets/svgs/categoryIcons/Icon.svg',
    8: 'assets/svgs/categoryIcons/maleta.svg',
    9: 'assets/svgs/categoryIcons/palace.svg',
    10: 'assets/svgs/categoryIcons/paper.svg',
    11: 'assets/svgs/categoryIcons/shopping.svg',
  };

  // Obtener el índice basado en el path
  static int getIconIndex(String iconPath) {
    return availableIcons.entries
        .firstWhere(
          (e) => e.value == iconPath,
          orElse: () => const MapEntry(7, 'assets/svgs/categoryIcons/Icon.svg'),
        )
        .key;
  }

  // Obtener el path basado en el índice
  static String getIconPath(int iconIndex) {
    return availableIcons[iconIndex] ?? availableIcons[7]!;
  }
}
