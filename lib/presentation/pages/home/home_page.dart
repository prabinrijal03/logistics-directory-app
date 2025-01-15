import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logistics_directory_app/app/extensions/build_context_entensions.dart';
import 'package:logistics_directory_app/resources/route_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentPage = 1;
  int itemsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isDesktop = context.isDesktop;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 50),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for logistics companies...',
              filled: true,
              fillColor: context.surfaceColor,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(Icons.search, color: context.disabledColor),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTopBannerAd(context),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: isDesktop ? 3 : 1,
                    child: _buildCompaniesList(context),
                  ),
                  if (!isMobile)
                    Expanded(
                      flex: 1,
                      child: _buildSidebarAds(context),
                    ),
                ],
              ),
            ),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBannerAd(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('ads')
          .where('type', isEqualTo: 'Top Banner Ad')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Container(
            color: Colors.red.withOpacity(0.2),
            height: 50,
            alignment: Alignment.center,
            child: const Text('Top Banner Ad'),
          );
        }
        final ad = snapshot.data!.docs.first;
        return Image.network(
          ad['imageUrl'],
          fit: BoxFit.cover,
          height: 50,
          width: double.infinity,
        );
      },
    );
  }

  Widget _buildCompaniesList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('companies')
          .orderBy('name')
          .startAfter([currentPage * itemsPerPage])
          .limit(itemsPerPage)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No companies found"));
        }
        final companies = snapshot.data!.docs;

        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: context.isMobile ? 2 : 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 6 / 1,
          ),
          itemCount: companies.length,
          itemBuilder: (context, index) {
            final company = companies[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      company['name'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Service: ${company['serviceType']}',
                      style: const TextStyle(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Location: ${company['location']}',
                      style: const TextStyle(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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

  Widget _buildSidebarAds(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('ads')
          .where('type', whereIn: ['Sidebar Ad 1', 'Sidebar Ad 2']).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Column(
            children: [
              Container(
                color: Colors.red.withOpacity(0.2),
                height: 150,
                alignment: Alignment.center,
                child: const Text('Sidebar Ad 1'),
              ),
              const Spacer(),
              Container(
                color: Colors.red.withOpacity(0.2),
                height: 150,
                alignment: Alignment.center,
                child: const Text('Sidebar Ad 2'),
              ),
            ],
          );
        }
        final ads = snapshot.data!.docs;
        return Column(
          children: ads.map((ad) {
            return Container(
              height: 150,
              margin: const EdgeInsets.only(bottom: 10),
              child: Image.network(
                ad['imageUrl'],
                fit: BoxFit.cover,
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                if (currentPage > 1) {
                  setState(() {
                    currentPage--;
                  });
                }
              },
              child: const Text('1', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  currentPage = 2;
                });
              },
              child: const Text('2', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  currentPage = 3;
                });
              },
              child: const Text('3', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  currentPage++;
                });
              },
              child:
                  const Text('Next >', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoute.dashboardPage.path,
                );
              },
              child: Text('Dashboard'),
            ),
          ],
        ),
        Container(
          color: Colors.green,
          height: 50,
          alignment: Alignment.center,
          child: const Text(
            'Footer - Contact Info | Terms | Privacy Policy',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
