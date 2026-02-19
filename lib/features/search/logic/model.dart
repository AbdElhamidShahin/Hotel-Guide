import 'package:flutter/material.dart';

class FilterOptions {
  RangeValues priceRange;
  String? city;
  String? view;
  double? rating;

  FilterOptions({
    this.priceRange = const RangeValues(1000, 2000),
    this.city,
    this.view,
    this.rating,
  });
}