import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../providers/member_provider.dart';
import '../../widgets/empty_state_widget.dart';
import '../../widgets/filter_bottom_sheet.dart';
import '../../widgets/member_card.dart';
import 'member_form_screen.dart';

class MemberListScreen extends StatefulWidget {
  const MemberListScreen({super.key});

  @override
  State<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MemberProvider>(context, listen: false);
      provider.fetchMembers();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MemberProvider>(
        builder: (context, provider, child) {
          return RefreshIndicator(
            onRefresh: () async {
              await provider.fetchMembers();
            },
            color: AppColors.primary,
            child: Column(
              children: [
                // Search & Filter Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            provider.searchMembers(value);
                          },
                          decoration: InputDecoration(
                            hintText: AppStrings.cari,
                            prefixIcon: const Icon(Icons.search_rounded),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      _searchController.clear();
                                      provider.searchMembers('');
                                    },
                                  )
                                : null,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Material(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          onTap: () {
                            showFilterBottomSheet(context);
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            child: const Icon(
                              Icons.filter_list_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Members List / Loading / Empty State
                Expanded(
                  child: provider.isLoading
                      ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                      : provider.errorMessage != null
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Text(
                                  provider.errorMessage!,
                                  style: const TextStyle(color: AppColors.error, fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : provider.members.isEmpty
                              ? EmptyStateWidget(
                                  icon: Icons.person_search_rounded,
                                  title: 'Data Tidak Ditemukan',
                                  subtitle: 'Belum ada data anggota yang sesuai dengan kriteria pencarian.',
                                  actionText: 'Tambah Anggota Baru',
                                  onActionPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const MemberFormScreen()),
                                    );
                                  },
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 88.0),
                                  itemCount: provider.members.length,
                                  itemBuilder: (context, index) {
                                    final member = provider.members[index];
                                    return MemberCard(member: member);
                                  },
                                ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MemberFormScreen()),
          );
        },
        icon: const Icon(Icons.add_rounded, color: AppColors.textPrimary),
        label: const Text(
          'Tambah Anggota',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
