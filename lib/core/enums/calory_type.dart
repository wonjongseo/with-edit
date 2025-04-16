enum CaloryType { carbohydrate, protein, fat }

extension CaloryTypeExtension on CaloryType {
  String get label {
    switch (this) {
      case CaloryType.carbohydrate:
        return '탄수화물';
      case CaloryType.protein:
        return '단백질';
      case CaloryType.fat:
        return '지방';
    }
  }
}
