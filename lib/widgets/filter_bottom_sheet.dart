import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_strings.dart';
import '../providers/member_provider.dart';
import 'custom_button.dart';

void showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => const FilterBottomSheet(),
  );
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? _selectedJabatan;
  String? _selectedAngkatan;
  String? _selectedStatus;
  String? _selectedSort;

  final List<String> _sortList = [
    'Nama A-Z',
    'Nama Z-A',
    'Angkatan Terbaru',
    'Angkatan Terlama'
  ];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<MemberProvider>(context, listen: false);
    _selectedJabatan = provider.selectedJabatan;
    _selectedAngkatan = provider.selectedAngkatan;
    _selectedStatus = provider.selectedStatus;
    _selectedSort = provider.selectedSort;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter & Urutkan Data',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),

          _buildDropdown('Jabatan', AppStrings.listJabatan, _selectedJabatan, (val) {
            setState(() => _selectedJabatan = val);
          }),

          _buildDropdown('Angkatan', AppStrings.listAngkatan, _selectedAngkatan, (val) {
            setState(() => _selectedAngkatan = val);
          }),

          _buildDropdown('Status', AppStrings.listStatus, _selectedStatus, (val) {
            setState(() => _selectedStatus = val);
          }),

          _buildDropdown('Urutkan Berdasarkan', _sortList, _selectedSort, (val) {
            setState(() => _selectedSort = val);
          }),

          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    final provider = Provider.of<MemberProvider>(context, listen: false);
                    provider.clearFilters();
                    Navigator.pop(context);
                  },
                  child: const Text('Reset'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  text: 'Terapkan',
                  onPressed: () {
                    final provider = Provider.of<MemberProvider>(context, listen: false);
                    provider.setFilters(
                      jabatan: _selectedJabatan,
                      angkatan: _selectedAngkatan,
                      status: _selectedStatus,
                      sort: _selectedSort,
                    );
                    provider.applyFilters();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? value, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        items: [
          const DropdownMenuItem<String>(value: null, child: Text('Semua')),
          ...items.map((e) => DropdownMenuItem(value: e, child: Text(e))),
        ],
        onChanged: onChanged,
      ),
    );
  }
}
