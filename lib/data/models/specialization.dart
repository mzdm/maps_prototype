class Specialization {
  const Specialization({
    required this.categoryName,
    required this.specializations,
  });

  final String categoryName;
  final List<String> specializations;
}

const specializations = <Specialization>[
  Specialization(categoryName: 'Všechny', specializations: <String>[]),
  Specialization(
    categoryName: 'Dermatovenerologie, kožní',
    specializations: <String>['dermatovenerologie', 'kožní', 'korektivní dermatologie'],
  ),
  Specialization(
    categoryName: 'Gynekologie a porodnictví',
    specializations: <String>[
      'gynekologie a porodnictví',
      'reprodukční medicína',
      'porodní asistentka',
    ],
  ),
  Specialization(
    categoryName: 'Oční',
    specializations: <String>['oftalmologie', 'ortoptista', 'optometrista', 'zrakový terapeut'],
  ),
  Specialization(
    categoryName: 'Praktik',
    specializations: <String>['všeobecné praktické lékařství'],
  ),
  Specialization(
    categoryName: 'Dětský lékař',
    specializations: <String>[
      'dětské lékařství',
      'pediatrie',
      'praktické lékařství pro děti a dorost',
      'dorostové lékařství',
    ],
  ),
  Specialization(
    categoryName: 'Zubař',
    specializations: <String>[
      'zubní lékařství',
      'orální a maxilofaciální chirurgie',
      'ortodoncie',
      'klinická stomatologie',
    ],
  ),
];
