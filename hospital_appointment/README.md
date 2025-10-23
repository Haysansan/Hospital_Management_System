# Hospital Appointment Management System (Dart OOP)

A console-based hospital appointment management system built in **Dart**, applying **Object-Oriented Programming** and **Layered Architecture** principles.

---

## Project Overview
This project focuses on one key hospital feature — **Appointment Management** — demonstrating how patients can book, cancel, and view appointments with doctors while ensuring schedule conflict prevention.

### Objectives
- Apply OOP design (encapsulation, inheritance, polymorphism)
- Follow a 3-layer architecture:
  - **Domain** — business logic
  - **Data** — storage/repository (optional)
  - **UI** — user interaction (console)
- Write modular, testable Dart code

---

## Architecture Overview

UI Layer → Console interface (user interaction)
Domain Layer → Core entities: Patient, Doctor, Appointment, Schedule
Data Layer → In-memory / optional file-based persistence

## Folder Structure

```text
hospital_appointment/
├── lib/
│   ├── data/
│   │   └── appointment_repository.dart
│   ├── domain/
│   │   └── domain.dart
│   ├── main.dart
│   └── ui/
│       └── console.dart
├── pubspec.yaml
├── README.md
└── test/
    └── domain_test.dart
```
---


## Core Classes
- **Person** — Abstract base for shared attributes
- **Patient** — Can request appointments
- **Doctor** — Owns a `Schedule` and manages appointments
- **Appointment** — Connects `Patient` and `Doctor` at a specific time
- **Schedule** — Checks availability and prevents double booking

---

## Testing
Run unit tests with:
```bash
dart test
Example tests:
Prevent double booking
Validate appointment creation
Cancel or complete an appointment

▶ Run the Application
bash
Copy code
dart run lib/ui/console_app.dart

-Deliverables-
Date	Deliverable
Nov 02	UML Diagram + Project Code
Nov 03	Project Jury Presentation

👤 Author

Developed by EANG HAYSAN
MOBILE DEVELOPMENT 1 — Dart OOP Project
[CADT / Fundamental Mobile Development ]