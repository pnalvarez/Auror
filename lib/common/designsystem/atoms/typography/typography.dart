// Typography uses [GoogleFonts.poppins] (non-const), aligned with ambush_people.
//
// Same layout as ambush_people: shared [font_sizes.dart], const-style grouping,
// plus semantic headline/subtitle XL → 2XS names.
library;

import 'package:auror/common/designsystem/atoms/typography/font_sizes.dart'
    as fontsizes;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Headlines (display / page titles) — weight 700 ---------------------------------

final headlineXl = GoogleFonts.poppins(
  fontSize: fontsizes.headlineXl,
  fontWeight: FontWeight.w700,
  height: 1.15,
  letterSpacing: -0.5,
);

final headlineL = GoogleFonts.poppins(
  fontSize: fontsizes.headlineL,
  fontWeight: FontWeight.w700,
  height: 1.15,
  letterSpacing: -0.25,
);

final headlineM = GoogleFonts.poppins(
  fontSize: fontsizes.headlineM,
  fontWeight: FontWeight.w700,
  height: 1.2,
);

final headlineS = GoogleFonts.poppins(
  fontSize: fontsizes.headlineS,
  fontWeight: FontWeight.w700,
  height: 1.2,
);

final headlineXs = GoogleFonts.poppins(
  fontSize: fontsizes.headlineXs,
  fontWeight: FontWeight.w700,
  height: 1.25,
);

final headline2xs = GoogleFonts.poppins(
  fontSize: fontsizes.headline2xs,
  fontWeight: FontWeight.w700,
  height: 1.25,
);

// --- Subtitles (section headers, card titles) — weight 600 ---------------------------

final subtitleXl = GoogleFonts.poppins(
  fontSize: fontsizes.subtitleXl,
  fontWeight: FontWeight.w600,
  height: 1.2,
  letterSpacing: -0.25,
);

final subtitleL = GoogleFonts.poppins(
  fontSize: fontsizes.subtitleL,
  fontWeight: FontWeight.w600,
  height: 1.2,
);

final subtitleM = GoogleFonts.poppins(
  fontSize: fontsizes.subtitleM,
  fontWeight: FontWeight.w600,
  height: 1.25,
);

final subtitleS = GoogleFonts.poppins(
  fontSize: fontsizes.subtitleS,
  fontWeight: FontWeight.w600,
  height: 1.25,
);

final subtitleXs = GoogleFonts.poppins(
  fontSize: fontsizes.subtitleXs,
  fontWeight: FontWeight.w600,
  height: 1.3,
);

final subtitle2xs = GoogleFonts.poppins(
  fontSize: fontsizes.subtitle2xs,
  fontWeight: FontWeight.w600,
  height: 1.3,
);

// --- Legacy-style headings (H1–H6) — same sizes as ambush_people --------------------

final headingH1 = GoogleFonts.poppins(
  fontSize: fontsizes.defaultXL2,
  fontWeight: FontWeight.w700,
  height: 1.15,
);

final headingH2 = GoogleFonts.poppins(
  fontSize: fontsizes.defaultXL,
  fontWeight: FontWeight.w700,
  height: 1.15,
);

final headingH3 = GoogleFonts.poppins(
  fontSize: fontsizes.defaultL,
  fontWeight: FontWeight.w700,
  height: 1.2,
);

final headingH4 = GoogleFonts.poppins(
  fontSize: fontsizes.defaultM,
  fontWeight: FontWeight.w700,
  height: 1.2,
);

final headingH5 = GoogleFonts.poppins(
  fontSize: fontsizes.defaultS,
  fontWeight: FontWeight.w700,
  height: 1.25,
);

final headingH6 = GoogleFonts.poppins(
  fontSize: fontsizes.defaultXS,
  fontWeight: FontWeight.w700,
  height: 1.25,
);

// --- Legacy-style subtitles 1–6 (ambush_people parity) -------------------------------

final subtitle1 = GoogleFonts.poppins(
  fontSize: fontsizes.defaultXL2,
  fontWeight: FontWeight.w600,
  height: 1.2,
);

final subtitle2 = GoogleFonts.poppins(
  fontSize: fontsizes.defaultXL,
  fontWeight: FontWeight.w600,
  height: 1.2,
);

final subtitle3 = GoogleFonts.poppins(
  fontSize: fontsizes.defaultL,
  fontWeight: FontWeight.w600,
  height: 1.25,
);

final subtitle4 = GoogleFonts.poppins(
  fontSize: fontsizes.defaultM,
  fontWeight: FontWeight.w600,
  height: 1.25,
);

final subtitle5 = GoogleFonts.poppins(
  fontSize: fontsizes.defaultS,
  fontWeight: FontWeight.w600,
  height: 1.3,
);

final subtitle6 = GoogleFonts.poppins(
  fontSize: fontsizes.defaultXS,
  fontWeight: FontWeight.w600,
  height: 1.3,
);

// --- Body — weight 400 ---------------------------------------------------------------

final body1Light = GoogleFonts.poppins(
  fontSize: fontsizes.defaultS,
  fontWeight: FontWeight.w400,
  height: 1.4,
);

final body2Light = GoogleFonts.poppins(
  fontSize: fontsizes.defaultXS,
  fontWeight: FontWeight.w400,
  height: 1.45,
);

final body3Light = GoogleFonts.poppins(
  fontSize: fontsizes.defaultXS2,
  fontWeight: FontWeight.w400,
  height: 1.45,
);

final body3Placeholder = GoogleFonts.poppins(
  fontSize: fontsizes.defaultXS2,
  fontWeight: FontWeight.w400,
  height: 1.45,
);

final body4Light = GoogleFonts.poppins(
  fontSize: fontsizes.defaultBody,
  fontWeight: FontWeight.w400,
  height: 1.45,
);

final body5Light = GoogleFonts.poppins(
  fontSize: fontsizes.defaultSBody,
  fontWeight: FontWeight.w400,
  height: 1.45,
);

final body6Light = GoogleFonts.poppins(
  fontSize: fontsizes.defaultTiny,
  fontWeight: FontWeight.w400,
  height: 1.4,
);

// --- Body — weight 500 ---------------------------------------------------------------

final body1Medium = GoogleFonts.poppins(
  fontSize: fontsizes.defaultS,
  fontWeight: FontWeight.w500,
  height: 1.4,
);

final body2Medium = GoogleFonts.poppins(
  fontSize: fontsizes.defaultXS,
  fontWeight: FontWeight.w500,
  height: 1.45,
);

final body3Medium = GoogleFonts.poppins(
  fontSize: fontsizes.defaultXS2,
  fontWeight: FontWeight.w500,
  height: 1.45,
);

final body4Medium = GoogleFonts.poppins(
  fontSize: fontsizes.defaultBody,
  fontWeight: FontWeight.w500,
  height: 1.45,
);

final body5Medium = GoogleFonts.poppins(
  fontSize: fontsizes.defaultSBody,
  fontWeight: FontWeight.w500,
  height: 1.45,
);

// --- Body — weight 600 ---------------------------------------------------------------

final body1Semibold = GoogleFonts.poppins(
  fontSize: fontsizes.defaultS,
  fontWeight: FontWeight.w600,
  height: 1.4,
);

final body2Semibold = GoogleFonts.poppins(
  fontSize: fontsizes.defaultXS,
  fontWeight: FontWeight.w600,
  height: 1.45,
);

final body3Semibold = GoogleFonts.poppins(
  fontSize: fontsizes.defaultXS2,
  fontWeight: FontWeight.w600,
  height: 1.45,
);

final body4Semibold = GoogleFonts.poppins(
  fontSize: fontsizes.defaultBody,
  fontWeight: FontWeight.w600,
  height: 1.45,
);

final body5Semibold = GoogleFonts.poppins(
  fontSize: fontsizes.defaultSBody,
  fontWeight: FontWeight.w600,
  height: 1.45,
);

final body6Semibold = GoogleFonts.poppins(
  fontSize: fontsizes.defaultXS2,
  fontWeight: FontWeight.w600,
  height: 1.45,
);

// --- Labels --------------------------------------------------------------------------

final labelL = GoogleFonts.poppins(
  fontSize: fontsizes.defaultS,
  fontWeight: FontWeight.w600,
  height: 1.2,
);

final labelM = GoogleFonts.poppins(
  fontSize: fontsizes.defaultXS,
  fontWeight: FontWeight.w600,
  height: 1.2,
);

final labelS = GoogleFonts.poppins(
  fontSize: fontsizes.defaultXS2,
  fontWeight: FontWeight.w600,
  height: 1.2,
);

// --- Tags ----------------------------------------------------------------------------

final tagRegular = GoogleFonts.poppins(
  fontSize: fontsizes.defaultBody,
  fontWeight: FontWeight.w600,
  height: 1.2,
);

final tagS = GoogleFonts.poppins(
  fontSize: fontsizes.defaultSBody,
  fontWeight: FontWeight.w600,
  height: 1.2,
);

final tagXS = GoogleFonts.poppins(
  fontSize: fontsizes.defaultTiny,
  fontWeight: FontWeight.w600,
  height: 1.2,
);
