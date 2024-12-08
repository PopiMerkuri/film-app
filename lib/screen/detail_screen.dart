import 'package:flutflix/colors.dart';
import 'package:flutflix/constants.dart';
import 'package:flutflix/models/movie.dart';
import 'package:flutflix/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 20, 20, 20), // Changed the background color to a dark shade
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: const backButton(),
            backgroundColor: Colours.scaffoldBgColor,
            expandedHeight: 500,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Image.network(
                  '${Constants.imagePath}${movie.posterPath}',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '"${movie.title}"',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 255, 223,
                          0), // Changed to gold for better visibility
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Overview',
                    style: GoogleFonts.openSans(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(
                          255, 255, 223, 0), // Changed to gold for consistency
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.overview,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 240, 240,
                          240), // Changed to a lighter shade for better readability
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInfoCard('Release Date', movie.releaseDate),
                  const SizedBox(height: 10),
                  _buildInfoCard(
                      'Rating', '${movie.voteAverage.toStringAsFixed(1)}/10',
                      withIcon: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, {bool withIcon = false}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      color: const Color.fromARGB(
          255, 30, 30, 30), // Changed to a darker gray for contrast
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(
                    255, 255, 223, 0), // Changed to gold for consistency
              ),
            ),
            Row(
              children: [
                if (withIcon) const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 8),
                Text(
                  value,
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(
                        255, 255, 223, 0), // Changed to gold for consistency
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
