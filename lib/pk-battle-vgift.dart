// import 'dart:math';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Battle App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BattlePage(),
//     );
//   }
// }

// class BattlePage extends StatefulWidget {
//   @override
//   _BattlePageState createState() => _BattlePageState();
// }

// class _BattlePageState extends State<BattlePage> {
//   String battleResult = '';

//   void startBattle() {
//     // Perform PK battle or random battle logic here
//     Random random = Random();
//     bool isWin = random.nextBool();
//     setState(() {
//       battleResult = isWin ? 'Victory!' : 'Defeat!';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Battle Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: startBattle,
//               child: Text('Start Battle'),
//             ),
//             SizedBox(height: 20),
//             Text(
//               battleResult,
//               style: TextStyle(fontSize: 24),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Virtual Gifting App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: GiftPage(),
//     );
//   }
// }

// class GiftPage extends StatefulWidget {
//   @override
//   _GiftPageState createState() => _GiftPageState();
// }

// class _GiftPageState extends State<GiftPage> {
//   int coins = 100;

//   void sendGift() {
//     // Perform virtual gifting logic here
//     // Subtract the gift cost from the available coins
//     int giftCost = 10;
//     if (coins >= giftCost) {
//       setState(() {
//         coins -= giftCost;
//       });
//       // Call backend API to send the virtual gift
//       // Here, you would typically make an HTTP request to your backend server
//       // and handle the response accordingly
//       sendGiftToBackend();
//     } else {
//       // Handle insufficient coins scenario
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Insufficient Coins'),
//             content: Text('You do not have enough coins to send this gift.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   void sendGiftToBackend() {
//     // Implement backend integration logic here
//     // This method will be responsible for calling your backend API
//     // to send the virtual gift. You would typically make an HTTP request
//     // to your server and handle the response accordingly.
//     // You can use packages like 'http' or 'dio' to handle the HTTP requests.
//     // You may need to include headers, parameters, and authentication tokens
//     // as required by your backend API.
//     // Example:
//     // http.post('your_backend_api_url', headers: {
//     //   'Authorization': 'Bearer your_token',
//     // }, body: {
//     //   'giftId': 'your_gift_id',
//     //   'recipientId': 'recipient_id',
//     // }).then((response) {
//     //   // Handle the response from the backend API
//     // }).catchError((error) {
//     //   // Handle error scenarios
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Virtual Gifting Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Coins: $coins',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: sendGift,
//               child: Text('Send Gift'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
