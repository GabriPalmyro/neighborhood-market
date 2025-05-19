import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons_data.dart';


abstract class SupportIcons {
  IconAssetData icon(String name);
}

// ignore: avoid_classes_with_only_static_members
class DSIcons {
  static const eyeClosed = IconAssetData('eye_closed');
  static const eyeOpen = IconAssetData('eye_open');
  static const calendar = IconAssetData('calendar');
  static const chevronDown = IconAssetData('chevron_down');
  static const home = IconAssetData('home');
  static const share = IconAssetData('share');
  static const search = IconAssetData('search');
  static const searchFilled = IconAssetData('search_filled');
  static const notifications = IconAssetData('notifications');
  static const heartFilled = IconAssetData('heart_filled');
  static const profile = IconAssetData('profile');
  static const check = IconAssetData('check');
  static const upload = IconAssetData('upload');
  static const camera = IconAssetData('camera');
  static const info = IconAssetData('info');
  static const close = IconAssetData('close');
  static const tag = IconAssetData('tag');
  static const arrowBack = IconAssetData('arrow_back');
  static const box = IconAssetData('box');
  static const union = IconAssetData('union');
  static const categories = IconAssetData('categories');
  static const filter = IconAssetData('filter');
  static const verticalDots = IconAssetData('vertical_dots');
  static const trash = IconAssetData('trash');
  static const trashOutlined = IconAssetData('trash_outlined');
  static const edit = IconAssetData('edit');
  static const hanger = IconAssetData('hanger');

  // categories icons
  static const footwear = IconAssetData('categories/salto-alto');
  static const clothing = IconAssetData('categories/camiseta');
  static const accessories = IconAssetData('categories/bolsa-de-ombro');
  static const bags = IconAssetData('categories/bolsa');
  static const watches = IconAssetData('categories/relogio-de-pulso');
  static const belts = IconAssetData('categories/cinto');
  static const hats = IconAssetData('categories/chapeu');
  static const jewelry = IconAssetData('categories/diamante');
  static const scarves = IconAssetData('categories/cachecol');
  static const sweater = IconAssetData('categories/agasalho');
  static const raincoat = IconAssetData('categories/capa-de-chuva');
  static const coat = IconAssetData('categories/casaco');
  static const jeans = IconAssetData('categories/jeans');
  static const socks = IconAssetData('categories/meias');
  static const sunglasses = IconAssetData('categories/oculos-de-sol');
  static const highHeels = IconAssetData('categories/salto-alto');
  static const sneakers = IconAssetData('categories/tenis');
  static const runShoes = IconAssetData('categories/tenis-de-corrida');
  static const flipFlop = IconAssetData('categories/sandalia-de-dedo');
  static const shorts = IconAssetData('categories/shorts');
  static const shortsJeans = IconAssetData('categories/shorts-jeans');
  static const groomSuit = IconAssetData('categories/terno-de-noivo');
  static const dress = IconAssetData('categories/vestido');




  static IconAssetData fromString(String name) {
    return IconAssetData(name);
  }
}
