import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Companies'),
                Tab(text: 'Banner Ads'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const CompaniesAdminTab(),
                  const BannerAdsAdminTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompaniesAdminTab extends StatelessWidget {
  const CompaniesAdminTab({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController serviceTypeController = TextEditingController();
    final TextEditingController locationController = TextEditingController();

    void clearControllers() {
      nameController.clear();
      serviceTypeController.clear();
      locationController.clear();
    }

    Future<void> addCompany() async {
      if (nameController.text.isNotEmpty &&
          serviceTypeController.text.isNotEmpty &&
          locationController.text.isNotEmpty) {
        await FirebaseFirestore.instance.collection('companies').add({
          'name': nameController.text,
          'serviceType': serviceTypeController.text,
          'location': locationController.text,
        });
        clearControllers();
      }
    }

    Future<void> deleteCompany(String id) async {
      await FirebaseFirestore.instance.collection('companies').doc(id).delete();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Company',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Company Name'),
              ),
              TextField(
                controller: serviceTypeController,
                decoration: const InputDecoration(labelText: 'Service Type'),
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: addCompany,
                child: const Text('Add Company'),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('companies').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No Companies Found'));
              }

              final companies = snapshot.data!.docs;

              return ListView.builder(
                itemCount: companies.length,
                itemBuilder: (context, index) {
                  final company = companies[index];
                  return ListTile(
                    title: Text(company['name']),
                    subtitle: Text(
                        'Service Type: ${company['serviceType']}, Location: ${company['location']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteCompany(company.id),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class BannerAdsAdminTab extends StatelessWidget {
  const BannerAdsAdminTab({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController imageUrlController = TextEditingController();

    void clearControllers() {
      titleController.clear();
      imageUrlController.clear();
    }

    Future<void> addBannerAd() async {
      if (titleController.text.isNotEmpty && imageUrlController.text.isNotEmpty) {
        await FirebaseFirestore.instance.collection('bannerAds').add({
          'title': titleController.text,
          'imageUrl': imageUrlController.text,
        });
        clearControllers();
      }
    }

    Future<void> deleteBannerAd(String id) async {
      await FirebaseFirestore.instance.collection('bannerAds').doc(id).delete();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Banner Ad',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Ad Title'),
              ),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: addBannerAd,
                child: const Text('Add Banner Ad'),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('bannerAds').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No Banner Ads Found'));
              }

              final bannerAds = snapshot.data!.docs;

              return ListView.builder(
                itemCount: bannerAds.length,
                itemBuilder: (context, index) {
                  final ad = bannerAds[index];
                  return ListTile(
                    title: Text(ad['title']),
                    subtitle: Text(ad['imageUrl']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteBannerAd(ad.id),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
