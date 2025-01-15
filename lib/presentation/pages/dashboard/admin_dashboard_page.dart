import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:logistics_directory_app/app/constants/constants.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(color: Colors.white),
        ),
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
            stream:
                FirebaseFirestore.instance.collection('companies').snapshots(),
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

class BannerAdsAdminTab extends StatefulWidget {
  const BannerAdsAdminTab({super.key});

  @override
  BannerAdsAdminTabState createState() => BannerAdsAdminTabState();
}

class BannerAdsAdminTabState extends State<BannerAdsAdminTab> {
  final TextEditingController titleController = TextEditingController();
  Uint8List? _selectedImage;
  String _selectedAdType = 'Top Banner Ad';
  bool _isUploading = false;
  String? _editingAdId;
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _selectedImage = result.files.single.bytes!;
      });
      print('Image selected. Size: ${_selectedImage!.lengthInBytes} bytes');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
    }
  }

  Future<String?> uploadImageToCloudinary(Uint8List imageBytes) async {
    try {
      final filename = '${DateTime.now().millisecondsSinceEpoch}_ad_image.jpg';
      final request =
          http.MultipartRequest('POST', Uri.parse(UrlConstants.cloudinaryUrl))
            ..fields['upload_preset'] = UrlConstants.cloudinaryUploadPreset
            ..files.add(http.MultipartFile.fromBytes(
              'file',
              imageBytes,
              filename: filename,
              contentType: MediaType('image', 'jpeg'),
            ));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        final data = jsonDecode(responseData.body);
        return data['secure_url'];
      } else {
        final responseData = await http.Response.fromStream(response);
        print('Cloudinary Error: ${responseData.body}');
        return null;
      }
    } catch (e) {
      print('Error uploading image to Cloudinary: $e');
      return null;
    }
  }

  Future<void> saveAd() async {
    if (titleController.text.isNotEmpty &&
        (_selectedImage != null || _editingAdId != null)) {
      setState(() {
        _isUploading = true;
      });

      String? imageUrl;
      if (_selectedImage != null) {
        imageUrl = await uploadImageToCloudinary(_selectedImage!);
      }

      if (imageUrl != null || _editingAdId != null) {
        final adData = {
          'title': titleController.text,
          'type': _selectedAdType,
        };

        if (imageUrl != null) {
          adData['imageUrl'] = imageUrl;
        }

        if (_editingAdId == null) {
          // Add new ad
          await FirebaseFirestore.instance.collection('ads').add(adData);
        } else {
          // Update existing ad
          await FirebaseFirestore.instance
              .collection('ads')
              .doc(_editingAdId)
              .update(adData);
        }

        // Clear state
        titleController.clear();
        setState(() {
          _selectedImage = null;
          _isUploading = false;
          _editingAdId = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image upload failed')),
        );
        setState(() {
          _isUploading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  Future<void> deleteAd(String adId) async {
    await FirebaseFirestore.instance.collection('ads').doc(adId).delete();
  }

  void startEditingAd(QueryDocumentSnapshot ad) {
    setState(() {
      _editingAdId = ad.id;
      titleController.text = ad['title'];
      _selectedAdType = ad['type'];
      _selectedImage = null; // Clear the selected image for new uploads
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upload Ad',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: _selectedAdType,
                onChanged: (value) {
                  setState(() {
                    _selectedAdType = value!;
                  });
                },
                items: ['Top Banner Ad', 'Sidebar Ad 1', 'Sidebar Ad 2']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Ad Title'),
              ),
              const SizedBox(height: 8),
              _selectedImage != null
                  ? Image.memory(_selectedImage!, height: 150)
                  : ElevatedButton(
                      onPressed: pickImage,
                      child: const Text('Pick Image'),
                    ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _isUploading ? null : saveAd,
                child: _isUploading
                    ? const CircularProgressIndicator()
                    : Text(_editingAdId == null ? 'Save Ad' : 'Update Ad'),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('ads').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No Ads Found'));
              }

              final ads = snapshot.data!.docs;

              return ListView.builder(
                itemCount: ads.length,
                itemBuilder: (context, index) {
                  final ad = ads[index];
                  return ListTile(
                    title: Text('${ad['type']} - ${ad['title']}'),
                    subtitle: Image.network(ad['imageUrl'], height: 50),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => startEditingAd(ad),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteAd(ad.id),
                        ),
                      ],
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
