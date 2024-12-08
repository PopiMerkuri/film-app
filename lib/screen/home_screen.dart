import 'package:flutflix/screen/list.dart';
import 'package:flutflix/screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutflix/models/movie.dart';
import 'package:flutflix/widgets/movie_slider.dart';
import 'package:flutflix/widgets/trending_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutflix/api/api.dart';

class HomeScreen extends StatefulWidget {
  final String userToken;

  const HomeScreen({Key? key, required this.userToken}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upcomingMovies;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    topRatedMovies = Api().getTopRateMovies();
    upcomingMovies = Api().getUpcomingMovies();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Image.asset(
          'assets/cinemate.png',
          fit: BoxFit.cover,
          height: 40,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFF8CF4A),
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return HomeScreenContent(
          trendingMovies,
          topRatedMovies,
          upcomingMovies,
        );
      case 1:
        return const MovieListPage();
      case 2:
        return ProfilePage();
      default:
        return const Center(child: Text('Invalid index'));
    }
  }
}

class HomeScreenContent extends StatelessWidget {
  final Future<List<Movie>> trendingMovies;
  final Future<List<Movie>> topRatedMovies;
  final Future<List<Movie>> upcomingMovies;

  const HomeScreenContent(
    this.trendingMovies,
    this.topRatedMovies,
    this.upcomingMovies, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding:
            const EdgeInsets.all(16.0), // Increased padding for better spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trending Movies',
              style: GoogleFonts.aBeeZee(
                fontSize: 26, // Increased font size
                fontWeight: FontWeight.bold, // Added bold styling
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
            FutureBuilder<List<Movie>>(
              future: trendingMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return TrendingSlider(snapshot: snapshot);
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
            const SizedBox(height: 32),
            Text(
              'Top Rated Movies',
              style: GoogleFonts.aBeeZee(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
            FutureBuilder<List<Movie>>(
              future: topRatedMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return MovieSlider(snapshot: snapshot);
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
            const SizedBox(height: 32),
            Text(
              'Upcoming Movies',
              style: GoogleFonts.aBeeZee(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
            FutureBuilder<List<Movie>>(
              future: upcomingMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return MovieSlider(snapshot: snapshot);
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
            const SizedBox(height: 32), // Extra spacing at the bottom
          ],
        ),
      ),
    );
  }
}
