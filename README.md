Flutter Article Management App
A simple Flutter application for managing articles using GetX for state management. The app supports CRUD operations, filtering, pagination, and API integration.

📌 Features
📄 List Articles (with pagination)
🔍 Filter Articles (by title, category, author, etc.)
📝 View Article Details
✏ Create & Update Articles
🗑 Delete Articles
🎨 Responsive UI with Cards & Bottom Sheets
🚀 Tech Stack
Flutter (Latest Stable Version)
GetX (State Management)
Dart
HTTP Package (API calls)


📂 Project Structure
css
Copy
Edit
lib/
├── main.dart
├── routes.dart
├── models/
│   ├── article_model.dart
├── controllers/
│   ├── article_controller.dart
├── services/
│   ├── api_service.dart
├── views/
│   ├── article_list_view.dart
│   ├── article_detail_view.dart
│   ├── add_article_view.dart



🔧 Setup Instructions
1️⃣ Clone the Repository
sh
Copy
Edit
git clone https://github.com/your-username/flutter-article-app.git
cd flutter-article-app
2️⃣ Install Dependencies
sh
Copy
Edit
flutter pub get
3️⃣ Run the App
sh
Copy
Edit
flutter run



🔗 API Endpoints
Get Articles: GET /articles
Get Article by ID: GET /articles/{articleId}
Create Article: POST /articles
Update Article: PATCH /articles/{articleId}
📌 API Host: https://flutter.starbuzz.tech


🤝 Contributing
Fork the repository
Create a new branch: git checkout -b feature-branch
Commit your changes: git commit -m "Added new feature"
Push the branch: git push origin feature-branch
Create a Pull Request
