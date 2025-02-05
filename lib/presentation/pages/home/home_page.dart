import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_directory_app/app/extensions/build_context_entensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/ad_model/ad_model.dart';
import '../../../data/models/company_model/company_model.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(const HomeEvent.fetch()),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.green,
      title: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width > 1200
              ? 250
              : MediaQuery.of(context).size.width > 800
                  ? 50
                  : 30,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height > 1200
              ? 40
              : MediaQuery.of(context).size.height > 800
                  ? 40
                  : 45,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return TextField(
                onChanged: (query) {
                  context.read<HomeBloc>().add(HomeEvent.search(query));
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(6),
                  hintText: 'Search by service type...',
                  filled: true,
                  fillColor: context.surfaceColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: context.disabledColor),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (companies, ads, isLoadingMore, canLoadMore, canLoadPrevious,
              totalCompaniesCount, currentPage, totalPages) {
            final isMobile = MediaQuery.of(context).size.width < 800;

            if (isMobile) {
              // Mobile layout
              return Column(
                children: [
                  _buildTopBannerAd(context, ads),
                  Expanded(child: _buildCompanyList(context, companies)),
                  _buildPaginationControls(
                      context, totalCompaniesCount, currentPage, totalPages),
                  _buildSidebarAds(context, ads), // Sidebar ads at the bottom
                  _buildFooter(context),
                ],
              );
            } else {
              // Desktop layout
              return Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4, // Main content takes 4 parts of the screen
                          child: Column(
                            children: [
                              _buildTopBannerAd(context, ads),
                              Expanded(
                                  child: _buildCompanyList(context, companies)),
                              _buildPaginationControls(context,
                                  totalCompaniesCount, currentPage, totalPages),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1, // Sidebar ads take 1 part of the screen
                          child: _buildSidebarAds(
                              context, ads), // Sidebar ads on the right
                        ),
                      ],
                    ),
                  ),
                  _buildFooter(context), // Footer spans full width
                ],
              );
            }
          },
          error: (message) => Center(child: Text(message)),
        );
      },
    );
  }

  Widget _buildTopBannerAd(BuildContext context, List<Ad> ads) {
    final topBannerAd = ads.firstWhere(
      (ad) => ad.type == 'Top Banner Ad',
      orElse: () =>
          Ad(websiteUrl: '', imageUrl: 'assets/images/bb.png', type: ''),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: () async {
          String urlString = topBannerAd.websiteUrl.trim();
          if (!urlString.startsWith('http://') &&
              !urlString.startsWith('https://')) {
            urlString = 'https://$urlString';
          }

          final Uri url = Uri.parse(urlString);
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Could not launch the website')),
            );
          }
        },
        child: SizedBox(
          height: 100,
          width: 600,
          child: Image.network(
            topBannerAd.imageUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyList(BuildContext context, List<CompanyModel> companies) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth > 1200;
        final isMediumScreen = constraints.maxWidth > 800;

        return GridView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: isWideScreen ? 80 : (isMediumScreen ? 40 : 10),
            vertical: 10,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isWideScreen ? 4 : (isMediumScreen ? 3 : 2),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio:
                isWideScreen ? 3 / 2 : (isMediumScreen ? 3 / 1.5 : 3 / 2.5),
          ),
          itemCount: companies.length,
          itemBuilder: (context, index) {
            final company = companies[index];
            final isFeatured = company.isFeatured ?? false;

            return Card(
              color: isFeatured ? Colors.yellow[100] : null,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            company.imageUrl!,
                            height: 25,
                            width: 25,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          company.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Text(
                      'Service Type: ${company.serviceType}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Location: ${company.location}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Email: ${company.email}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Phone: ${company.phone}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text.rich(
                      TextSpan(
                        text: company.website,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            String urlString = company.website.trim();
                            if (!urlString.startsWith('http://') &&
                                !urlString.startsWith('https://')) {
                              urlString = 'https://$urlString';
                            }

                            final Uri url = Uri.parse(urlString);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Could not launch the website')),
                              );
                            }
                          },
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < company.rating.round()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPaginationControls(BuildContext context, int totalCompaniesCount,
      int currentPage, int totalPages) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: currentPage > 1
                ? () {
                    context
                        .read<HomeBloc>()
                        .add(const HomeEvent.loadPrevious());
                  }
                : null, // Disable if on the first page
            child: const Text('Previous'),
          ),
          const SizedBox(width: 16),
          Text('Page $currentPage of $totalPages'),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: currentPage < totalPages
                ? () {
                    context.read<HomeBloc>().add(const HomeEvent.loadMore());
                  }
                : null, // Disable if on the last page
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarAds(BuildContext context, List<Ad> ads) {
    // Get specific sidebar ads by exact type
    final ad1 = ads.firstWhere(
      (ad) => ad.type == 'Sidebar Ad 1',
      orElse: () => Ad(websiteUrl: '', imageUrl: '', type: ''),
    );
    final ad2 = ads.firstWhere(
      (ad) => ad.type == 'Sidebar Ad 2',
      orElse: () => Ad(websiteUrl: '', imageUrl: '', type: ''),
    );

    // Create a list of non-empty ads
    final sidebarAds =
        [ad1, ad2].where((ad) => ad.imageUrl.isNotEmpty).toList();
    if (sidebarAds.isEmpty) return Container();

    final isMobile = MediaQuery.of(context).size.width < 800;

    if (isMobile) {
      // Mobile: Horizontal layout at the bottom
      return SizedBox(
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children:
              sidebarAds.map((ad) => _buildSidebarAdItem(context, ad)).toList(),
        ),
      );
    } else {
      // Desktop: Vertical layout on the right side
      return SingleChildScrollView(
        child: SizedBox(
          width: 200,
          child: Column(
            children: sidebarAds
                .map((ad) => _buildSidebarAdItem(context, ad))
                .toList(),
          ),
        ),
      );
    }
  }

  Widget _buildSidebarAdItem(BuildContext context, Ad ad) {
    return InkWell(
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () async {
        String urlString = ad.websiteUrl.trim();
        if (!urlString.startsWith('http://') &&
            !urlString.startsWith('https://')) {
          urlString = 'https://$urlString';
        }

        final Uri url = Uri.parse(urlString);
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not launch the website')),
          );
        }
      },
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width / 2.5,
        margin: const EdgeInsets.only(bottom: 10),
        child: Image.network(ad.imageUrl, fit: BoxFit.fill),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      color: Colors.green,
      height: 50,
      width: double.infinity, // Full width
      alignment: Alignment.center,
      child: const Text(
        'Contact Info | Terms | Privacy Policy',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
