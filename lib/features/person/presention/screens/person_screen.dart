import 'package:dikanak/core/helpers/local_storage/shared_preferences.dart';
import 'package:dikanak/features/person/logic/cubit/person_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/routes.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal,
      ),
      body: BlocBuilder<PersonCubit, PersonState>(
        builder: (context, state) {
          if (state is GetPersonInfoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetPersonInfoFailure) {
            return _buildError(state.message);
          } else if (state is GetPersonInfoSucess) {
            return _buildPersonInfo(state.person, context);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildPersonInfo(user, BuildContext context) {
    if (user == null) {
      return Center(
        child: Text(
          'User data not available',
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(user.image),
          ),
          const SizedBox(height: 16),
          Text(
            user.name,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            user.email,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 4),
          Text(
            user.phone,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          _buildInfoCard(
            icon: Icons.star,
            title: 'Points',
            value: user.points.toString(),
          ),
          const SizedBox(height: 16),
          _buildInfoCard(
            icon: Icons.account_balance_wallet,
            title: 'Credit',
            value: '${user.credit} USD',
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () {
              CacheNetwork.clearData();
              Navigator.pushReplacementNamed(context, Routes.loginScreen);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.redAccent,
            ),
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text(
              'Log Out',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      {required IconData icon, required String title, required String value}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.teal.withValues(alpha: 0.2),
              child: Icon(icon, color: Colors.teal),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message,
          style: const TextStyle(color: Colors.red, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
