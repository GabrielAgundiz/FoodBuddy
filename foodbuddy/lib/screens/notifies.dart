import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: NotifiesPage(),
  ));
}

class NotifiesPage extends StatefulWidget {
  NotifiesPage({Key? key}) : super(key: key);

  @override
  _NotifiesPageState createState() => _NotifiesPageState();
}

class _NotifiesPageState extends State<NotifiesPage> {
  final List<String> notifications = [
    '45m ago - New Menu: We added a new menu for vegans.',
    '45m ago - Extended Service: VEGAN (Extended service only today.)',
    '1h ago - Know Our New Service',
    '1d ago - We have a new wrapping service that might interest you.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Dismissible(
                  key: Key(notifications[index]),
                  onDismissed: (DismissDirection dir) {
                    setState(() {
                      notifications.removeAt(index);
                    });
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: const Icon(Icons.notifications),
                      title: Text(
                        notifications[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}