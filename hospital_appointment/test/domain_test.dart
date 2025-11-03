import '../lib/domain/domain.dart';
import '../lib/data/appointment_repository.dart';

main() {
  // === Test 1: Add Doctor and Patient ===
  test('Doctor and Patient creation', () {
    HospitalManagement hospital = HospitalManagement();
    Doctor d1 = Doctor(
      id: 1,
      name: "Dr. Smith",
      age: 45,
      gender: Gender.male,
      contactNumber: "123456789",
      specialization: "Cardiology",
    );

    Patient p1 = Patient(
      id: 1,
      name: "Alice",
      age: 29,
      gender: Gender.female,
      contactNumber: "987654321",
      medicalHistory: "Asthma",
    );

    hospital.addDoctor(d1);
    hospital.addPatient(p1);

    expect(hospital.doctors.length, equals(1));
    expect(hospital.patients.length, equals(1));
  });

  // === Test 2: Schedule Appointment ===
  test('Appointment scheduling', () {
    HospitalManagement hospital = HospitalManagement();

    Doctor doctor = Doctor(
      id: 1,
      name: "Dr. Grey",
      age: 40,
      gender: Gender.female,
      contactNumber: "111222333",
      specialization: "Neurology",
    );

    Patient patient = Patient(
      id: 1,
      name: "John Doe",
      age: 35,
      gender: Gender.male,
      contactNumber: "555666777",
      medicalHistory: "Diabetes",
    );

    hospital.addDoctor(doctor);
    hospital.addPatient(patient);

    final date = DateTime(2025, 1, 1);
    hospital.scheduleAppointment(doctor, patient, date);

    expect(hospital.appointments.length, equals(1));
    expect(hospital.appointments.first.doctor.name, equals("Dr. Grey"));
    expect(hospital.appointments.first.patient.name, equals("John Doe"));
  });

  // === Test 3: View Schedule ===
  test('Doctor schedule should show appointments', () {
    HospitalManagement hospital = HospitalManagement();

    Doctor doctor = Doctor(
      id: 1,
      name: "Dr. Adams",
      age: 50,
      gender: Gender.male,
      contactNumber: "333222111",
      specialization: "Dermatology",
    );

    Patient patient = Patient(
      id: 1,
      name: "Lena",
      age: 22,
      gender: Gender.female,
      contactNumber: "444555666",
      medicalHistory: "Allergy",
    );

    hospital.addDoctor(doctor);
    hospital.addPatient(patient);
    hospital.scheduleAppointment(doctor, patient, DateTime(2025, 1, 2));

    final view = hospital.viewSchedule(doctor);
    expect(view.contains("Dr. Adams"), equals(true));
    expect(view.contains("Lena"), equals(true));
  });

  // === Test 4: Saving and Loading Appointments ===
  test('Save and load appointments to file', () {
    HospitalManagement hospital = HospitalManagement();
    AppointmentRepository repo =
        AppointmentRepository(filePath: 'test_appointments.json');

    Doctor doctor = Doctor(
      id: 1,
      name: "Dr. Morgan",
      age: 38,
      gender: Gender.female,
      contactNumber: "999888777",
      specialization: "Cardiology",
    );

    Patient patient = Patient(
      id: 1,
      name: "David",
      age: 44,
      gender: Gender.male,
      contactNumber: "777888999",
      medicalHistory: "Heart condition",
    );

    hospital.addDoctor(doctor);
    hospital.addPatient(patient);
    hospital.scheduleAppointment(doctor, patient, DateTime(2025, 2, 15));

    repo.save(hospital.appointments);
    final loaded = repo.load(hospital.doctors, hospital.patients);

    expect(loaded.length, equals(1));
    expect(loaded.first.doctor.name, equals("Dr. Morgan"));
    expect(loaded.first.patient.name, equals("David"));
  });

  // === Test 5: Handling invalid appointment (no doctor/patient) ===
  test('Handle appointment creation with missing doctor or patient', () {
    HospitalManagement hospital = HospitalManagement();

    try {
      hospital.scheduleAppointment(
        Doctor(
          id: 1,
          name: "Dr. Test",
          age: 40,
          gender: Gender.male,
          contactNumber: "000111222",
          specialization: "Testing",
        ),
        Patient(
          id: 1,
          name: "Tester",
          age: 20,
          gender: Gender.female,
          contactNumber: "111000999",
          medicalHistory: "None",
        ),
        DateTime.now(),
      );
      expect(true, equals(true)); // Success
    } catch (e) {
      expect(false, equals(true)); // Fail
    }
  });
}

// === Dummy Test Framework (for simple Dart run without package:test) === // AI Generated for easier testing
void test(String description, void Function() body) {
  try {
    body();
    print('✅ $description: PASSED');
  } catch (e) {
    print('❌ $description: FAILED — $e');
  }
}

void expect(actual, matcher) {
  if (actual != matcher.value) {
    throw 'Expected ${matcher.value}, got $actual';
  }
}

Matcher equals(expected) => Matcher(expected);

class Matcher {
  final dynamic value;
  Matcher(this.value);
}
