# To-do app with Voice Assistant

This project is a **Voice-Driven To-Do List** application that allows users to create, manage, and complete tasks using voice commands. The app utilizes speech recognition for task input, Firebase for cloud storage, and local storage as a fallback when the internet is unavailable. It's built using **Flutter** and integrates various services like **Text-to-Speech (TTS)** for audio feedback, **Firestore** for cloud synchronization, and **Hive** for local data storage.

## Features

- **Voice Command Integration**: Add, toggle, and remove tasks using voice commands.
- **Real-Time Synchronization**: Tasks are synchronized with Firebase Firestore for cloud storage and real-time updates.
- **Local Storage**: Tasks are stored locally using Hive when offline and synced once the internet is available.
- **Task Management**: Users can mark tasks as completed or pending.
- **Text-to-Speech**: The app provides audio feedback to confirm actions like task addition, toggling completion, or removing tasks.

## Tech Stack

- **Flutter**: Framework used for building the app.
- **Firebase Firestore**: Cloud database for storing tasks.
- **Hive**: Local storage for tasks when offline.
- **Text-to-Speech (TTS)**: Audio feedback for task actions.
- **Speech Recognition**: For voice command functionality.

## Installation

To run this project locally:

1. Clone the repository:

   ```bash
   git clone https://github.com/vishruti1045/Todo_Voice_assistant.git
