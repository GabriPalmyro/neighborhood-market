import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/eye_control_cubit.dart';

class MockEyeControlCubit extends MockCubit<bool> implements EyeControlCubit {}

void main() {
  group('EyeControlCubit', () {
    late EyeControlCubit eyeControlCubit;

    setUp(() {
      eyeControlCubit = EyeControlCubit();
    });

    tearDown(() {
      eyeControlCubit.close();
    });

    test('initial state is false', () {
      expect(eyeControlCubit.state, false);
    });

    blocTest<EyeControlCubit, bool>(
      'emits [true] when changeEyeState is called',
      build: () => eyeControlCubit,
      act: (cubit) => cubit.changeEyeState(),
      expect: () => [true],
    );

    blocTest<EyeControlCubit, bool>(
      'emits [false] when changeEyeState is called twice',
      build: () => eyeControlCubit,
      act: (cubit) {
        cubit.changeEyeState();
        cubit.changeEyeState();
      },
      expect: () => [true, false],
    );
  });
}
