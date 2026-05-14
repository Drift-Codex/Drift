import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/app_feedback.dart';

class CreateCampaignPage extends StatefulWidget {
  const CreateCampaignPage({super.key});

  @override
  State<CreateCampaignPage> createState() => _CreateCampaignPageState();
}

class _CreateCampaignPageState extends State<CreateCampaignPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // --- Step 1 Data (Ciblage) ---
  final Map<String, bool> _audienceTargeting = {
    'CM2': true,
    '3ème': false,
    'Terminale D': true,
    'Terminale A': false,
  };
  final List<String> _locations = ['Ouagadougou', 'Bobo-Dioulasso', 'Koudougou'];
  String? _selectedSubject;
  final List<String> _subjects = ['Mathématiques', 'Français', 'SVT'];
  double _budget = 50000;
  final TextEditingController _budgetController = TextEditingController(text: '50000');

  // --- Step 2 Data (Contenu) ---
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _hasImage = false;

  // --- Step 3 Data (Paiement) ---
  String _selectedPaymentMethod = 'Orange Money';

  @override
  void dispose() {
    _pageController.dispose();
    _budgetController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primary),
          onPressed: () {
            if (_currentPage > 0) {
              _previousPage();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          'Créer une Campagne Pub',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppTheme.primary,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            icon: const Icon(Icons.home_outlined, size: 18, color: AppTheme.primary),
            label: const Text('Portail professeur'),
            style: TextButton.styleFrom(foregroundColor: AppTheme.primary),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: _buildStepIndicator(),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                _buildStep1Ciblage(),
                _buildStep2Contenu(),
                _buildStep3Paiement(),
              ],
            ),
          ),
          _buildFooterAction(),
        ],
      ),
    );
  }

  // --- INDICATOR ---
  Widget _buildStepIndicator() {
    final titles = ['Ciblage', 'Contenu', 'Paiement'];
    final percentages = ['33%', '66%', '100%'];
    final flexes = [33, 66, 100];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Étape ${_currentPage + 1} sur 3 : ${titles[_currentPage]}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
            Text(
              percentages[_currentPage],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 4,
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Row(
            children: [
              Expanded(
                flex: flexes[_currentPage],
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Expanded(
                flex: 100 - flexes[_currentPage],
                child: const SizedBox(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppTheme.onSurface,
          letterSpacing: -0.01,
        ),
      ),
    );
  }

  // --- STEP 1: CIBLAGE ---
  Widget _buildStep1Ciblage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildAudienceSection(),
          const SizedBox(height: 32),
          _buildLocationSection(),
          const SizedBox(height: 32),
          _buildSubjectSection(),
          const SizedBox(height: 32),
          _buildPerformanceCard(),
          const SizedBox(height: 32),
          _buildBudgetSection(),
        ],
      ),
    );
  }

  Widget _buildAudienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle('Ciblage audience'),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: _audienceTargeting.keys.map((String key) {
            final isChecked = _audienceTargeting[key]!;
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _audienceTargeting[key] = !isChecked;
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isChecked ? AppTheme.primaryContainer : Colors.transparent,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _audienceTargeting[key] = value ?? false;
                            });
                          },
                          activeColor: AppTheme.primaryContainer,
                          side: const BorderSide(color: AppTheme.outlineVariant),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          key,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle('Localisation'),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ..._locations.map((String loc) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryFixed,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        loc.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.05,
                          color: AppTheme.onPrimaryFixedVariant,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _locations.remove(loc);
                          });
                        },
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: AppTheme.onPrimaryFixedVariant,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              GestureDetector(
                onTap: () async {
                  final controller = TextEditingController();
                  final city = await showDialog<String>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Ajouter une ville'),
                      content: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: 'Ex : Kaya, Fada N\'Gourma…',
                          border: OutlineInputBorder(),
                        ),
                        textCapitalization: TextCapitalization.words,
                      ),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Annuler')),
                        FilledButton(
                          onPressed: () {
                            final t = controller.text.trim();
                            if (t.isNotEmpty) Navigator.pop(ctx, t);
                          },
                          child: const Text('Ajouter'),
                        ),
                      ],
                    ),
                  );
                  controller.dispose();
                  if (!mounted) return;
                  if (city != null && city.isNotEmpty) {
                    setState(() {
                      if (!_locations.contains(city)) {
                        _locations.add(city);
                      }
                    });
                    AppFeedback.snackBar(context, 'Ville ajoutée : $city');
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.outlineVariant),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add, size: 18, color: AppTheme.outline),
                      const SizedBox(width: 4),
                      const Text(
                        'AJOUTER',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.05,
                          color: AppTheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubjectSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle('Matière'),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: DropdownButtonFormField<String>(
            initialValue: _selectedSubject,
            hint: const Text('Matière préférée ciblée'),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.outlineVariant),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.outlineVariant),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.primaryContainer, width: 2),
              ),
            ),
            icon: const Icon(Icons.expand_more, color: AppTheme.onSurfaceVariant),
            items: _subjects.map((String subject) {
              return DropdownMenuItem<String>(
                value: subject,
                child: Text(subject),
              );
            }).toList(),
            onChanged: (value) => setState(() => _selectedSubject = value),
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.secondaryFixed,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.secondaryContainer.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.visibility, color: AppTheme.primaryContainer),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Audience estimée : ~12 400 élèves',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.onSecondaryFixed,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Basé sur vos critères de ciblage actuels.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.onSecondaryFixed.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle('Budget'),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Budget minimum',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    '50 000 FCFA/semaine',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Slider(
                value: _budget,
                min: 50000,
                max: 1000000,
                divisions: 95,
                activeColor: AppTheme.primaryContainer,
                inactiveColor: AppTheme.surfaceContainerHighest,
                onChanged: (value) {
                  setState(() {
                    _budget = value;
                    _budgetController.text = value.toInt().toString();
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    '50k',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.05,
                      color: AppTheme.outline,
                    ),
                  ),
                  Text(
                    '1M FCFA',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.05,
                      color: AppTheme.outline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _budgetController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppTheme.surface,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.outlineVariant),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.outlineVariant),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.primaryContainer, width: 2),
                  ),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'FCFA',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onChanged: (value) {
                  final parsed = double.tryParse(value);
                  if (parsed != null && parsed >= 50000 && parsed <= 1000000) {
                    setState(() {
                      _budget = parsed;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- STEP 2: CONTENU ---
  Widget _buildStep2Contenu() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionTitle('Informations'),
          _buildTextField('Titre de la campagne', _titleController),
          const SizedBox(height: 20),
          _buildTextField('Message principal (Description)', _descriptionController, maxLines: 4),
          const SizedBox(height: 32),
          _buildSectionTitle('Visuel'),
          _buildImageUpload(),
          const SizedBox(height: 32),
          _buildInfoBlock(),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: label,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.outlineVariant),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.primaryContainer, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildImageUpload() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _hasImage = !_hasImage;
        });
      },
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.outlineVariant,
            style: BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: _hasImage
            ? Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuD_bm_y1UBzfz0mixs_3MeibBeS-slrx8ppiC3jF5C6k53dEgti7Qfy34jNLDlzoKUcyyKMWST5A_ktHa2r5CLc_tuiQg45y9nxSlsG3vR20nlVitb4uxWnOuwlEgNTnJAQl0sjmY-PIvYTMOHywi2OStC2Xu_LMSX6SFEz_o-9mW698WPHRBKOJM46tje3fGoUv_0pICMF7pitHsLkodWgtEOK_h0U0aJfmfi7w2suSojtuPwei04RF_YU2NoNsV43yIDZUHQOQnJY',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => setState(() => _hasImage = false),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 20, color: AppTheme.error),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerHighest,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.cloud_upload, color: AppTheme.primaryContainer, size: 32),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Appuyez pour uploader une image',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Format JPG, PNG (Max 5MB)',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.outline,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildInfoBlock() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryFixed,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: AppTheme.onPrimaryFixedVariant),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Un contenu clair et attractif augmente vos chances d\'engagement. N\'hésitez pas à être précis.',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.onPrimaryFixedVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- STEP 3: PAIEMENT ---
  Widget _buildStep3Paiement() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionTitle('Récapitulatif'),
          _buildSummaryCard(),
          const SizedBox(height: 32),
          _buildSectionTitle('Moyen de paiement'),
          _buildPaymentMethods(),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    final activeAudiences = _audienceTargeting.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .join(', ');

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryItem(Icons.groups, 'Audience', activeAudiences.isEmpty ? 'Aucune' : activeAudiences),
          const Divider(height: 24),
          _buildSummaryItem(Icons.location_on, 'Lieux', _locations.join(', ')),
          const Divider(height: 24),
          _buildSummaryItem(Icons.book, 'Matière', _selectedSubject ?? 'Non spécifiée'),
          const Divider(height: 24),
          _buildSummaryItem(Icons.account_balance_wallet, 'Budget', '${_budget.toInt()} FCFA'),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppTheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.outline,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      children: [
        _buildPaymentOption('Orange Money', Icons.phone_android, Colors.orange),
        const SizedBox(height: 12),
        _buildPaymentOption('Moov Money', Icons.phone_android, Colors.blue),
      ],
    );
  }

  Widget _buildPaymentOption(String title, IconData icon, Color color) {
    final isSelected = _selectedPaymentMethod == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.primaryContainer : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.onSurface,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppTheme.primaryContainer),
          ],
        ),
      ),
    );
  }

  // --- FOOTER ACTION ---
  Widget _buildFooterAction() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (_currentPage > 0) ...[
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousPage,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: const BorderSide(color: AppTheme.outlineVariant),
                  ),
                  child: const Text(
                    'Précédent',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage < 2) {
                    _nextPage();
                  } else {
                    // Lancer la campagne
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryContainer,
                  foregroundColor: AppTheme.onPrimaryContainer,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentPage == 2 ? 'Lancer la campagne' : 'Suivant',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(_currentPage == 2 ? Icons.rocket_launch : Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
