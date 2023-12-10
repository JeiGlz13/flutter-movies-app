import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getTheme(bool isDarkMode) {
  if (isDarkMode) {
    return ThemeData.dark(useMaterial3: true)
      .copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 1,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade400,
        ),
      );
  }

  return ThemeData.light(useMaterial3: true)
    .copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.indigo.shade500,
        elevation: 2,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.white,
        )
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.white,
        indicatorColor: Colors.white,
        unselectedLabelColor: Colors.grey.shade400,
      ),
    );
}