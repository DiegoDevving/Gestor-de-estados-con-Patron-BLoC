import 'package:bloc/bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc()
      : super(CounterState(
          count: 0,
          multiplier: 1,
          ownedColors: [true, false, false, false, false, false],
          selectedColorIndex: 0,
        )) {
    on<CounterIncremented>((event, emit) {
      emit(state.copyWith(count: state.count + state.multiplier));
    });

    on<CounterUpgrade>((event, emit) {
      // primera mejora: 100 -> x2
      if (state.multiplier == 1 && state.count >= 100) {
        emit(state.copyWith(count: 0, multiplier: 2));
      }
      // segunda mejora: 300 -> x4
      else if (state.multiplier == 2 && state.count >= 300) {
        emit(state.copyWith(count: 0, multiplier: 4));
      }
    });

    on<BuyColor>((event, emit) {
      if (state.count >= 200 && !state.ownedColors[event.colorIndex]) {
        final updatedColors = [...state.ownedColors];
        updatedColors[event.colorIndex] = true;
        emit(state.copyWith(count: state.count - 200, ownedColors: updatedColors));
      }
    });

    on<ChangeColor>((event, emit) {
      if (state.ownedColors[event.colorIndex]) {
        emit(state.copyWith(selectedColorIndex: event.colorIndex));
      }
    });
  }
}
