// import 'package:dikanak/features/auth/logic/cubits/cubit/auth_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class PersonScreen extends StatelessWidget {
//   const PersonScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // final authCubit = context.read<AuthCubit>();
//     // final user = authCubit.usermodel;
// //TODO get user profile in home cubit
//     if (user == null) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Person Details'),
//         ),
//         body: Center(
//           child: Text(
//             'User data not available',
//             style: TextStyle(fontSize: 18, color: Colors.red),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Person Details'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: 50,
//               backgroundImage: NetworkImage(user.image),
//             ),
//             SizedBox(height: 16),
//             Text(
//               user.name,
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text(
//               user.email,
//               style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//             ),
//             SizedBox(height: 8),
//             Text(
//               user.phone,
//               style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
