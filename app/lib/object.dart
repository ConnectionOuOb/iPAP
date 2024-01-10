import 'package:flutter/material.dart';

class IconText {
  bool isOpen;
  String name;
  IconData? icon;
  List<String> children;

  IconText(this.isOpen, this.name, this.icon, this.children);
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
