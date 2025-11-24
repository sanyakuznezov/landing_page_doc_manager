part of '../home.dart';

enum HomePricingType { month, year, forever }

extension HomePricingTypeExtension on HomePricingType {
  String get label {
    switch (this) {
      case HomePricingType.month:
        return 'месяц';
      case HomePricingType.year:
        return 'год';
      case HomePricingType.forever:
        return 'навсегда';
    }
  }
}

@model
class HomePricingModel extends DModel {
  const HomePricingModel({
    required this.title,
    required this.price,
    required this.benefits,
    required this.type,
  });

  @variable
  final String title;

  @variable
  final int price;

  @variable
  final String benefits;

  @Variable(defaultsTo: HomePricingType.month)
  final HomePricingType type;
}
