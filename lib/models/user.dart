class User {
  final String name;
  final String role;
  final String email;
  final String avatar;
  final List<String> preferences;

  const User({
    required this.name,
    required this.role,
    required this.email,
    required this.avatar,
    this.preferences = const [],
  });

  static List<User> getMockUsers() {
    return [
      const User(
        name: 'Marco Rossi',
        role: 'Amministratore',
        email: 'marco.rossi@coordina.it',
        avatar: 'assets/images/user_1.jpg',
        preferences: ['Solo voli diretti', 'No voli dalle 2AM alle 8AM'],
      ),
      const User(
        name: 'Giulia Bianchi',
        role: 'Manager',
        email: 'giulia.bianchi@coordina.it',
        avatar: 'assets/images/user_2.jpg',
        preferences: ['No EasyJet', 'Preferenza posto finestrino'],
      ),
      const User(
        name: 'Alessandro Ferrari',
        role: 'Dipendente',
        email: 'alessandro.ferrari@coordina.it',
        avatar: 'assets/images/user_3.jpg',
        preferences: [],
      ),
      const User(
        name: 'Sofia Romano',
        role: 'Manager',
        email: 'sofia.romano@coordina.it',
        avatar: 'assets/images/user_4.jpg',
        preferences: ['Solo voli diretti', 'No Ryanair'],
      ),
      const User(
        name: 'Luca Esposito',
        role: 'Dipendente',
        email: 'luca.esposito@coordina.it',
        avatar: 'assets/images/user_5.jpg',
        preferences: ['No voli dalle 2AM alle 8AM', 'Bagaglio incluso'],
      ),
      const User(
        name: 'Chiara Colombo',
        role: 'Amministratore',
        email: 'chiara.colombo@coordina.it',
        avatar: 'assets/images/user_6.jpg',
        preferences: ['Solo voli diretti'],
      ),
    ];
  }
}
