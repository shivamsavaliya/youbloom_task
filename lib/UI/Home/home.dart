import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youbloom_task/Constants/constants.dart';
import '../../Bloc/HomeBloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home Page',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: mainColor,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: mainColor,
                onChanged: (value) {
                  homeBloc.add(SearchEvent(data: value));
                },
                decoration: InputDecoration(
                  hintText: "Search by Name",
                  contentPadding: EdgeInsets.zero,
                  constraints: BoxConstraints(
                    maxHeight: 50,
                    maxWidth: MediaQuery.of(context).size.width * 0.90,
                  ),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: mainColor),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: mainColor),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: mainColor),
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            BlocConsumer<HomeBloc, HomeState>(
              bloc: homeBloc,
              listenWhen: (previous, current) => current is PostActionState,
              buildWhen: (previous, current) => current is! PostActionState,
              listener: (context, state) {
                if (state is PostFetchingErrorfulState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Error occured while fetching the data"),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is PostFetchingLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PostFetchingSuccessfulState) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.data.length,
                      itemBuilder: (context, index) => Card(
                        margin: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.data[index].name.toString(),
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                state.data[index].phone.toString(),
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                state.data[index].email.toString(),
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                state.data[index].website.toString(),
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                state.data[index].company!.name.toString(),
                                style: Theme.of(context).textTheme.labelLarge,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (state is SearchSuccessfullState) {
                  if (state.results.isEmpty) {
                    return const Center(child: Text('No results found.'));
                  }
                  return ListView.builder(
                    itemCount: state.results.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.results[index].name!),
                      );
                    },
                  );
                }
                return const Center(child: Text('Not getting anything'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
