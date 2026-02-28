import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/model/hotel_model.dart';
import '../logic/ai_cubit.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("مساعد الفنادق الذكي")),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatSearchCubit, ChatSearchState>(
              builder: (context, state) {
                if (state is ChatSearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatSearchSuccess) {
                  // هنا بنمرر الـ hotels والـ aiResponse للميثود
                  return _buildResultsArea(state.hotels, state.aiResponse);
                } else if (state is ChatSearchError) {
                  return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
                }
                return const Center(child: Text("أنا هنا لمساعدتك! اكتب مثلاً: 'فندق هادي في القاهرة رخيص'"));
              },
            ),
          ),
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildResultsArea(List<HotelModel> hotels, String aiResponse) {
    return Column(
      children: [
        // فقرة الرد الذكي من Gemini
        Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Text(
              aiResponse,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const Divider(),
        // لستة الكروت
        Expanded(
          child: hotels.isEmpty
              ? const Center(child: Text("لم أجد فنادق تطابق طلبك."))
              : ListView.builder(
            itemCount: hotels.length,
            itemBuilder: (context, index) => _buildHotelCard(hotels[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildHotelCard(HotelModel hotel) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          if (hotel.images.isNotEmpty)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(hotel.images[0], height: 150, width: double.infinity, fit: BoxFit.cover),
            ),
          ListTile(
            title: Text(hotel.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("${hotel.address}\n${hotel.priceStartsFrom} ج.م"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildChatInput() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "اسألني عن أي فندق...",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  context.read<ChatSearchCubit>().sendQuery(_controller.text);
                  _controller.clear();
                  FocusScope.of(context).unfocus();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}