import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_drawer.dart';

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final List<_Message> _messages = [
    _Message(
      id: 1,
      role: 'assistant',
      content:
          "Bonjour ! Je suis votre assistant intelligent 24/7. Je suis là pour vous guider dans votre réflexion et vous aider à mieux comprendre vos cours. Comment puis-je vous aider aujourd'hui ?",
      timestamp: DateTime.now(),
    ),
  ];

  final _inputController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isTyping = false;

  final quickQuestions = [
    _Quick(Icons.calculate_rounded, 'Explique-moi le théorème de Pythagore'),
    _Quick(Icons.menu_book_rounded, 'Comment résoudre une équation du second degré ?'),
    _Quick(Icons.lightbulb_rounded, 'Aide-moi à comprendre la photosynthèse'),
    _Quick(Icons.help_outline_rounded, "Quelle est la structure d'une dissertation ?"),
  ];

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(String text) {
    if (!AuthService.requireLogin(context, action: 'utiliser l’assistant IA')) return;
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(_Message(
        id: _messages.length + 1,
        role: 'user',
        content: text.trim(),
        timestamp: DateTime.now(),
      ));
      _isTyping = true;
    });
    _inputController.clear();
    _scrollToBottom();

    // Simulate AI response
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        _messages.add(_Message(
          id: _messages.length + 1,
          role: 'assistant',
          content:
              'Je comprends votre question sur "$text". Commençons par décomposer le problème étape par étape. Quelle partie spécifique vous pose le plus de difficultés ? Cela m\'aidera à mieux vous guider dans votre réflexion.',
          timestamp: DateTime.now(),
        ));
        _isTyping = false;
      });
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasUserMessages = _messages.any((m) => m.role == 'user');
    final isAuthenticated = AuthService.isLoggedIn;

    return Scaffold(
      drawer: _buildHistoryDrawer(),
      endDrawer: const AppDrawer(),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              context.go('/dashboard');
            }
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Assistant IA'),
            Text(
              'Disponible 24/7',
              style: TextStyle(fontSize: 12, color: AppColors.textTertiary, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.history_rounded),
              onPressed: () => Scaffold.of(context).openDrawer(),
              tooltip: 'Historique',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16, left: 8),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return _buildTypingIndicator();
                }
                final message = _messages[index];
                return _buildBubble(message);
              },
            ),
          ),

          if (!isAuthenticated)
            Container(
              width: double.infinity,
              color: AppColors.brandLight,
              padding: const EdgeInsets.all(16),
              child: Text(
                'Connectez-vous pour utiliser l’assistant IA et poser des questions.',
                style: TextStyle(color: AppColors.brand, fontWeight: FontWeight.w600),
              ),
            ),
          if (!hasUserMessages)
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.divider)),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Questions suggérées :',
                      style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                  const SizedBox(height: 10),
                  ...quickQuestions.map((q) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: GestureDetector(
                          onTap: () {
                            if (!AuthService.requireLogin(context, action: 'utiliser l’assistant IA')) return;
                            _sendMessage(q.text);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(q.icon, size: 18, color: AppColors.brand),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(q.text,
                                      style: TextStyle(
                                          fontSize: 13, color: AppColors.textPrimary)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),

          // Input
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppColors.divider)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // TODO: Implement file picker
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Sélectionner un fichier ou une photo...')),
                          );
                        },
                        icon: Icon(Icons.add_photo_alternate_outlined, color: AppColors.textSecondary),
                        tooltip: 'Joindre un fichier ou une photo',
                      ),
                      Expanded(
                        child: TextField(
                          controller: _inputController,
                          decoration: InputDecoration(
                            hintText: isAuthenticated ? 'Posez votre question...' : 'Connectez-vous pour poser une question',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: AppColors.border),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: AppColors.border),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: AppColors.brand, width: 2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            filled: true,
                            fillColor: AppColors.background,
                          ),
                          onSubmitted: _sendMessage,
                          textInputAction: TextInputAction.send,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.brand,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () => _sendMessage(_inputController.text),
                          icon: Icon(Icons.send_rounded, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "L'assistant vous guide sans donner directement les réponses",
                    style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryDrawer() {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Icon(Icons.history_rounded, color: AppColors.brand),
                  const SizedBox(width: 12),
                  const Text('Historique', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            Container(height: 1, color: AppColors.divider),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [
                  _HistoryTile(title: 'Équation du second degré', date: 'Aujourd\'hui'),
                  _HistoryTile(title: 'Théorème de Pythagore', date: 'Hier'),
                  _HistoryTile(title: 'Structure d\'une dissertation', date: 'La semaine dernière'),
                  _HistoryTile(title: 'Explication photosynthèse', date: 'Il y a 2 semaines'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    _messages.clear();
                    _messages.add(
                      _Message(
                        id: 1,
                        role: 'assistant',
                        content: "Bonjour ! Je suis votre assistant intelligent 24/7. Je suis là pour vous guider dans votre réflexion. Comment puis-je vous aider aujourd'hui ?",
                        timestamp: DateTime.now(),
                      ),
                    );
                  });
                },
                icon: const Icon(Icons.add_rounded),
                label: const Text('Nouvelle discussion'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  side: BorderSide(color: AppColors.brand),
                  foregroundColor: AppColors.brand,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBubble(_Message message) {
    final isUser = message.role == 'user';
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser)
            Container(
              width: 36,
              height: 36,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: AppColors.brand,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.smart_toy_rounded, color: Colors.white, size: 18),
            ),
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isUser ? AppColors.brand : AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(isUser ? 18 : 4),
                      bottomRight: Radius.circular(isUser ? 4 : 18),
                    ),
                  ),
                  child: Text(
                    message.content,
                    style: TextStyle(
                      color: isUser ? Colors.white : AppColors.textPrimary,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    '${message.timestamp.hour.toString().padLeft(2, '0')}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
                  ),
                ),
              ],
            ),
          ),
          if (isUser)
            Container(
              width: 36,
              height: 36,
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: AppColors.divider,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person_rounded, color: AppColors.textSecondary, size: 18),
            ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: AppColors.brand,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.smart_toy_rounded, color: Colors.white, size: 18),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomRight: const Radius.circular(18),
                bottomLeft: const Radius.circular(4),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 600 + i * 200),
                  builder: (context, value, child) {
                    return Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: AppColors.textTertiary.withOpacity(0.4 + value * 0.4),
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _Message {
  final int id;
  final String role;
  final String content;
  final DateTime timestamp;
  _Message({
    required this.id,
    required this.role,
    required this.content,
    required this.timestamp,
  });
}

class _Quick {
  final IconData icon;
  final String text;
  _Quick(this.icon, this.text);
}

class _HistoryTile extends StatelessWidget {
  final String title;
  final String date;

  const _HistoryTile({required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Icon(Icons.chat_bubble_outline_rounded, color: AppColors.textSecondary, size: 20),
      title: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(date, style: TextStyle(fontSize: 12, color: AppColors.textTertiary)),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Chargement de la discussion...')));
      },
    );
  }
}
