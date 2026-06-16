import 'package:flutter/material.dart';
import '../../data/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  String _formatTime(DateTime time) {
    final h12    = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$h12:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final cs     = Theme.of(context).colorScheme;
    final isUser = message.isUser;
    final time   = _formatTime(message.time);

    // ── Bubble colours ────────────────────────────────────────────────────
    // User bubble: navy (0xFF1A1F3C) in both themes — it is a brand accent,
    // not a surface. White text on it is always readable.
    // Bot bubble:  lightGray in light (0xFFF2F2F7) → surfaceContainerHighest
    // in dark so it is distinguishable from the scaffold background.
    final Color userBubbleColor = const Color(0xFF1A1F3C);
    final Color botBubbleColor  = Theme.of(context).brightness == Brightness.light
        ? const Color(0xFFF2F2F7)
        : cs.surfaceContainerHighest;

    // Bot text: dark in light mode, theme-aware in dark mode.
    final Color botTextColor = cs.onSurface;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isUser) _buildBotAvatar(cs),
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isUser ? userBubbleColor : botBubbleColor,
                    borderRadius: BorderRadius.only(
                      topLeft:     const Radius.circular(10),
                      topRight:    const Radius.circular(10),
                      bottomLeft:  Radius.circular(isUser ? 10 : 0),
                      bottomRight: Radius.circular(isUser ? 0 : 10),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      // User: always white (on navy bubble).
                      // Bot:  cs.onSurface — adapts in dark mode.
                      color: isUser ? Colors.white : botTextColor,
                      fontSize: 14,
                      height: 1.5,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
            ],
          ),
          _buildTimeInfo(isUser, time, cs),
        ],
      ),
    );
  }

  Widget _buildBotAvatar(ColorScheme cs) {
    return Container(
      width: 32,
      height: 32,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        // surfaceContainerHighest = themed bot avatar background.
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        Icons.smart_toy_outlined,
        size: 18,
        // onSurfaceVariant = secondary icon colour, adapts in dark mode.
        color: cs.onSurfaceVariant,
      ),
    );
  }

  Widget _buildTimeInfo(bool isUser, String time, ColorScheme cs) {
    return Padding(
      padding: EdgeInsets.only(right: isUser ? 0 : 40, top: 4),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (isUser) ...[
            const Icon(Icons.done_all, size: 14, color: Color(0xFF4FC3F7)),
            const SizedBox(width: 4),
          ],
          Text(
            time,
            // surfaceTint = textMuted slot — adapts in dark mode.
            style: TextStyle(fontSize: 11, color: cs.surfaceTint),
          ),
        ],
      ),
    );
  }
}
