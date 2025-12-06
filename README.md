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

<img width="1080" height="2340" alt="1" src="https://github.com/user-attachments/assets/070b1e47-27cd-4d28-a99d-dcd4f28dd90a" />
<img width="1080" height="2340" alt="2" src="https://github.com/user-attachments/assets/e2ad781a-ec85-46d2-8db6-4fb773a7d67d" />
<img width="1080" height="2340" alt="3" src="https://github.com/user-attachments/assets/95705f33-faeb-4c08-8ab8-46166cab1067" />
<img width="1080" height="2340" alt="4" src="https://github.com/user-attachments/assets/8148e752-dcfa-4cd3-a362-da0f125885f0" />
<img width="1080" height="2340" alt="5" src="https://github.com/user-attachments/assets/65d2ba18-ade6-4b58-92cc-94c3bc012da2" />
<img width="1080" height="2340" alt="6" src="https://github.com/user-attachments/assets/7b1cb50f-e156-40fa-abf9-9a86c1b9ced1" />
<img width="1080" height="2340" alt="7" src="https://github.com/user-attachments/assets/09082ac7-d3c8-4dec-a99b-c2d999b2b14b" />
<img width="1080" height="2340" alt="8" src="https://github.com/user-attachments/assets/9a2c49cd-60d3-4da7-97f6-f54725e78c0d" />
<img width="1080" height="2340" alt="9" src="https://github.com/user-attachments/assets/d61779bf-fd4b-4819-afd9-9871b85c2b42" />
<img width="1080" height="2340" alt="10" src="https://github.com/user-attachments/assets/ac9a72e5-05f5-4584-8cd8-683a2db06272" />

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
