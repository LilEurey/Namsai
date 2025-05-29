# 💧 NamSai – Water Issue Reporting App

NamSai is a fullstack mobile application that empowers underserved communities to report water-related problems such as leaks, flooding, or drought in real-time. It helps local responders and municipalities track and manage water issues efficiently.

## 🔧 Tech Stack

| Layer      | Technology            |
|------------|------------------------|
| Frontend   | Flutter (Dart)         |
| Backend    | Node.js + Express      |
| Database   | MongoDB (local or Atlas) |
| Git Hosting| GitHub Organization Repo (`namsai-org`) |

## 📁 Folder Structure

```
namsai/
├── frontend/                     # Flutter mobile application
│   ├── assets/                   # App icons/images
│   │   └── .gitkeep
│   ├── lib/
│   │   ├── models/               # Dart data classes
│   │   │   └── .gitkeep
│   │   ├── screens/              # UI screens
│   │   │   └── .gitkeep
│   │   ├── widgets/              # Reusable UI components
│   │   │   └── .gitkeep
│   │   ├── services/             # API call logic
│   │   │   └── .gitkeep
│   │   ├── providers/            # State management
│   │   │   └── .gitkeep
│   │   └── utils/                # Helpers, constants
│   │       └── .gitkeep
│   └── pubspec.yaml              # Flutter dependency config
│
├── backend/                      # Node.js + Express backend
│   ├── app.js                    # Entry point
│   ├── .env                      # Environment variables (not committed)
│   ├── routes/                   # Route definitions
│   │   └── .gitkeep
│   ├── controllers/              # Logic for each route
│   │   └── .gitkeep
│   ├── models/                   # Mongoose schemas
│   │   └── .gitkeep
│   ├── config/                   # MongoDB config
│   │   └── .gitkeep
│   ├── middleware/               # Middleware (error handling, auth)
│   │   └── .gitkeep
│   └── services/                 # Optional business logic/utilities
│       └── .gitkeep
│
├── .gitignore                    # Ignore build files, .env, node_modules
├── README.md                     # Project guide for developers (you are here)
```

> `.gitkeep` files are used to ensure Git tracks empty folders.

## 🛠 Developer Setup Guide

### 1️⃣ Clone the Repository

```
git clone https://github.com/namsai-org/namsai.git
cd namsai
```

### 2️⃣ Set Up the Flutter Frontend

```
cd frontend
flutter pub get
flutter run
```

> Make sure Flutter is installed and either a physical device or emulator connected.

#### Recommended Dependencies in pubspec.yaml:

```
dependencies:
  flutter:
    sdk: flutter
  http: ^0.14.0
  provider: ^6.1.1
  flutter_dotenv: ^5.1.0
```

### 3️⃣ Set Up the Node.js Backend

```
cd ../backend
npm install
```

#### Create a .env file inside backend/:

```
PORT=5000
MONGO_URI=mongodb://localhost:27017/namsai
```

> Replace MONGO_URI with your own connection string if using MongoDB Atlas.

#### Start the backend server:

```
npm run dev
```

> The API will run at: http://localhost:5000

## 📄 .gitignore Configuration

```
# General
.DS_Store
*.log
.env
.vscode/
.idea/

# Flutter (frontend/)
frontend/.dart_tool/
frontend/build/
frontend/.idea/
frontend/.packages
frontend/pubspec.lock
frontend/ios/
frontend/android/.gradle/
frontend/android/local.properties
frontend/test/*.log

# Node.js (backend/)
backend/node_modules/
backend/.env
backend/package-lock.json
backend/yarn.lock
backend/npm-debug.log*
```

## 🔐 Git & GitHub Access

This repo is hosted under the GitHub Organization: namsai-org

To push changes:

- ✅ Make sure you are a member of the organization
- 🔐 Use HTTPS with GitHub Token or SSH with a linked key

If you're using HTTPS and want to switch to SSH:

```
git remote set-url origin git@github.com:namsai-org/namsai.git
```

If you're using the Fork app:

1. Go to Fork → Preferences → Accounts
2. Add GitHub using either your personal access token (HTTPS) or your SSH key

To push from terminal:

```
git add .
git commit -m "your message"
git push origin main
```

## 🙋 Contribution Guidelines

- Create a new branch:
```
git checkout -b feature/your-feature-name
```
- Use meaningful commit messages (e.g., feat:, fix:, refactor:)
- Avoid committing `.env` or sensitive data
- Pull `main` and rebase before opening a PR
- Coordinate with others before changing shared files

## 📄 License

This project is licensed under the MIT License.  
You are free to use, fork, and contribute — with proper attribution.

## 🙌 Final Notes

NamSai is more than just a project. It's a mission to bring attention and action to water issues affecting real communities.  
Thank you for being part of something meaningful. 💙