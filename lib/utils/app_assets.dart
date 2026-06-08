class AppAssets {
  // We use placeholder SVG strings for this project as requested to just build the UI without external assets.
  static const String logoSvg =
      '''<svg width="40" height="40" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
<rect width="40" height="40" rx="10" fill="white"/>
<circle cx="14" cy="18" r="3" fill="#130160"/>
<circle cx="26" cy="18" r="3" fill="#130160"/>
<path d="M14 26C14 26 17 29 20 29C23 29 26 26 26 26" stroke="#130160" stroke-width="2" stroke-linecap="round"/>
</svg>''';

  static const String googleIconSvg =
      '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M22.56 12.25C22.56 11.47 22.49 10.72 22.36 10H12V14.26H17.92C17.66 15.63 16.88 16.78 15.7 17.57V20.34H19.26C21.34 18.42 22.56 15.6 22.56 12.25Z" fill="#4285F4"/>
<path d="M12 23C14.97 23 17.46 22.02 19.26 20.34L15.7 17.57C14.73 18.23 13.47 18.63 12 18.63C9.17 18.63 6.77 16.71 5.88 14.15H2.21V16.99C4.02 20.59 7.73 23 12 23Z" fill="#34A853"/>
<path d="M5.88 14.15C5.65 13.47 5.52 12.75 5.52 12C5.52 11.25 5.65 10.53 5.88 9.85V7.01H2.21C1.47 8.5 1 10.2 1 12C1 13.8 1.47 15.5 2.21 16.99L5.88 14.15Z" fill="#FBBC05"/>
<path d="M12 5.38C13.62 5.38 15.06 5.94 16.2 7.02L19.34 3.88C17.46 2.12 14.97 1 12 1C7.73 1 4.02 3.41 2.21 7.01L5.88 9.85C6.77 7.29 9.17 5.38 12 5.38Z" fill="#EA4335"/>
</svg>''';

  static const String onboardingSvg =
      '''<svg width="200" height="200" viewBox="0 0 200 200" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect width="200" height="200" rx="100" fill="#D6CDFE"/>
  <rect x="50" y="40" width="100" height="130" rx="10" fill="white" stroke="#130160" stroke-width="4"/>
  <line x1="65" y1="60" x2="135" y2="60" stroke="#130160" stroke-width="4" stroke-linecap="round"/>
  <line x1="65" y1="80" x2="100" y2="80" stroke="#130160" stroke-width="4" stroke-linecap="round"/>
  <line x1="65" y1="100" x2="120" y2="100" stroke="#130160" stroke-width="4" stroke-linecap="round"/>
</svg>''';

  static const String forgotPasswordSvg =
      '''<svg width="150" height="150" viewBox="0 0 150 150" fill="none" xmlns="http://www.w3.org/2000/svg">
  <circle cx="75" cy="75" r="50" fill="#130160"/>
  <path d="M65 85C70.5228 85 75 80.5228 75 75C75 69.4772 70.5228 65 65 65C59.4772 65 55 69.4772 55 75C55 80.5228 59.4772 85 65 85Z" stroke="white" stroke-width="4"/>
  <path d="M75 75H95V85H85V75" stroke="white" stroke-width="4" stroke-linejoin="round"/>
</svg>''';

  static const String mailSvg =
      '''<svg width="150" height="150" viewBox="0 0 150 150" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect x="25" y="45" width="100" height="60" rx="5" stroke="#130160" stroke-width="4" fill="white"/>
  <path d="M25 45L75 75L125 45" stroke="#130160" stroke-width="4"/>
</svg>''';

  static const String successSvg =
      '''<svg width="150" height="150" viewBox="0 0 150 150" fill="none" xmlns="http://www.w3.org/2000/svg">
  <circle cx="75" cy="75" r="50" fill="#D6CDFE"/>
  <path d="M55 75L70 90L100 55" stroke="#130160" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
</svg>''';
}
