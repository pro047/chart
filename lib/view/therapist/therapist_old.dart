// import 'package:flutter/material.dart';
// import 'package:mysql_client/mysql_client.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Therapist extends StatefulWidget {
//   const Therapist({super.key});

//   @override
//   State<Therapist> createState() => _TherapistState();
// }

// class _TherapistState extends State<Therapist> {
//   Future<String> getName() async {
//     final conn = await dbConnector();

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString('token')!;

//     IResultSet result;

//     try {
//       int intToken = int.parse(token);
//       result = await conn.execute(
//         'SELECT name FROM user where id = :intToken',
//         {'intToken': intToken},
//       );

//       for (final row in result.rows) {
//         String therapistName = row.colByName('name')!;
//         return therapistName;
//       }
//     } catch (e) {
//       print('Error1 : $e');
//       rethrow;
//     } finally {
//       conn.close();
//     }
//     return '-1';
//   }

//   List<Widget> items = [];

//   void addItems() {
//     setState(() {
//       items.add(TextField(decoration: InputDecoration(labelText: 'To Do')));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//         child: Scaffold(
//           body: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 50),
//                   Container(
//                     child: Row(
//                       children: [
//                         FutureBuilder(
//                           future: getName(),
//                           builder: (context, snapshot) {
//                             if (!snapshot.hasData) {
//                               return CircularProgressIndicator();
//                             } else if (snapshot.hasError) {
//                               return throw Error();
//                             } else {
//                               print(snapshot.data);
//                               return Text(
//                                 '${snapshot.data} 치료사님 안녕하세요',
//                                 style: TextStyle(fontSize: 25),
//                               );
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(child: Text('To Do List')),

//                   ElevatedButton(
//                     onPressed: () {
//                       addItems();
//                     },
//                     child: Icon(Icons.add),
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: items.length,
//                       itemBuilder: (context, index) {
//                         return Dismissible(
//                           key: ValueKey(items[index]),
//                           background: Container(
//                             color: Colors.red,
//                             alignment: Alignment.center,
//                             child: Text(
//                               'delete',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.all(10),
//                             child: items[index],
//                           ),
//                           onDismissed: (direction) {
//                             setState(() {
//                               items.removeAt(index);
//                             });
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
