abstract class CounterEvent {}

class CounterIncremented extends CounterEvent {}

class CounterUpgrade extends CounterEvent {}

class BuyColor extends CounterEvent {
  final int colorIndex;
  BuyColor(this.colorIndex);
}

class ChangeColor extends CounterEvent {
  final int colorIndex;
  ChangeColor(this.colorIndex);
}
