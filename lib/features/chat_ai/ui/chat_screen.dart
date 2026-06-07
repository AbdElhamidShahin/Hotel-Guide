import 'package:flutter/material.dart';
import 'package:hotel_guide/features/chat_ai/ui/widget/chat_bubble.dart'
    show ChatBubble;
import 'package:hotel_guide/features/chat_ai/ui/widget/chat_input_bar.dart';
import 'package:hotel_guide/features/chat_ai/ui/widget/hotel_card.dart';
import 'package:hotel_guide/features/chat_ai/ui/widget/typing_indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';
import '../data/chat_message.dart';
import '../data/chat_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatService _chatService = ChatService();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  // ✅ Fix: use authenticated user ID instead of hardcoded 'user_123'
  String get _userId =>
      Supabase.instance.client.auth.currentUser?.id ?? 'anonymous';

  @override
  void initState() {
    super.initState();
    _messages.add(
      ChatMessage(
        text:
            'مرحباً 👋 أنا مساعدك الذكي من AQUA، جاهز أساعدك تختار الفندق الأنسب.',
        isUser: false,
      ),
    );
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isLoading) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isLoading = true;
    });
    _controller.clear();
    _scrollToBottom();

    final reply = await _chatService.sendMessage(
      message: text,
      userId: _userId,
    );

    setState(() {
      _messages.add(reply);
      _isLoading = false;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbarWidget(name: 'AQUA Hotel AI', onTap: () {}),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length) return const TypingIndicator();

                final msg = _messages[index];
                if (msg.type == MessageType.hotels) {
                  return Column(
                    children: [
                      ChatBubble(message: msg),
                      ...msg.hotels.map((h) => HotelCardWidget(hotel: h)),
                    ],
                  );
                }
                return ChatBubble(message: msg);
              },
            ),
          ),
          ChatInputBar(
            controller: _controller,
            isLoading: _isLoading,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}
