import 'package:flutter/material.dart';

class IconText {
  String name;
  IconData? icon;

  IconText(this.name, this.icon);
}

class Algorithm {
  String alias;
  String name;
  List<SelectItem> engines;
  List<SelectItem> databases;

  Algorithm(this.alias, this.name, this.engines, this.databases);
}

class SelectItem {
  bool selected;
  String name;

  SelectItem(this.selected, this.name);
}
