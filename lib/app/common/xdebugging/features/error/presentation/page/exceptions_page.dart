import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/xdebugging/features/error/data/models/exception_catch.dart';
import 'package:neighborhood_market/app/common/xdebugging/features/error/di/error_module.dart';
import 'package:neighborhood_market/app/common/xdebugging/features/error/presentation/widgets/exception_tile_widget.dart';

import '../../../../core/data/models/debugging_model.dart';
import '../../../../core/data/repository/shared_preferences_repository.dart';
import '../../../../presentation/state/screen_result.dart';

class ExceptionsPage extends StatefulWidget {
  const ExceptionsPage({super.key});

  @override
  State<ExceptionsPage> createState() => _ExceptionsPageState();
}

class _ExceptionsPageState extends State<ExceptionsPage> {
  ScreenResult<List<DebuggingModel>> _result = const ScreenResult();
  final SharedPreferencesRepository _repository = ExceptionModule().repository;

  @override
  void initState() {
    super.initState();
    _asyncInit();
  }

  Future<void> _asyncInit() async {
    try {
      final data = await _repository.findAll();

      setState(() {
        _result = _result.copyWith(
          newResult: data,
          newStatus: ScreenStatus.success,
        );
      });
    } catch (e) {
      setState(() {
        _result = _result.copyWith(
          newStatus: ScreenStatus.error,
        );
      });
    }
  }

  Future<void> deleteAndReload() async {
    await _repository.deleteAll();
    await _asyncInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: deleteAndReload,
        child: const Icon(Icons.delete),
      ),
      body: Stack(
        children: [
          if (_result.status == ScreenStatus.loading) ...{
            const Center(child: CircularProgressIndicator()),
          } else if (_result.status == ScreenStatus.error) ...{
            const Center(child: Text('Error')),
          } else if (_result.status == ScreenStatus.success) ...{
            CustomScrollView(
              slivers: [
                const SliverAppBar(
                  title: Text('Exceptions'),
                  floating: true,
                  snap: true,
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 10, left: 14, right: 14),
                  sliver: SliverList.separated(
                    itemBuilder: (_, index) {
                      final exception = _result.result![index] as ExceptionCatch;
                      return ExceptionTile(exception: exception);
                    },
                    separatorBuilder: (_, __) => const Divider(),
                    itemCount: _result.result?.length ?? 0,
                  ),
                ),
              ],
            ),
          },
        ],
      ),
    );
  }
}
