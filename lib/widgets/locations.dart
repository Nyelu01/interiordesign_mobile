import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:interiordesign_mobile/config/app_strings.dart';

class RegionList extends StatefulWidget {
  const RegionList({super.key});

  @override
  State<RegionList> createState() => _RegionListState();
}

class _RegionListState extends State<RegionList> {
  String? selectedLocation;
  final List<String> locations = [
    "Dar es Salaam",
    "Geita",
    "Iringa",
    "Kagera",
    "Kigoma",
    "Kilimanjaro",
    "Lindi",
    "Manyara",
    "Mara",
    "Mbeya",
    "Morogoro",
    "Mtwara",
    "Mwanza",
    "Njombe",
    "Pemba",
    "Pwani",
    "Rukwa",
    "Ruvuma",
    "Shinyanga",
    "Simiyu",
    "Singida",
    "Tabora",
    "Tanga",
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedLocation,
      dropdownColor: Colors.grey[200],
      decoration: InputDecoration(
        hintText: AppStrings.location,
        prefixIcon: Icon(FontAwesomeIcons.mapMarkerAlt),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),
      items: locations
          .map((location) => DropdownMenuItem<String>(
                value: location,
                child: Text(location),
              ))
          .toList(),
      onChanged: (value) => setState(() => selectedLocation = value),
    );
  }
}
