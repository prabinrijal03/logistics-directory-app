import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:logistics_directory_app/data/data_sources/remote_data_source.dart';
import 'package:logistics_directory_app/presentation/pages/home/bloc/home_bloc.dart';
import 'package:logistics_directory_app/data/repository/repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final remoteDataSource = RemoteDataSource(dio);
    final repository = CompanyRepositoryImpl(remoteDataSource);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Search for logistics companies...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) =>
            HomeBloc(repository)..add(const HomeEvent.fetchCompanies()),
        child: Column(
          children: [
            Container(
              color: Colors.red[100],
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text('Top Banner Ad'),
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const Center(child: Text("Start Searching")),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (companies) => GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 3 / 2,
                      ),
                      itemCount: companies.length,
                      itemBuilder: (context, index) {
                        final company = companies[index];
                        return Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  company.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text('Service Type: ${company.serviceType}'),
                                Text('Location: ${company.location}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    error: (message) => Center(child: Text(message)),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('1', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('2', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('3', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Next >',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            Container(
              color: Colors.green,
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Footer - Contact Info | Terms | Privacy Policy',
                      style: TextStyle(color: Colors.white),
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
}
