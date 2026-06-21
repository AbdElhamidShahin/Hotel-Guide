import 'dart:convert';
import 'package:http/http.dart' as http;
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
      // ملاحظة: شيلنا استدعاء Supabase المباشر من هنا.
      // n8n هو المسؤول الوحيد عن جلب الفنادق الصحيحة حسب سؤال المستخدم
      // (مدينة/سعر/تقييم)، فمفيش داعي نبعت فنادق عشوائية من هنا.
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

      // n8n بيرجع Map مباشر: { "text": "...", "hotels": [...] }
      if (decoded is Map) {
        final hotelsData = decoded['hotels'];
        if (hotelsData != null) {
          return _buildHotelsMessage(decoded['text'] ?? '', hotelsData);
        }

        final text =
            decoded['text']?.toString() ??
            decoded['output']?.toString() ??
            decoded['answer']?.toString() ??
            '';
        if (text.isEmpty) return _limitMessage();
        return _buildTextMessage(text);
      }

      // دعم احتياطي لو n8n رجّع List فيها عنصر واحد (شكل قديم محتمل)
      if (decoded is List && decoded.isNotEmpty) {
        final item = decoded[0];
        final hotelsData = item['hotels'];
        if (hotelsData != null) {
          return _buildHotelsMessage(item['text'] ?? '', hotelsData);
        }

        final text =
            item['output']?.toString() ?? item['answer']?.toString() ?? '';
        if (text.isEmpty) return _limitMessage();
        return _buildTextMessage(text);
      }
    } catch (_) {}

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
}
