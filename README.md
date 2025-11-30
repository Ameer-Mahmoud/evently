# 📅 Evently – Event Management App

Evently is a complete Flutter application for creating, browsing, editing, saving, and managing events. It uses **Firebase**, **Google Maps**, **Provider**, and a clean UI/UX design.

---

## ✨ Features

### 🎨 Modern UI/UX

* Beautiful and clean interface
* Light & Dark Mode
* Supports **English & Arabic**

### 👤 User System

* Email & Password Authentication
* Profile image upload (Base64 – *no Firebase Storage needed*)
* User city & country saved in Firestore
* Local theme & language saving

### 📍 Event Management

* Create new events with:

  * Title
  * Description
  * Date
  * Time
  * Location (Google Maps)
  * Category (Book Club, Sport, Birthday)
* Edit event
* Delete event

### ❤️ Wishlist

* Add / remove events from your favorites
* Fully synced with Firestore
* Real-time UI update via Provider

### 🗺 Map Tab

* Shows all events on Google Maps
* Bottom horizontal event cards
* Move camera to selected event
* “Locate Me” GPS button

---

## 🛠 Technologies Used

| Technology          | Usage                       |
| ------------------- | --------------------------- |
| **Flutter**         | UI & Application Logic      |
| **Dart**            | Language                    |
| **Firebase Auth**   | Authentication              |
| **Cloud Firestore** | Storing users & events      |
| **Google Maps API** | Location & Maps             |
| **Provider**        | State Management            |
| **Base64 Images**   | Storing user profile images |

---

## 📂 Folder Structure

```
lib/
 ├── core/
 │    ├── models/
 │    ├── resources/
 │    ├── reusable_components/
 │    └── source/
 ├── providers/
 ├── ui/
 │    ├── create/
 │    ├── details/
 │    ├── home/
 │    ├── login/
 │    ├── register/
 │    ├── splash/
 │    └── start/
 └── main.dart
```

---

## 🚀 Getting Started

### 1️⃣ Install packages

```bash
flutter pub get
```

### 2️⃣ Add Google Maps API Key

Add your key in:

```
android/app/src/main/AndroidManifest.xml
```

### 3️⃣ Run the app

```bash
flutter run
```

---

## 📸 Screenshots



---

## 👨‍💻 Developer

**Ameer Mahmoud**
Flutter Developer | UI/UX Designer
GitHub: [https://github.com/Ameer-Mahmoud](https://github.com/Ameer-Mahmoud)

---

## ⭐ Support the Project

If you like the project, please give it a **⭐ star** on GitHub!

---

## 📄 License

This project is open-source and free for educational use.
