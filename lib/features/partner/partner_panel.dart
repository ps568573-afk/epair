import 'dart:io';
import 'package:flutter/material.dart';
import 'partner_model.dart';
import 'edit_partner_profile.dart';

class PartnerPanel extends StatefulWidget {
  const PartnerPanel({super.key});

  @override
  State<PartnerPanel> createState() => _PartnerPanelState();
}

class _PartnerPanelState extends State<PartnerPanel> {
  PartnerModel partner = PartnerModel(
    name: "Rahul Sharma",
    services: ["AC Repair"],
    experience: 3,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Partner Dashboard"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// PROFILE CARD
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: partner.imagePath != null
                          ? FileImage(File(partner.imagePath!))
                          : null,
                      child: partner.imagePath == null
                          ? const Icon(Icons.person, size: 50)
                          : null,
                    ),
                    const SizedBox(height: 15),

                    Text(
                      partner.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "${partner.experience} years experience",
                      style: const TextStyle(fontSize: 16),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Services: ${partner.services.join(", ")}",
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 15),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditPartnerProfile(
                              partner: partner,
                              onSave: (updatedPartner) {
                                setState(() {
                                  partner = updatedPartner;
                                });
                              },
                            ),
                          ),
                        );
                      },
                      child: const Text("Edit Profile"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// SAMPLE DASHBOARD CONTENT
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Active Requests",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: ListTile(
                leading: const Icon(Icons.build),
                title: const Text("AC Repair Request"),
                subtitle: const Text("Customer: Amit | Location: Delhi"),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: const Text("View"),
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.plumbing),
                title: const Text("Pipe Leakage"),
                subtitle: const Text("Customer: Raj | Location: Noida"),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: const Text("View"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}