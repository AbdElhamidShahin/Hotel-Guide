import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/error/failure.dart';
import 'chat_message.dart';

class ChatService {
  static const String _webhookUrl = ApiConstants.webhookUrl;

  Future<ChatMessage> sendMessage({
    required String message,
    required String userId,
  }) async {
    try {
      final supabase = Supabase.instance.client;
      final hotels = await supabase
          .from(AppTableNames.hotels)
          .select('name, description, address, rating, price_starts_from')
          .limit(5);
      final response = await http
          .post(
            Uri.parse(_webhookUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'message': message,
              'userId': userId,
              'hotels': hotels,
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return _parseResponse(response.body);
      } else {
        throw const ServerFailure(
          '⚠️ السيرفر مش بيتشجيب دلوقتي، حاول تاني كمان شوية',
        );
      }
    } on http.ClientException {
      throw const NetworkFailure('⚠️ مفيش اتصال بالنت، اتأكد من الشبكة');
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }

  ChatMessage _parseResponse(String body) {
    if (body.trim().isEmpty) return _limitMessage();

    try {
      final decoded = jsonDecode(body);

      if (decoded is List && decoded.isNotEmpty) {
        final item = decoded[0];

        if (item[AppTableNames.hotels] != null) {
          return _buildHotelsMessage(
            item['text'] ?? '',
            item[AppTableNames.hotels],
          );
        }

        final text =
            item['output']?.toString() ?? item['answer']?.toString() ?? '';
        if (text.isEmpty) return _limitMessage();
        return _buildTextMessage(text);
      }

      if (decoded is Map) {
        if (decoded[AppTableNames.hotels] != null) {
          return _buildHotelsMessage(
            decoded['text'] ?? '',
            decoded[AppTableNames.hotels],
          );
        }

        final text =
            decoded['output']?.toString() ??
            decoded['answer']?.toString() ??
            '';
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
        cards.add(
          HotelCard(
            name: h['name'] ?? '',
            rating: (h['rating'] ?? 0).toDouble(),
            description: h['description'] ?? '',
            imageUrl: h['image'] ?? h['main_images'] ?? '',
            price: h['price_starts_from'] != null
                ? double.tryParse(h['price_starts_from'].toString())
                : null,
          ),
        );
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
    text:
        '⚠️ عذراً، المساعد الذكي وصل للحد المسموح بيه دلوقتي.\n\nحاول تاني بعد شوية أو تواصل مع الدعم الفني. 🙏',
    isUser: false,
  );

  ChatMessage _errorMessage() =>
      ChatMessage(text: '⚠️ حصل خطأ، حاول تاني.', isUser: false);
}
