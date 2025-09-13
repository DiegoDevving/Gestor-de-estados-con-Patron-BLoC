import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter/counter_bloc.dart';
import 'counter/counter_event.dart';
import 'counter/counter_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter con Bloc',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create: (_) => CounterBloc(),
        child: const CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Counter con Bloc'),
          ),
          endDrawer: Drawer(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text("Tienda", style: TextStyle(fontSize: 24)),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(pastelColors.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        if (state.ownedColors[index]) {
                          context.read<CounterBloc>().add(ChangeColor(index));
                        } else {
                          context.read<CounterBloc>().add(BuyColor(index));
                        }
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: pastelColors[index],
                          border: Border.all(
                            color: state.ownedColors[index]
                                ? Colors.black
                                : Colors.grey,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: state.ownedColors[index]
                              ? const Icon(Icons.check, color: Colors.black)
                              : const Text("200"),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          body: Container(
            color: pastelColors[state.selectedColorIndex],
            child: Center(
              child: Text(
                '${state.count}',
                style: const TextStyle(fontSize: 48),
              ),
            ),
          ),
          floatingActionButton: Stack(
            children: [
              // Botón normal de incrementar
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  onPressed: () =>
                      context.read<CounterBloc>().add(CounterIncremented()),
                  child: const Icon(Icons.add),
                ),
              ),
              // Botón de mejora
              Positioned(
                bottom: 80,
                right: 16,
                child: FloatingActionButton(
  backgroundColor: (state.multiplier == 1 && state.count >= 100) ||
                   (state.multiplier == 2 && state.count >= 300)
      ? Colors.orange
      : Colors.grey,
  onPressed: (state.multiplier == 1 && state.count >= 100) ||
             (state.multiplier == 2 && state.count >= 300)
      ? () => context.read<CounterBloc>().add(CounterUpgrade())
      : null,
                  child: const Icon(Icons.upgrade),
                ),
              ),
              // Botón de tienda (centro-derecha)
                            // Botón de tienda (centro-derecha)
              Positioned(
                right: 16,
                top: MediaQuery.of(context).size.height / 2 - 28, // centrado vertical
                child: Builder(
                  builder: (context) => FloatingActionButton(
                    heroTag: "storeButton",
                    backgroundColor: Colors.blueGrey,
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: const Icon(Icons.store),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
