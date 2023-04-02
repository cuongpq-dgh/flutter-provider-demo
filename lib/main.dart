import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String data = "John";

  void changeValue(String dataChanged) {
    setState(() {
      data = dataChanged;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Provider.of<AppData>(context, listen: true)._title),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Component1_1(),
                SizedBox(width: 32),
                Component2_1(),
              ],
            ),
          ),
        );
      },
    );
  }
}

// tree 1

class Component1_1 extends StatelessWidget {
  const Component1_1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Component1_2();
  }
}

class Component1_2 extends StatefulWidget {
  const Component1_2({super.key});

  @override
  State<Component1_2> createState() => _Component1_2State();
}

class _Component1_2State extends State<Component1_2> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Widget tree 1"),
          const SizedBox(height: 32),
          Text(Provider.of<AppData>(context, listen: true)._name),
          ElevatedButton(
            onPressed: () {
              Provider.of<AppData>(context, listen: false).resetData();
            },
            child: const Text('Reset data'),
          ),
        ],
      ),
    );
  }
}

// tree 2

class Component2_1 extends StatelessWidget {
  const Component2_1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Component2_2();
  }
}

class Component2_2 extends StatelessWidget {
  const Component2_2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Component2_3();
  }
}

class Component2_3 extends StatefulWidget {
  const Component2_3({super.key});

  @override
  State<Component2_3> createState() => _Component2_3State();
}

class _Component2_3State extends State<Component2_3> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Widget tree 2"),
          SizedBox(
            width: 80,
            child: TextFormField(
              controller:
                  Provider.of<AppData>(context, listen: true)._controller,
              onChanged: (value) {
                Provider.of<AppData>(context, listen: false).changeName(value);
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              var getCtrl =
                  Provider.of<AppData>(context, listen: false)._controller;
              Provider.of<AppData>(context, listen: false).changeTitle(getCtrl.text);
            },
            child: const Text('Change title'),
          ),
        ],
      ),
    );
  }
}

class AppData with ChangeNotifier {
  String _name = 'Rambo';
  String _title = "Flutter Provider Demo";
  TextEditingController _controller = TextEditingController();

  void changeName(String value) {
    _name = value;
    notifyListeners();
  }

  void changeTitle(String value) {
    _title = value;
    notifyListeners();
  }

  void resetData() {
    _name = "Rambo";
    _title = "Flutter Provider Demo";
    _controller.clear();
    notifyListeners();
  }
}
