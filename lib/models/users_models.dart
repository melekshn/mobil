class Users {
  final String email;
  final String username;
  final String sifre;
  final String childName;
  final DateTime childAge;
  final String childClass;
  final String avatarUrl;

  Users({required this.email, required this.username, required this.sifre,
  required this.childName, required this.childAge, required this.childClass,
    required this.avatarUrl
  });

  // Firebase'den gelen veriyi User objesine çevir
  factory Users.fromMap(Map<String, dynamic> data, String documentId) {
    return Users(
      email: data['email'],
      username: data['kullaniciAdi'],
      sifre: data['sifre'],
      childName: data['childName'],
      childAge: data['childAge'],
      childClass: data['childClass'],
      avatarUrl: data['avatarUrl'],

    );
  }
  // Firebase'e kaydetmek için Map formatına çevir
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'kullaniciAdi': username,
      'cocukAdi': childName,
      'cocukYaş': childAge, // DateTime tipi burada geçerli
      'cocukSınıf': childClass,
      'avatar': avatarUrl
    };
  }

}