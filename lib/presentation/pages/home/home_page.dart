import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_directory_app/app/extensions/build_context_entensions.dart';
import 'package:logistics_directory_app/resources/route_manager.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(const HomeEvent.started()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          title: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.isMobile
                  ? 10
                  : context.isDesktop
                      ? 250
                      : 20,
            ),
            child: TextField(
              onChanged: (query) =>
                  context.read<HomeBloc>().add(HomeEvent.searchChanged(query)),
              decoration: InputDecoration(
                hintText: 'Search for logistics companies...',
                filled: true,
                fillColor: context.surfaceColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search, color: context.disabledColor),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            if (context.isMobile || context.isSmallTablet)
              _buildMobileLayout(context)
            else
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.115,
                    child: _buildDesktopLayout(context),
                  ),
                  Positioned(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () => context
                                  .read<HomeBloc>()
                                  .add(const HomeEvent.loadPreviousPage()),
                              child: const Text('< Prev'),
                            ),
                            TextButton(
                              onPressed: () => context
                                  .read<HomeBloc>()
                                  .add(const HomeEvent.loadNextPage()),
                              child: const Text('Next >'),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoute.dashboardPage.path);
                                },
                                child: Text("Dashboard"))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildTopBannerAd(context),
        Expanded(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return _buildCompanyList(context, state);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => context
                  .read<HomeBloc>()
                  .add(const HomeEvent.loadPreviousPage()),
              child: const Text('< Prev'),
            ),
            TextButton(
              onPressed: () =>
                  context.read<HomeBloc>().add(const HomeEvent.loadNextPage()),
              child: const Text('Next >'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoute.dashboardPage.path);
                },
                child: Text("Dashboard"))
          ],
        ),
        _buildSidebarAds(context),
        _buildFooter(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildTopBannerAd(context),
                    Expanded(
                      child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          return _buildCompanyList(context, state);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              _buildSidebarAds(context),
            ],
          ),
        ),
        _buildFooter(context),
      ],
    );
  }

  Widget _buildTopBannerAd(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.ads.isEmpty) {
          return Container(
            color: Colors.grey.withOpacity(0.2),
            height: 50,
            alignment: Alignment.center,
            child: const Text('Top Banner Ad'),
          );
        }

        final ad = state.ads.first;
        return Padding(
          padding: const EdgeInsets.only(left: 80.0, right: 80.0),
          child: Image.network(
            ad.imageUrl,
            fit: BoxFit.fill,
            height: 70,
            width: double.infinity,
          ),
        );
      },
    );
  }

  Widget _buildSidebarAds(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.ads.isEmpty) {
          return Container();
        }

        final ad1 = state.ads.length > 1 ? state.ads[1] : null;
        final ad2 = state.ads.length > 2 ? state.ads[2] : null;

        if (ad1 == null && ad2 == null) {
          return Container();
        }

        if (context.isMobile) {
          return SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                if (ad1 != null)
                  Container(
                    width: context.width / 2.5,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Image.network(ad1.imageUrl, fit: BoxFit.cover),
                  ),
                if (ad2 != null)
                  Container(
                    width: context.width / 2.5,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Image.network(ad2.imageUrl, fit: BoxFit.fill),
                  ),
              ],
            ),
          );
        } else {
          return SingleChildScrollView(
            child: SizedBox(
              width: context.width / 6.5,
              child: Column(
                children: [
                  if (ad1 != null)
                    Container(
                      height: 220,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Image.network(ad1.imageUrl, fit: BoxFit.fill),
                    ),
                  if (ad2 != null)
                    SizedBox(
                      height: 220,
                      child: Image.network(ad2.imageUrl, fit: BoxFit.fill),
                    ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.green,
          height: 50,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: const Text(
            'Contact Info | Terms | Privacy Policy',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyList(BuildContext context, HomeState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.errorMessage!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  context.read<HomeBloc>().add(const HomeEvent.started()),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.companies.isEmpty) {
      return const Center(child: Text('No companies available.'));
    }

    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? 20 : 80,
        vertical: 6,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.isMobile ? 2 : (context.isTablet ? 2 : 3),
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: context.isMobile ? 5 / 2.5 : 5 / 1.6,
      ),
      itemCount: state.companies.length,
      itemBuilder: (context, index) {
        final company = state.companies[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  company.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text('Service Type: ${company.serviceType}'),
                Text('Location: ${company.location}'),
                Text('Email: ${company.email}'),
                Text('Phone Number: ${company.phone}'),
                Text('Website: ${company.website}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
