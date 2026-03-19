# MVC Architecture Documentation

## Overview
This Flutter chat application has been refactored from Clean Architecture to **MVC (Model-View-Controller)** pattern to simplify the codebase while maintaining clean code principles.

## Project Structure

```
lib/
├── models/              # Data models (M in MVC)
│   ├── messages/
│   ├── stories/
│   └── users/
├── views/               # UI components - can be organized here (V in MVC)
├── controllers/         # Business logic (C in MVC)
│   ├── chat_controller.dart
│   ├── chat_action_controller.dart
│   ├── message_controller.dart
│   ├── contacts_controller.dart
│   ├── user_auth_controller.dart
│   └── home_navigation_controller.dart
├── features/            # Feature-based UI organization
│   ├── chat/
│   │   ├── pages/
│   │   └── widgets/
│   ├── messages/
│   ├── contacts/
│   ├── users/
│   └── home/
└── core/                # Shared utilities, widgets, themes
    ├── widgets/
    ├── utils/
    ├── routing/
    └── themes/
```

## MVC Components

### 1. Models (lib/models/)
Data structures that represent your application data.

**Examples:**
- `MessageModel` - Represents a chat message
- `DemoUser` - Represents a user
- `StoriesModel` - Represents a story

**Responsibilities:**
- Define data structure
- Hold application data
- No business logic

### 2. Views (lib/features/*/pages/ and lib/features/*/widgets/)
UI components that display data to users.

**Examples:**
- `ChatScreen` - Displays chat interface
- `MessagePage` - Displays message list
- `ContactsPage` - Displays contacts
- `CustomChatScreenActionBar` - Chat input widget

**Responsibilities:**
- Display UI
- Handle user interactions
- Delegate business logic to controllers
- **NO business logic in widgets**

### 3. Controllers (lib/controllers/)
Business logic layer that manages data and coordinates between Models and Views.

#### ChatController
Manages chat screen business logic:
- Handles unread message count
- Marks messages as read
- Manages channel state

```dart
// Usage in ChatScreen
_controller = ChatController(channel: widget.channel);
_controller.init();
```

#### ChatActionController
Manages message sending and typing indicators:
- Sends messages to channel
- Handles typing indicators
- Manages text input

```dart
// Usage in CustomChatScreenActionBar
_controller = ChatActionController(channel: channel);
await _controller.sendMessage();
```

#### MessageController
Manages message list:
- Fetches channel list
- Handles pagination
- Manages channel state

```dart
// Usage in MessagePage
_controller = MessageController(client: client);
_controller.init();
```

#### ContactsController
Manages contacts list:
- Fetches user list
- Handles pagination
- Filters current user

```dart
// Usage in ContactsPage
_controller = ContactsController(client: client);
_controller.init();
```

#### UserAuthController
Manages user authentication:
- Connects users to Stream Chat
- Disconnects users
- Handles authentication state

```dart
// Usage in SelectUserScreen
_controller = UserAuthController(client: client);
await _controller.connectUser(user: user, setLoading: callback);
```

#### HomeNavigationController
Manages home screen navigation:
- Handles bottom navigation
- Manages page state
- Updates title

```dart
// Usage in HomeScreen
_controller = HomeNavigationController();
_controller.onNavigationItemSelected(index);
```

## Key Principles

### Separation of Concerns
✅ **Business logic is in Controllers** - Not in UI widgets
✅ **UI only handles display** - No data manipulation in views
✅ **Models are simple data holders** - No business logic

### Controller Lifecycle
1. **Initialize** in `initState()` of StatefulWidget
2. **Use** throughout the widget lifecycle
3. **Dispose** in `dispose()` method

```dart
@override
void initState() {
  super.initState();
  _controller = SomeController(/* dependencies */);
  _controller.init(); // if needed
}

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

### Clean Code Practices

#### ✅ DO:
- Keep business logic in controllers
- Use descriptive controller names
- Dispose controllers properly
- Pass dependencies through constructor
- Use `late` for controllers initialized in `initState()`

#### ❌ DON'T:
- Put business logic in UI widgets
- Access Stream directly in widgets (use controllers)
- Create controllers without disposing them
- Mix UI and business logic

## Migration from Clean Architecture

### What was removed:
- `domain/` folder (entities, repositories, use cases)
- `data/repositories/` - Empty folder
- `data/datasource/` - Empty folder
- Feature-level `providers/` folders - Unused

### What was added:
- `controllers/` folder with all business logic
- Centralized `models/` folder

### What was moved:
- `data/models/` → `models/`

## Example: Adding a New Feature

### Step 1: Create Model (if needed)
```dart
// lib/models/my_feature/my_model.dart
class MyModel {
  const MyModel({required this.id, required this.name});
  final String id;
  final String name;
}
```

### Step 2: Create Controller
```dart
// lib/controllers/my_feature_controller.dart
class MyFeatureController {
  // Add business logic here
  void doSomething() {
    // Logic implementation
  }

  void dispose() {
    // Clean up resources
  }
}
```

### Step 3: Create View
```dart
// lib/features/my_feature/pages/my_page.dart
class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late MyFeatureController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MyFeatureController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // UI here - no business logic!
    );
  }
}
```

## Benefits of MVC in This Project

1. **Simpler Structure** - Less folders, clearer organization
2. **Faster Development** - No need for repositories, use cases for small projects
3. **Easy Testing** - Controllers can be unit tested separately
4. **Maintainability** - Logic is centralized in controllers
5. **Scalability** - Can evolve to more complex patterns if needed

## When to Use This Pattern

✅ **Good for:**
- Small to medium applications
- Rapid prototyping
- Teams familiar with MVC
- Projects with straightforward business logic

❌ **Consider alternatives for:**
- Very large applications with complex domains
- Multiple data sources requiring abstraction
- Heavy emphasis on test-driven development
- Need for swappable data layers

## Notes

- This app uses **Stream Chat Flutter SDK** for real-time messaging
- Controllers manage Stream SDK instances (Client, Channel, etc.)
- UI widgets use Stream's reactive components with controller data
- All async operations are handled in controllers
