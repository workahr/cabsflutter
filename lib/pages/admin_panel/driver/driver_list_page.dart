import 'package:flutter/material.dart';


class DriverList extends StatefulWidget {
  const DriverList({Key? key}) : super(key: key);

  @override
  State<DriverList> createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {

  final List<Map<String, String>> drivers = List.generate(
    10,
    (index) => {
      'name': 'Shiva Kumar',
      'id': '#5632225856',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver List'),
        backgroundColor: const Color(0xFF06234C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
        
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: drivers.length,
        itemBuilder: (context, index) {
          return DriverListItem(
            name: drivers[index]['name']!,
            id: drivers[index]['id']!,
            onEdit: () {
      
            },
          );
        },
      ),
    );
  }
}

class DriverListItem extends StatelessWidget {
  final String name;
  final String id;
  final VoidCallback onEdit;

  const DriverListItem({
    Key? key,
    required this.name,
    required this.id,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFE6EEF8),
            child: Icon(Icons.person, color: Color(0xFF06234C)),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  id,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: onEdit,
            icon: const Icon(Icons.edit, size: 16.0),
            label: const Text('Edit'),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF06234C)),
             // primary: const Color(0xFF06234C),
            ),
          ),
        ],
      ),
    );
  }
}
