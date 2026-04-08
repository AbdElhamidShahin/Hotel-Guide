import 'dart:convert';
import 'package:http/http.dart' as http;
import 'chat_message.dart';

class ChatService {
  static const String _webhookUrl =
      'http://10.0.2.2:5678/webhook/a54ec973-c221-47b9-8021-685ea14e6a70';

  Future<ChatMessage> sendMessage({
    required String message,
    required String userId,
  }) async {
    try {
      final response = await http
          .post(
        Uri.parse(_webhookUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message, 'userId': userId}),
      )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return _parseResponse(response.body);
      } else {
        return _errorMessage();
      }
    } catch (e) {
      return ChatMessage(
        text: '⚠️ مشكلة في الاتصال، تأكد من النت وحاول تاني',
        isUser: false,
      );
    }
  }

  ChatMessage _parseResponse(String body) {
    if (body.trim().isEmpty) return _limitMessage();

    try {
      final decoded = jsonDecode(body);

      if (decoded is List && decoded.isNotEmpty) {
        final item = decoded[0];

        if (item['hotels'] != null) {
          return _buildHotelsMessage(item['text'] ?? '', item['hotels']);
        }

        final text = item['output']?.toString() ?? item['answer']?.toString() ?? '';
        if (text.isEmpty) return _limitMessage();
        return _buildTextMessage(text);
      }

      if (decoded is Map) {
        if (decoded['hotels'] != null) {
          return _buildHotelsMessage(decoded['text'] ?? '', decoded['hotels']);
        }

        final text = decoded['output']?.toString() ?? decoded['answer']?.toString() ?? '';
        if (text.isEmpty) return _limitMessage();
        return _buildTextMessage(text);
      }

    } catch (_) {}

    if (body.trim().isEmpty) return _limitMessage();
    return _buildTextMessage(body);
  }

  ChatMessage _buildTextMessage(String text) {
    final cleaned = text.replaceAll('**', '').replaceAll('*', '').trim();
    return ChatMessage(text: cleaned, isUser: false, type: MessageType.text);
  }

  ChatMessage _buildHotelsMessage(String text, dynamic hotelsData) {
    final List<HotelCard> cards = [];
    if (hotelsData is List) {
      for (final h in hotelsData) {
        cards.add(HotelCard(
          name: h['name'] ?? '',
          rating: (h['rating'] ?? 0).toDouble(),
          description: h['description'] ?? '',
          imageUrl: h['image'] ?? h['main_images'] ?? '',
          price: h['price_starts_from'] != null
              ? double.tryParse(h['price_starts_from'].toString())
              : null,
        ));
      }
    }
    final cleaned = text.replaceAll('**', '').replaceAll('*', '').trim();
    return ChatMessage(
      text: cleaned,
      isUser: false,
      type: cards.isNotEmpty ? MessageType.hotels : MessageType.text,
      hotels: cards,
    );
  }

  ChatMessage _limitMessage() => ChatMessage(
    text: '⚠️ عذراً، المساعد الذكي وصل للحد المسموح بيه دلوقتي.\n\nحاول تاني بعد شوية أو تواصل مع الدعم الفني. 🙏',
    isUser: false,
  );

  ChatMessage _errorMessage() => ChatMessage(
    text: '⚠️ حصل خطأ، حاول تاني.',
    isUser: false,
  );
}