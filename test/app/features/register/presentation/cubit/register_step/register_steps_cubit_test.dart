import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neighborhood_market/app/common/local_database/local_database.dart';
import 'package:neighborhood_market/app/features/register/domain/entity/register_steps_enum.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/register_step/register_steps_cubit.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/register_step/register_steps_state.dart';
import 'package:neighborhood_market/app/features/register/utils/register_string.dart';

class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  late RegisterStepsCubit cubit;
  late MockLocalStorage mockLocalStorage;

  group('RegisterStepsCubit', () {
    setUp(() {
      mockLocalStorage = MockLocalStorage();
      cubit = RegisterStepsCubit(mockLocalStorage);

      when(() => mockLocalStorage.saveData<int>(any(), any())).thenAnswer((_) async {});
      when(() => mockLocalStorage.getData<int?>(any())).thenAnswer((_) async => null);
    });

    blocTest<RegisterStepsCubit, RegisterStepsState>(
      'initial state is RegisterCurrentStep with stepOne',
      build: () => cubit,
      verify: (cubit) => expect(cubit.state, const RegisterCurrentStep(currentStep: RegisterStep.stepOne)),
    );

    blocTest<RegisterStepsCubit, RegisterStepsState>(
      'init loads step from local storage and updates state',
      setUp: () {
        when(() => mockLocalStorage.getData<int?>(RegisterStrings.stepLocalKey)).thenAnswer(
          (_) async => 1,
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.init(),
      verify: (cubit) {
        expect(cubit.state, const RegisterCurrentStep(currentStep: RegisterStep.stepTwo));
        verify(() => mockLocalStorage.getData<int?>(RegisterStrings.stepLocalKey)).called(1);
      },
    );

    blocTest<RegisterStepsCubit, RegisterStepsState>(
      'changeStep updates state and saves step to local storage',
      build: () => cubit,
      act: (cubit) => cubit.changeStep(RegisterStep.stepThree),
      verify: (cubit) {
        expect(cubit.state, const RegisterCurrentStep(currentStep: RegisterStep.stepThree));
        verify(
          () => mockLocalStorage.saveData<int>(
            RegisterStrings.stepLocalKey,
            RegisterStep.stepThree.stepIndex,
          ),
        ).called(1);
      },
    );

    blocTest<RegisterStepsCubit, RegisterStepsState>(
      'backStep changes to previous step',
      build: () => cubit,
      act: (cubit) async {
        await cubit.changeStep(RegisterStep.stepThree);
        cubit.backStep();
      },
      verify: (cubit) => expect(cubit.state, const RegisterCurrentStep(currentStep: RegisterStep.stepTwo)),
    );

    blocTest<RegisterStepsCubit, RegisterStepsState>(
      'nextStep changes to next step',
      build: () => cubit,
      act: (cubit) async {
        await cubit.changeStep(RegisterStep.stepTwo);
        cubit.nextStep();
      },
      verify: (cubit) => expect(cubit.state, const RegisterCurrentStep(currentStep: RegisterStep.stepThree)),
    );
  });
}
