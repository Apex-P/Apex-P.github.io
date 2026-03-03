import 'package:fluent_ui/fluent_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const FluentApp(
      title: 'Apex Pawn - Password Reset',
      home: ScaffoldPage(content: Center(child: Text('Hey there'))),
    );
  }
}
