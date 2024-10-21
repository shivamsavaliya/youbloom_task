import 'package:flutter/material.dart';
import 'package:youbloom_task/Constants/constants.dart';
import 'package:youbloom_task/Models/home_data_model.dart';
import 'package:youbloom_task/UI/home.dart';

class DetailPage extends StatelessWidget {
  final HomeDataModel data;
  const DetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
            (route) => true,
          );
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor,
            leading: BackButton(
              color: Colors.white,
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
                (route) => true,
              ),
            ),
            title: Text(
              data.name.toString(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Address:",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "${data.address!.suite!}, ${data.address!.street!}, ${data.address!.city!}, ${data.address!.zipcode!}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Company:",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  data.company!.name!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
