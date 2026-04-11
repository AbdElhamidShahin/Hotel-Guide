import 'package:flutter/material.dart';
import '../../data/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final Color navy = const Color(0xFF1A1F3C);
  final Color lightGray = const Color(0xFFF2F2F7);

  const ChatBubble({super.key, required this.message});

  String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    return "$hour12:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final time = _formatTime(message.time);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: isUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isUser) _buildBotAvatar(),
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isUser ? navy : lightGray,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10),
                      topRight: const Radius.circular(10),
                      bottomLeft: Radius.circular(isUser ? 10 : 0),
                      bottomRight: Radius.circular(isUser ? 0 : 10),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.black87,
                      fontSize: 14,
                      height: 1.5,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
            ],
          ),
          _buildTimeInfo(isUser, time),
        ],
      ),
    );
  }

  Widget _buildBotAvatar() {
    return Container(
      width: 32,
      height: 32,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: lightGray,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.smart_toy_outlined,
        size: 18,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildTimeInfo(bool isUser, String time) {
    return Padding(
      padding: EdgeInsets.only(right: isUser ? 0 : 40, top: 4),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (isUser) ...[
            const Icon(Icons.done_all, size: 14, color: Color(0xFF4FC3F7)),
            const SizedBox(width: 4),
          ],
          Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }
}
