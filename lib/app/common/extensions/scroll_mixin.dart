import 'package:flutter/material.dart';

mixin ScrollMixin {
  ScrollController get scrollController;

  bool get isBottom {
    if (!scrollController.hasClients) {
      return false;
    }
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}