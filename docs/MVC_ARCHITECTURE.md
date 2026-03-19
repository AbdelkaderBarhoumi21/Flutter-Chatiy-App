# MVC Architecture Documentation

## Overview
This Flutter chat application has been refactored from Clean Architecture to **MVC (Model-View-Controller)** pattern to simplify the codebase while maintaining clean code principles.

## Project Structure

```
lib/
├── models/              # Data models (M in MVC)
│   ├── messages/
│   │   └── message_model.dart
│   ├── stories/
│   │   └── stories_model.dart
│   └── users/
│       └── demo_users.dart
├── views/               # UI components (V in MVC)
│   ├── chat/
│   │   ├── pages/
│   │   │   └── chat_screen.dart
│   │   └── widgets/
│   ├── messages/
│   │   ├── pages/
│   │   │   └── message_page.dart
│   │   └── widgets/
│   ├── contacts/
│   │   ├── pages/
│   │   │   └── contacts_page.dart
│   │   └── widgets/
│   ├── users/
│   │   ├── pages/
│   │   │   ├── profile_screen.dart
│   │   │   └── select_user_screen.dart
│   │   └── widgets/
│   ├── home/
│   │   └── pages/
│   │       └── home_screen.dart
│   ├── calls/
│   ├── notifications/
│   └── navigation_menu/
├── controllers/         # Business logic (C in MVC)
│   ├── chat_controller.dart
│   ├── chat_action_controller.dart
│   ├── message_controller.dart
│   ├── contacts_controller.dart
│   ├── user_auth_controller.dart
│   └── home_navigation_controller.dart
└── core/                # Shared utilities, widgets, themes
    ├── app/             # App entry point
    ├── widgets/         # Reusable widgets
    ├── utils/           # Constants, helpers
    ├── routing/         # Navigation
    ├── themes/          # App themes
    ├── extension/       # Extension methods
    └── services/        # Services
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

### 2. Views (lib/views/)
UI components that display data to users. Organized by feature.

**Examples:**
- [chat_screen.dart](lib/views/chat/pages/chat_screen.dart) - Displays chat interface
- [message_page.dart](lib/views/messages/pages/message_page.dart) - Displays message list
- [contacts_page.dart](lib/views/contacts/pages/contacts_page.dart) - Displays contacts
- [custom_chat_screen_action_bar.dart](lib/views/chat/widgets/custom_chat_screen_action_bar.dart) - Chat input widget

**Responsibilities:**
- Display UI
- Handle user interactions
- Delegate business logic to controllers
- **NO business logic in widgets**

### 3. Controllers (lib/controllers/)
Business logic layer that manages data and coordinates between Models and Views.

#### ChatController
**File:** [chat_controller.dart](lib/controllers/chat_controller.dart)

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
**File:** [chat_action_controller.dart](lib/controllers/chat_action_controller.dart)

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
**File:** [message_controller.dart](lib/controllers/message_controller.dart)

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
**File:** [contacts_controller.dart](lib/controllers/contacts_controller.dart)

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
**File:** [user_auth_controller.dart](lib/controllers/user_auth_controller.dart)

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
**File:** [home_navigation_controller.dart](lib/controllers/home_navigation_controller.dart)

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
- `features/` folder - Moved to `views/`

### What was added:
- `controllers/` folder with all business logic
- Centralized `models/` folder
- `views/` folder for all UI components

### What was moved:
- `data/models/` → `models/`
- `features/` → `views/`

### Import Changes:
```dart
// Old Clean Architecture
import 'package:flutter_chatiy_app/data/models/messages/message_model.dart';
import 'package:flutter_chatiy_app/features/chat/pages/chat_screen.dart';

// New MVC
import 'package:flutter_chatiy_app/models/messages/message_model.dart';
import 'package:flutter_chatiy_app/views/chat/pages/chat_screen.dart';
```

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
// lib/views/my_feature/pages/my_page.dart
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
- **No business logic in UI** - This is strictly enforced

## Refactoring Checklist

✅ Models moved from `data/models/` to `models/`
✅ Views moved from `features/` to `views/`
✅ Controllers created in `controllers/`
✅ Business logic extracted from UI to controllers
✅ All imports updated
✅ Clean architecture folders removed
✅ Code analyzed with no errors
