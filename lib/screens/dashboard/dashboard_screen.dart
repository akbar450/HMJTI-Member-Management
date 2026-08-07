import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../providers/auth_provider.dart';
import '../../providers/member_provider.dart';
import '../../widgets/confirmation_dialog.dart';
import '../../widgets/member_stats_card.dart';
import '../anggota/member_list_screen.dart';
import '../auth/login_screen.dart';
import '../profile/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final memberProvider = Provider.of<MemberProvider>(context, listen: false);
      memberProvider.fetchStats();
      memberProvider.fetchMembers();
    });
  }

  void _handleLogout() async {
    final confirmed = await showConfirmationDialog(
      context: context,
      title: 'Konfirmasi Logout',
      message: 'Apakah Anda yakin ingin keluar dari aplikasi?',
      confirmText: 'Logout',
      isDestructive: true,
    );

    if (confirmed && mounted) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.logout();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0
            ? 'Dashboard'
            : _currentIndex == 1
                ? 'Data Anggota'
                : 'Profil Pengguna'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Logout',
            onPressed: _handleLogout,
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildDashboardHome(),
          const MemberListScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_rounded),
            label: 'Anggota',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            accountName: Text(
              user?.name ?? 'Pengurus HMJTI',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            accountEmail: Text(user?.email ?? 'admin@hmjti.ac.id'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: AppColors.secondary,
              child: Icon(Icons.person, color: AppColors.textPrimary, size: 40),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_rounded, color: AppColors.primary),
            title: const Text('Dashboard'),
            selected: _currentIndex == 0,
            onTap: () {
              Navigator.pop(context);
              setState(() => _currentIndex = 0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.groups_rounded, color: AppColors.primary),
            title: const Text('Data Anggota'),
            selected: _currentIndex == 1,
            onTap: () {
              Navigator.pop(context);
              setState(() => _currentIndex = 1);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_rounded, color: AppColors.primary),
            title: const Text('Profil Pengguna'),
            selected: _currentIndex == 2,
            onTap: () {
              Navigator.pop(context);
              setState(() => _currentIndex = 2);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: AppColors.error),
            title: const Text('Logout', style: TextStyle(color: AppColors.error)),
            onTap: () {
              Navigator.pop(context);
              _handleLogout();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardHome() {
    return Consumer<MemberProvider>(
      builder: (context, provider, child) {
        final stats = provider.stats;
        final totalAnggota = stats['total_anggota'] ?? 0;
        final totalPengurus = stats['total_pengurus'] ?? 0;
        final totalAngkatan = stats['total_angkatan'] ?? 0;
        final anggotaAktif = stats['anggota_aktif'] ?? 0;

        return RefreshIndicator(
          onRefresh: () async {
            await provider.fetchStats();
            await provider.fetchMembers();
          },
          color: AppColors.primary,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Welcome Card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryDark],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sistem Informasi HMJTI',
                              style: TextStyle(
                                color: AppColors.secondary,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Manajemen Data Anggota',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              AppStrings.universityName,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.secondary,
                        child: Icon(Icons.groups_rounded, color: AppColors.primary, size: 36),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Section Header
              const Text(
                'Statistik Keanggotaan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Stats Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.3,
                children: [
                  MemberStatsCard(
                    icon: Icons.groups_rounded,
                    label: 'Total Anggota',
                    count: totalAnggota,
                    color: const Color(0xFF1976D2),
                  ),
                  MemberStatsCard(
                    icon: Icons.badge_rounded,
                    label: 'Total Pengurus',
                    count: totalPengurus,
                    color: const Color(0xFF388E3C),
                  ),
                  MemberStatsCard(
                    icon: Icons.school_rounded,
                    label: 'Total Angkatan',
                    count: totalAngkatan,
                    color: const Color(0xFFF57C00),
                  ),
                  MemberStatsCard(
                    icon: Icons.check_circle_rounded,
                    label: 'Anggota Aktif',
                    count: anggotaAktif,
                    color: const Color(0xFFD32F2F),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Quick Actions Section
              const Text(
                'Menu Cepat',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.people_alt_rounded,
                      title: 'Data Anggota',
                      subtitle: 'Kelola seluruh anggota',
                      color: AppColors.primary,
                      onTap: () => setState(() => _currentIndex = 1),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.account_circle_rounded,
                      title: 'Profil Saya',
                      subtitle: 'Informasi pengguna',
                      color: const Color(0xFF1976D2),
                      onTap: () => setState(() => _currentIndex = 2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
