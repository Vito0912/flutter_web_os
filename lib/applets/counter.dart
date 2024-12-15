import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Counter extends HookWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Counter Display
          Text(
            'Counter: ${counter.value}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          // Increment Button
          FilledButton(
            onPressed: () {
              counter.value++;
            },
            child: const Text('Increment'),
          ),
          const SizedBox(height: 10),
          // Decrement Button
          Button(
            onPressed: counter.value > 0
                ? () {
                    counter.value--;
                  }
                : null, // Disable if counter is 0
            child: const Text('Decrement'),
          ),
        ],
      ),
    );
  }
}
