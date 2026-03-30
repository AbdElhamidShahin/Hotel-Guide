class LinkOptions {
  final String? persistentToken;

  const LinkOptions({this.persistentToken});

  factory LinkOptions.fromJson(Map<String, dynamic> json) =>
      LinkOptions(persistentToken: json['persistent_token']);

  Map<String, dynamic> toJson() => {'persistent_token': persistentToken};
}