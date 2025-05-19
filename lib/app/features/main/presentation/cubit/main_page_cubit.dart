import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/main/presentation/cubit/main_page_state.dart';

@injectable
class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit() : super(const MainPageChangePage(index: 0));

  void changePage(int index) {
    emit(MainPageChangePage(index: index));
  }
}
