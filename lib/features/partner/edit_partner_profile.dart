import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'partner_model.dart';

class EditPartnerProfile extends StatefulWidget {
  final PartnerModel partner;
  final Function(PartnerModel) onSave;

  const EditPartnerProfile({
    super.key,
    required this.partner,
    required this.onSave,
  });

  @override
  State<EditPartnerProfile> createState() => _EditPartnerProfileState();
}

class _EditPartnerProfileState extends State<EditPartnerProfile> {
  late TextEditingController nameController;
  late TextEditingController experienceController;

  List<String> availableServices = [
    "AC Repair",
    "Plumbing",
    "Electrician",
    "Carpenter",
    "Appliance Repair",
  ];

  late List<String> selectedServices;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.partner.name);
    experienceController =
        TextEditingController(text: widget.partner.experience.toString());
    selectedServices = List.from(widget.partner.services);
  }

  Future<void> pickImage() async {
    final picked =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  void saveProfile() {
    final updatedPartner = PartnerModel(
      name: nameController.text,
      services: selectedServices,
      experience: int.tryParse(experienceController.text) ?? 0,
      imagePath: _imageFile?.path ?? widget.partner.imagePath,
    );

    widget.onSave(updatedPartner);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : (widget.partner.imagePath != null
                      ? FileImage(File(widget.partner.imagePath!))
                      : null),
                  child: _imageFile == null &&
                      widget.partner.imagePath == null
                      ? const Icon(Icons.camera_alt, size: 40)
                      : null,
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: experienceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Experience (years)",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Services",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              Column(
                children: availableServices.map((service) {
                  return CheckboxListTile(
                    title: Text(service),
                    value: selectedServices.contains(service),
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selectedServices.add(service);
                        } else {
                          selectedServices.remove(service);
                        }
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: saveProfile,
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}