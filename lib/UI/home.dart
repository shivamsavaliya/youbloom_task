import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youbloom_task/Constants/constants.dart';
import 'package:youbloom_task/Models/home_data_model.dart';
import 'package:youbloom_task/UI/details_page.dart';
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
              listener: (context, state) {
                if (state is PostFetchingErrorfulState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Error occured while fetching the data"),
                    ),
                  );
                } else if (state is GetDetailsState) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        data: state.data,
                      ),
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
                    child: _buildListView(state.data),
                  );
                } else if (state is SearchSuccessfullState) {
                  if (state.results.isEmpty) {
                    return const Center(child: Text('No results found.'));
                  }
                  return Expanded(
                    child: _buildListView(state.results),
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

  Widget _buildListView(List<HomeDataModel> data) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) => _buildListItem(data[index]),
    );
  }

  Widget _buildListItem(HomeDataModel item) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: InkWell(
          onTap: () => homeBloc.add(NameClickEvent(data: item)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name.toString(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                item.phone.toString(),
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
