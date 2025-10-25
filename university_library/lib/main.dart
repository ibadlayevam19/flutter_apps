// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const UniversityLibraryApp());
}

class UniversityLibraryApp extends StatelessWidget {
  const UniversityLibraryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Library',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Models
class Book {
  final int id;
  final String title;
  final String author;
  final String category;
  final int copies;
  final int borrowed;
  final int year;
  final String isbn;
  final String description;
  final List<String> reviews;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.copies,
    required this.borrowed,
    required this.year,
    required this.isbn,
    required this.description,
    required this.reviews,
  });

  int get availableCopies => copies - borrowed;
  
  String get status {
    if (availableCopies > 0) return 'available';
    if (borrowed == copies) return 'borrowed';
    return 'reserved';
  }
}

class BorrowedBook {
  final Book book;
  final DateTime borrowDate;
  DateTime dueDate;

  BorrowedBook({
    required this.book,
    required this.borrowDate,
    required this.dueDate,
  });
}

// Sample Data
final List<Book> sampleBooks = [
  Book(
    id: 1,
    title: "Introduction to Algorithms",
    author: "Thomas H. Cormen",
    category: "Technology",
    copies: 3,
    borrowed: 0,
    year: 2009,
    isbn: "978-0262033848",
    description: "A comprehensive textbook on algorithms and data structures.",
    reviews: ["Excellent resource!", "Very detailed and thorough"],
  ),
  Book(
    id: 2,
    title: "Clean Code",
    author: "Robert C. Martin",
    category: "Technology",
    copies: 2,
    borrowed: 2,
    year: 2008,
    isbn: "978-0132350884",
    description: "A handbook of agile software craftsmanship.",
    reviews: ["Must read for developers"],
  ),
  Book(
    id: 3,
    title: "Pride and Prejudice",
    author: "Jane Austen",
    category: "Literature",
    copies: 4,
    borrowed: 1,
    year: 1813,
    isbn: "978-0141439518",
    description: "A romantic novel of manners.",
    reviews: ["Classic literature at its finest"],
  ),
  Book(
    id: 4,
    title: "The Great Gatsby",
    author: "F. Scott Fitzgerald",
    category: "Literature",
    copies: 3,
    borrowed: 0,
    year: 1925,
    isbn: "978-0743273565",
    description: "A novel set in the Jazz Age.",
    reviews: ["American classic"],
  ),
  Book(
    id: 5,
    title: "Physics for Scientists",
    author: "Raymond A. Serway",
    category: "Science",
    copies: 5,
    borrowed: 3,
    year: 2018,
    isbn: "978-1337553278",
    description: "Comprehensive physics textbook.",
    reviews: ["Great explanations"],
  ),
];

// Global State (In a real app, use Provider/Riverpod/Bloc)
class AppState {
  static List<BorrowedBook> borrowedBooks = [];
  static List<Book> favorites = [];
  static List<Book> reservedBooks = [];
  static String? userEmail;
  static String? studentId;
  static String? userName;
}

// Login Page
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      AppState.userEmail = _emailController.text;
      AppState.studentId = 'ST12345';
      AppState.userName = 'John Doe';
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.menu_book, size: 80, color: Colors.blue),
              const SizedBox(height: 24),
              const Text(
                'University Library',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Login to your account',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'University Email or ID',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
                child: const Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Register Page
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _studentIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _register() {
    if (_studentIdController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.menu_book, size: 80, color: Colors.blue),
              const SizedBox(height: 24),
              const Text(
                'Create Account',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Register with student credentials',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _studentIdController,
                decoration: const InputDecoration(
                  labelText: 'Student ID',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'University Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _register,
                  child: const Text('Register', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Home Page
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('University Library'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by title, author, or subject',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Categories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCategoryCard(
                    context,
                    '📚 Books',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CatalogPage()),
                    ),
                  ),
                  _buildCategoryCard(
                    context,
                    '⭐ Favorites',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FavoritesPage()),
                    ),
                  ),
                  _buildCategoryCard(
                    context,
                    '⏱️ Borrowings',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BorrowingsPage()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              // Recommended Books
              const Text(
                '📖 Recommended Books',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final book = sampleBooks[index];
                    return _buildBookCard(context, book);
                  },
                ),
              ),
              const SizedBox(height: 24),
              
              // New Arrivals
              const Text(
                '✨ New Arrivals',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    final book = sampleBooks[index + 3];
                    return _buildBookCard(context, book);
                  },
                ),
              ),
              const SizedBox(height: 24),
              
              // Popular Books
              const Text(
                '🔥 Popular Books',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...sampleBooks.take(2).map((book) => _buildListBookCard(context, book)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget _buildBookCard(BuildContext context, Book book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsPage(book: book),
          ),
        );
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(Icons.book, size: 60, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              book.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListBookCard(BuildContext context, Book book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsPage(book: book),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.book, color: Colors.blue),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.author,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Catalog Page
class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String selectedCategory = 'All';
  final categories = ['All', 'Science', 'Literature', 'Technology'];

  List<Book> get filteredBooks {
    if (selectedCategory == 'All') return sampleBooks;
    return sampleBooks.where((book) => book.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Catalog')),
      body: Column(
        children: [
          // Category Filter
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          
          // Book List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                final book = filteredBooks[index];
                return _buildCatalogBookCard(book);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCatalogBookCard(Book book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsPage(book: book),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(Icons.book, color: Colors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.author,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Available: ${book.availableCopies}/${book.copies}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    _buildStatusChip(book.status),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String text;
    IconData icon;

    switch (status) {
      case 'available':
        color = Colors.green;
        text = 'Available';
        icon = Icons.check_circle;
        break;
      case 'reserved':
        color = Colors.orange;
        text = 'Reserved';
        icon = Icons.notifications;
        break;
      default:
        color = Colors.red;
        text = 'Borrowed';
        icon = Icons.cancel;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// Book Details Page
class BookDetailsPage extends StatefulWidget {
  final Book book;

  const BookDetailsPage({Key? key, required this.book}) : super(key: key);

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  bool get isFavorite => AppState.favorites.any((b) => b.id == widget.book.id);
  bool get isBorrowed => AppState.borrowedBooks.any((b) => b.book.id == widget.book.id);
  bool get isAvailable => widget.book.availableCopies > 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Details')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book Cover
              Center(
                child: Container(
                  width: 200,
                  height: 280,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.book, size: 100, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 24),
              
              // Title and Author
              Text(
                widget.book.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'by ${widget.book.author}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              
              // Book Info
              _buildInfoRow('📅 Year', widget.book.year.toString()),
              _buildInfoRow('📚 ISBN', widget.book.isbn),
              _buildInfoRow('📦 Copies', '${widget.book.availableCopies}/${widget.book.copies}'),
              const SizedBox(height: 24),
              
              // Description
              const Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                widget.book.description,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 24),
              
              // Reviews
              const Text(
                '📝 Reviews',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...widget.book.reviews.map((review) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(review),
                ),
              )),
              const SizedBox(height: 24),
              
              // Action Buttons
              if (isAvailable && !isBorrowed)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        AppState.borrowedBooks.add(
                          BorrowedBook(
                            book: widget.book,
                            borrowDate: DateTime.now(),
                            dueDate: DateTime.now().add(const Duration(days: 14)),
                          ),
                        );
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Book borrowed successfully!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('🟢 Borrow Book', style: TextStyle(fontSize: 16)),
                  ),
                ),
              
              if (!isAvailable && !isBorrowed)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        AppState.reservedBooks.add(widget.book);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Book reserved successfully!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text('🟡 Reserve Book', style: TextStyle(fontSize: 16)),
                  ),
                ),
              
              if (isBorrowed)
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Already Borrowed',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              
              const SizedBox(height: 12),
              
              // Favorite Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      if (isFavorite) {
                        AppState.favorites.removeWhere((b) => b.id == widget.book.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Removed from favorites')),
                        );
                      } else {
                        AppState.favorites.add(widget.book);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to favorites!')),
                        );
                      }
                    });
                  },
                  child: Text(
                    isFavorite ? '💔 Remove from Favorites' : '❤️ Add to Favorites',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }
}

// Borrowings Page
class BorrowingsPage extends StatefulWidget {
  const BorrowingsPage({Key? key}) : super(key: key);

  @override
  State<BorrowingsPage> createState() => _BorrowingsPageState();
}

class _BorrowingsPageState extends State<BorrowingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Borrowings')),
      body: AppState.borrowedBooks.isEmpty
          ? const Center(
              child: Text(
                '📚 No borrowed books yet',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: AppState.borrowedBooks.length,
              itemBuilder: (context, index) {
                final borrowedBook = AppState.borrowedBooks[index];
                return _buildBorrowingCard(borrowedBook);
              },
            ),
    );
  }

  Widget _buildBorrowingCard(BorrowedBook borrowedBook) {
    final book = borrowedBook.book;
    final daysRemaining = borrowedBook.dueDate.difference(DateTime.now()).inDays;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.book, color: Colors.blue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        book.author,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Due: ${borrowedBook.dueDate.day}/${borrowedBook.dueDate.month}/${borrowedBook.dueDate.year}',
                        style: TextStyle(
                          color: daysRemaining < 3 ? Colors.red : Colors.black,
                          fontWeight: daysRemaining < 3 ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      if (daysRemaining < 3)
                        Text(
                          '$daysRemaining days remaining!',
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        borrowedBook.dueDate = borrowedBook.dueDate.add(const Duration(days: 7));
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Borrowing period extended by 7 days')),
                      );
                    },
                    child: const Text('Renew'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        AppState.borrowedBooks.remove(borrowedBook);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Book marked as returned')),
                      );
                    },
                    child: const Text('Mark as Returned'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Favorites Page
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: AppState.favorites.isEmpty
          ? const Center(
              child: Text(
                '⭐ No favorite books yet',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: AppState.favorites.length,
              itemBuilder: (context, index) {
                final book = AppState.favorites[index];
                return _buildFavoriteCard(book);
              },
            ),
    );
  }

  Widget _buildFavoriteCard(Book book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsPage(book: book),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(Icons.book, color: Colors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.author,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  setState(() {
                    AppState.favorites.remove(book);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Removed from favorites')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Profile Page
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Profile Avatar
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 16),
              
              // User Name
              Text(
                AppState.userName ?? 'John Doe',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                AppState.studentId ?? 'ST12345',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                AppState.userEmail ?? 'student@university.edu',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              
              // Stats Cards
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Books Borrowed',
                      AppState.borrowedBooks.length.toString(),
                      Icons.book,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Favorites',
                      AppState.favorites.length.toString(),
                      Icons.favorite,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              // Borrowing History Section
              Card(
                child: ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('Borrowing History'),
                  subtitle: const Text('View all borrowed books'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BorrowingHistoryPage(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              
              // Fines Section
              Card(
                child: ListTile(
                  leading: const Icon(Icons.payment),
                  title: const Text('Fines'),
                  subtitle: const Text('Total: \$0.00'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No fines at this time')),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              
              // Notifications
              Card(
                child: SwitchListTile(
                  secondary: const Icon(Icons.notifications),
                  title: const Text('Notifications'),
                  subtitle: const Text('Return reminders and alerts'),
                  value: true,
                  onChanged: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          value ? 'Notifications enabled' : 'Notifications disabled',
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              
              // Logout Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Clear app state
                    AppState.borrowedBooks.clear();
                    AppState.favorites.clear();
                    AppState.reservedBooks.clear();
                    AppState.userEmail = null;
                    AppState.studentId = null;
                    AppState.userName = null;
                    
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.blue),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Borrowing History Page
class BorrowingHistoryPage extends StatelessWidget {
  const BorrowingHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // In a real app, this would fetch historical data
    final historyBooks = [...AppState.borrowedBooks];
    
    return Scaffold(
      appBar: AppBar(title: const Text('Borrowing History')),
      body: historyBooks.isEmpty
          ? const Center(
              child: Text(
                '📚 No borrowing history',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: historyBooks.length,
              itemBuilder: (context, index) {
                final borrowedBook = historyBooks[index];
                final book = borrowedBook.book;
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(Icons.book, color: Colors.blue, size: 20),
                    ),
                    title: Text(book.title),
                    subtitle: Text(
                      'Borrowed: ${borrowedBook.borrowDate.day}/${borrowedBook.borrowDate.month}/${borrowedBook.borrowDate.year}',
                    ),
                    trailing: const Chip(
                      label: Text('Active', style: TextStyle(fontSize: 10)),
                      backgroundColor: Colors.green,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
    );
  }
}