abstract class MainPageState {
  const MainPageState();
}

class MainPageInitial extends MainPageState {
  const MainPageInitial();
}

class MainPageChangePage extends MainPageState {
  const MainPageChangePage({required this.index});
  final int index;
}
