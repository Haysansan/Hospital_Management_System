import '../lib/domain/domain.dart';

main() {
  // === Test 1: Add Doctor and Patient ===
  test('Doctor and Patient creation', () {
    Doctor d1 = Doctor(
      id: 1,
      name: "Dr. Smith",
      age: 45,
      gender: "Male",
      contactNumber: "123456789",
      specialization: "Cardiology",
    );

    Patient p1 = Patient(
      id: 1,
      name: "Alice",
      age: 29,
      gender: "Female",
      contactNumber: "987654321",
      medicalHistory: "Asthma",
    );

    HospitalManagement hospital = HospitalManagement();
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
      gender: "Female",
      contactNumber: "111222333",
      specialization: "Neurology",
    );

    Patient patient = Patient(
      id: 1,
      name: "John Doe",
      age: 35,
      gender: "Male",
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
      gender: "Male",
      contactNumber: "333222111",
      specialization: "Dermatology",
    );

    Patient patient = Patient(
      id: 1,
      name: "Lena",
      age: 22,
      gender: "Female",
      contactNumber: "444555666",
      medicalHistory: "Allergy",
    );

    Schedules schedule = Schedules(
      id: 1,
      doctor: doctor,
    );

    hospital.addDoctor(doctor);
    hospital.addPatient(patient);
    hospital.assignSchedule(doctor, schedule);

    final date = DateTime(2025, 1, 2);
    hospital.scheduleAppointment(doctor, patient, date);

    String view = hospital.viewSchedule(doctor);

    expect(view.contains("Dr. Adams"), equals(true));
    expect(view.contains("Lena"), equals(true));
  });
}

// === Dummy Test Framework (for simple Dart run without package:test) ===
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
