enum MessageType { text, hotels }

class HotelCard {
  final String name;
  final double rating;
  final String description;
  final String imageUrl;
  final double? price;

  HotelCard({
    required this.name,
    required this.rating,
    required this.description,
    required this.imageUrl,
    this.price,
  });
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime time;
  final MessageType type;
  final List<HotelCard> hotels;

  ChatMessage({
    required this.text,
    required this.isUser,
    DateTime? time,
    this.type = MessageType.text,
    this.hotels = const [],
  }) : time = time ?? DateTime.now();
}