import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/hotel_model.dart';

class AISearchService {
  final _supabase = Supabase.instance.client;
  final String apiKey = 'AIzaSyChiPVT6HcdOFEgp2pQcvFHn0yD81gPQBQ';

  final _embeddingModel = GenerativeModel(
    model: 'gemini-embedding-001',
    apiKey: 'AIzaSyChiPVT6HcdOFEgp2pQcvFHn0yD81gPQBQ',
  );

  Future<List<HotelModel>> searchHotelsInDb(String query) async {
    final content = Content.text(query);
    final result = await _embeddingModel.embedContent(content);
    final embedding = result.embedding.values;

    final List<dynamic> response = await _supabase.rpc(
      'match_hotels',
      params: {
        'query_embedding': embedding,
        'match_threshold': 0.2,
        'match_count': 4,
      },
    );

    return response.map((json) => HotelModel.fromJson(json)).toList();
  }

  Future<String> getSmartResponse({
    required String userQuery,
    required List<HotelModel> foundHotels,
  }) async {
    String contextInfo = "";
    if (foundHotels.isNotEmpty) {
      contextInfo =
          "دي معلومات عن فنادق لقيتها في الداتابيز عندنا:\n" +
          foundHotels
              .map(
                (h) => "- ${h.name} في ${h.address} سعره ${h.priceStartsFrom}",
              )
              .join("\n");
    }

    final url =
        'https://generativelanguage.googleapis.com/v1/models/gemini-2.0-flash:generateContent?key=$apiKey';
    final body = {
      "contents": [
        {
          "parts": [
            {
              "text":
                  """
أنت 'جميني' مساعد ذكي مصري دمك خفيف وشاطر جداً. 
مهمتك: تدردش مع المستخدم بلهجة مصرية عامية طبيعية (كأنك بتبعت فويسات على واتساب).

قواعد الدردشة:
1. لو المستخدم بيسلم عليك (أهلاً، إزيك، عامل إيه)، رد عليه بحفاوة ومودة مصرية.
2. لو بيسأل سؤال عام عن السفر أو الفنادق، جاوبه بخبرتك كـ AI.
3. لو فيه فنادق في المعلومات دي: [$contextInfo]، استغلها عشان ترشحله الأنسب لطلبه وتدلع المكان (مثلاً: الفندق ده فيو بتاعه يجنن).
4. لو سألك سؤال بره موضوع الفنادق، جاوبه عادي كأنك شات AI شامل، بس حاول في الآخر تربط الكلام بالسفر أو الحجز لو أمكن.
5. ممنوع تقول 'بناءً على البيانات المتاحة'، اتكلم كأنك عارف المعلومات دي من نفسك.

سؤال المستخدم: $userQuery
""",
            },
          ],
        },
      ],
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'];
      }
      return "معلش يا صاحبي النت هنج مني ثانية، قولي كنت بتقول إيه؟";
    } catch (e) {
      return "أنا معاك يا بطل، بس حصلت مشكلة بسيطة في الاتصال. قولي سؤالك تاني؟";
    }
  }
}
