import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_directory_app/app/extensions/build_context_entensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/ad_model/ad_model.dart';
import '../../../data/models/company_model/company_model.dart';

import 'bloc/home_bloc.dart';

/// HomePage is the main screen of the application, displaying a list of companies
/// along with advertisements. It utilizes Bloc for state management and handles
/// pagination, search, and layout adaptation for different screen sizes.

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

  /// Builds the AppBar containing a search field that allows users to filter
  /// companies by service type.
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

  /// Builds the main body of the page, displaying either a loading indicator,
  /// an error message, or the list of companies along with advertisements.
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
                          flex: 4,
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
                          flex: 1,
                          child: _buildSidebarAds(
                              context, ads), // Sidebar ads on the right
                        ),
                      ],
                    ),
                  ),
                  _buildFooter(context),
                ],
              );
            }
          },
          error: (message) => Center(child: Text(message)),
        );
      },
    );
  }

  /// Displays the top banner advertisement, which is clickable and launches
  /// the associated website when tapped.

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

  /// Displays a list of companies in a grid format, with layout adjustments
  /// based on the screen size. Each company is displayed with its details and logo.
  Widget _buildCompanyList(BuildContext context, List<CompanyModel> companies) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth > 1200;
        final isMediumScreen = constraints.maxWidth > 800;
        final isMobile = MediaQuery.of(context).size.width < 800;

        return GridView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: isWideScreen ? 80 : (isMediumScreen ? 40 : 10),
            vertical: 10,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isWideScreen ? 4 : (isMediumScreen ? 3 : 2),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: isMobile ? 1.4 : (isMediumScreen ? 2.1 : 2.5),
          ),
          itemCount: companies.length,
          itemBuilder: (context, index) {
            final company = companies[index];
            final isFeatured = company.isFeatured ?? false;

            return Padding(
              padding: const EdgeInsets.only(
                right: 4.0,
                bottom: 4,
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 6, right: 6, top: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isFeatured ? Colors.yellow[100] : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 1.5,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          company.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 12 : 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Service Type: ${company.serviceType}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: isMobile ? 10 : 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Location: ${company.location}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: isMobile ? 10 : 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Email: ${company.email}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: isMobile ? 10 : 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Phone: ${company.phone}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: isMobile ? 10 : 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text.rich(
                          TextSpan(
                            text: company.website,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: isMobile ? 10 : 12,
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
                                        content: Text(
                                            'Could not launch the website')),
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
                    Container(
                      height: isMobile ? 20 : 50,
                      width: isMobile ? 20 : 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            company.imageUrl!,
                          ),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
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

  /// Builds pagination controls to navigate between pages of companies.

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
                : null,
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
                : null,
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  /// Builds sidebar ads displayed either on the right (desktop) or bottom (mobile).

  Widget _buildSidebarAds(BuildContext context, List<Ad> ads) {
    final ad1 = ads.firstWhere(
      (ad) => ad.type == 'Sidebar Ad 1',
      orElse: () => Ad(websiteUrl: '', imageUrl: '', type: ''),
    );
    final ad2 = ads.firstWhere(
      (ad) => ad.type == 'Sidebar Ad 2',
      orElse: () => Ad(websiteUrl: '', imageUrl: '', type: ''),
    );

    final sidebarAds =
        [ad1, ad2].where((ad) => ad.imageUrl.isNotEmpty).toList();
    if (sidebarAds.isEmpty) return Container();

    final isMobile = MediaQuery.of(context).size.width < 800;

    if (isMobile) {
      // Mobile: Horizontal layout at the bottom
      return SingleChildScrollView(
        child: SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: sidebarAds
                .map((ad) => _buildSidebarAdItem(context, ad))
                .toList(),
          ),
        ),
      );
    } else {
      // Desktop: Vertical layout on the right side
      return SingleChildScrollView(
        child: SizedBox(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: sidebarAds
                  .map((ad) => _buildSidebarAdItem(context, ad))
                  .toList(),
            ),
          ),
        ),
      );
    }
  }

  /// Builds individual sidebar ad item.
  /// Opens the ad's website when tapped.

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
        margin: const EdgeInsets.only(bottom: 5),
        width: MediaQuery.of(context).size.width / 2.5,
        child: Image.network(ad.imageUrl, fit: BoxFit.fill),
      ),
    );
  }

  /// Builds the footer section with basic contact info and links.
  Widget _buildFooter(BuildContext context) {
    return Container(
      color: Colors.green,
      height: 50,
      width: double.infinity,
      alignment: Alignment.center,
      child: const Text(
        'Contact Info | Terms | Privacy Policy',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
