# 🧠 BrainMaster – Modern & Premium Quiz Application

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/API-OpenTDB-%236366F1?style=for-the-badge" alt="OpenTDB API" />
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-success?style=for-the-badge" alt="Platforms" />
  <img src="https://img.shields.io/badge/UI-Glassmorphic%20Dark%20Theme-8B5CF6?style=for-the-badge" alt="UI Theme" />
</p>

---

## ✨ Overview

**BrainMaster** is a state-of-the-art Flutter quiz application built with an ultra-premium, minimalist design aesthetic. It fetches dynamic trivia questions across multiple general knowledge categories from the **Open Trivia Database (OpenTDB)** API and challenges users with a high-speed, engaging interface.

Designed with **glassmorphism**, rich dark gradients, and responsive micro-animations, BrainMaster redefines the trivia app experience.

---

## 🌟 Key Features

- **💎 Premium Obsidian & Slate Aesthetic**: Built from the ground up with curated dark gradients (`#0B0F19` to `#1A1A32`) and glassmorphic card overlays that elevate visual polish.
- **📱 Minimalist & Clutter-Free UI**: Generous whitespace, clean typography, and balanced layouts with zero visual clutter.
- **🎯 Tactile Option Cards**: Every quiz option (`A`, `B`, `C`, `D`) is presented as an interactive card with instant visual status feedback:
  - **Correct Option (`✓`)**: Highlights in crisp **Emerald (`#10B981`)** with a soft green glow when answered.
  - **Incorrect Option (`✕`)**: Highlights in vibrant **Rose (`#F43F5E`)** if selected incorrectly.
  - **Unselected Options**: Smoothly dim into the background to keep focus where it matters.
- **📊 Live Progress & Score Tracking**: Features a smooth `LinearProgressIndicator` tracking real-time completion alongside a persistent live score badge.
- **🏆 Celebratory Results Summary**:
  - Dynamic performance evaluation (`Mastery Achieved!`, `Great Effort!`, `Keep Practicing!`).
  - Score & Accuracy breakdown card comparing total correct vs. incorrect metrics.
- **🛡️ Built-in Resilience & HTML Unescaping**:
  - Automatically decodes complex HTML entities (`&quot;`, `&#039;`, `&eacute;`) from API responses.
  - Includes network timeout protection (`8s`) and **high-quality offline fallback questions** so the app remains functional without internet access or when rate-limited.

---

## 🏗️ Architecture & Project Structure

The codebase adheres to clean separation of concerns and modular widget design:

```bash
quiz_app/
├── lib/
│   ├── main.dart                  # Application entry point & ThemeData setup
│   ├── models/
│   │   └── question.dart          # Question data model with HTML unescaping
│   ├── screens/
│   │   ├── home_screen.dart       # Modern hero welcome & start screen
│   │   ├── quiz_screen.dart       # Active trivia challenge & question cards
│   │   └── result_screen.dart     # Celebratory score breakdown & stats
│   ├── services/
│   │   └── api_service.dart       # OpenTDB HTTP client & offline fallbacks
│   ├── utils/
│   │   ├── app_colors.dart        # Curated design tokens, colors & gradients
│   │   └── html_unescape.dart     # Robust HTML entity decoder helper
│   └── widgets/
│       ├── gradient_button.dart   # Reusable glowing action button
│       └── option_button.dart     # Tactile option card with letter badges
├── test/
├── pubspec.yaml                   # Flutter dependencies & metadata
└── README.md                      # Project documentation
```

---

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK**: `>=3.11.0` (Dart `^3.11.0`)
- An active emulator, physical device, or Chrome browser for web testing.

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/brainmaster-quiz-app.git
   cd brainmaster-quiz-app
   ```

2. **Install packages & dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the application:**
   ```bash
   # Run on Chrome (Web)
   flutter run -d chrome

   # Or run on an connected Android/iOS device
   flutter run
   ```

---

## ⚙️ Customizing Trivia Categories

By default, `ApiService` fetches **10 random multiple-choice questions** across all categories:
```dart
static const String apiUrl = "https://opentdb.com/api.php?amount=10&type=multiple";
```

To customize the category or difficulty, modify the query parameters in `lib/services/api_service.dart`:
- **Science & Computers**: `&category=18`
- **History**: `&category=23`
- **Difficulty**: `&difficulty=easy` | `medium` | `hard`

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check out the issues page or submit a Pull Request.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the `LICENSE` file for details.

---
<p align="center">
  Made with ❤️ using Flutter & Dart
</p>
