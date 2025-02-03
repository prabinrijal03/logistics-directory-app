import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logistics_directory_app/app/extensions/build_context_entensions.dart';
import 'package:logistics_directory_app/resources/route_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../data/models/ad_model/ad_model.dart';
import '../../../../data/models/company_model/company_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<CompanyModel> companies = [];
  List<Ad> ads = [];
  String searchQuery = '';
  int currentPage = 1;
  bool isLoading = false;
  String? errorMessage;
  bool canLoadMore = false;
  bool isFeatured = false;

  @override
  void initState() {
    super.initState();
    fetchCompaniesAndAds();
  }

  List<DocumentSnapshot> lastVisibleDocuments = [];

  DocumentSnapshot<Object?>? lastVisibleDocument;

  List<DocumentSnapshot<Object?>> paginationStack = [];
  int totalCompaniesCount = 0;
  Future<void> fetchCompaniesAndAds({int? page, String? searchQuery}) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final totalSnapshot =
          await FirebaseFirestore.instance.collection('companies').get();

      setState(() {
        totalCompaniesCount = totalSnapshot.size;
      });

      if (searchQuery != null && searchQuery.isNotEmpty) {
        paginationStack.clear();
        companies.clear();
        ads.clear();
      }

      Query query = FirebaseFirestore.instance
          .collection('companies')
          .orderBy('isFeatured', descending: true)
          .limit(12);

      if (searchQuery != null && searchQuery.isNotEmpty) {
        query = query.where('serviceType', isEqualTo: searchQuery);
      }

      if (page != null) {
        if (page > paginationStack.length) {
          if (paginationStack.isNotEmpty) {
            query = query.startAfterDocument(paginationStack.last);
          }
        } else if (page <= paginationStack.length && page > 0) {
          if (page > 1) {
            query = query.startAfterDocument(paginationStack[page - 2]);
          }
        }
      }

      final companiesSnapshot = await query.get();
      final fetchedCompanies = companiesSnapshot.docs
          .map((doc) =>
              CompanyModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      if (companiesSnapshot.docs.isNotEmpty) {
        if (page == null || page > paginationStack.length) {
          paginationStack.add(companiesSnapshot.docs.last);
        } else if (page < paginationStack.length) {
          paginationStack = paginationStack.sublist(0, page);
        }
      }

      final adsSnapshot =
          await FirebaseFirestore.instance.collection('ads').get();
      final fetchedAds =
          adsSnapshot.docs.map((doc) => Ad.fromJson(doc.data())).toList();

      setState(() {
        companies = fetchedCompanies;
        ads = fetchedAds;
        isLoading = false;
      });

      if (fetchedCompanies.length < 5) {
        setState(() {
          canLoadMore = false;
        });
      } else {
        setState(() {
          canLoadMore = true;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          child: Container(
            height: MediaQuery.of(context).size.height > 1200
                ? 40
                : MediaQuery.of(context).size.height > 800
                    ? 40
                    : 45,
            child: TextField(
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
                fetchCompaniesAndAds(searchQuery: query);
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
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          return Stack(
            children: [
              if (isMobile)
                _buildMobileLayout(context)
              else
                _buildDesktopLayout(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildTopBannerAd(context),
        Expanded(child: _buildCompanyList(context)),
        _buildPaginationControls(context),
        _buildSidebarAds(context),
        _buildFooter(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth > 1200;
        final isMediumScreen = constraints.maxWidth > 800;

        return Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: isWideScreen ? 4 : 3,
                    child: Column(
                      children: [
                        _buildTopBannerAd(context),
                        Expanded(child: _buildCompanyList(context)),
                      ],
                    ),
                  ),
                  if (isMediumScreen)
                    Expanded(flex: 1, child: _buildSidebarAds(context)),
                ],
              ),
            ),
            _buildPaginationControls(context),
            _buildFooter(context),
          ],
        );
      },
    );
  }

  Widget _buildTopBannerAd(BuildContext context) {
    final topBannerAd = ads.firstWhere((ad) => ad.type == 'Top Banner Ad',
        orElse: () =>
            Ad(websiteUrl: '', imageUrl: 'assets/images/bb.png', type: ''));

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

  Widget _buildSidebarAds(BuildContext context) {
    final sidebarAds =
        ads.where((ad) => ad.type.startsWith('Sidebar Ad')).toList();
    if (sidebarAds.isEmpty) return Container();

    return MediaQuery.of(context).size.width < 800
        ? SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: sidebarAds.map((ad) {
                return InkWell(
                  onTap: () async {
                    String urlString = ad.websiteUrl.trim();
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
                            content: Text('Could not launch the website')),
                      );
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Image.network(ad.imageUrl, fit: BoxFit.fill),
                  ),
                );
              }).toList(),
            ),
          )
        : SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 10,
              child: Column(
                children: sidebarAds.map((ad) {
                  return InkWell(
                    onTap: () async {
                      String urlString = ad.websiteUrl.trim();
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
                              content: Text('Could not launch the website')),
                        );
                      }
                    },
                    child: Container(
                      height: 200,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Image.network(ad.imageUrl, fit: BoxFit.fill),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
  }

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

  Widget _buildCompanyList(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => fetchCompaniesAndAds(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (companies.isEmpty) {
      return const Center(child: Text('No companies available.'));
    }

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
                        SizedBox(width: 8),
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

  Widget _buildPaginationControls(BuildContext context) {
    int totalPages = (totalCompaniesCount / 5).ceil();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: currentPage > 1
                ? () {
                    setState(() {
                      currentPage--;
                      fetchCompaniesAndAds(page: currentPage);
                    });
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
                    setState(() {
                      currentPage++;
                      fetchCompaniesAndAds(page: currentPage);
                    });
                  }
                : null,
            child: const Text('Next'),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.dashboardPage.path);
              },
              child: Text('Dashboard')),
        ],
      ),
    );
  }
}
