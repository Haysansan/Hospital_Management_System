import 'dart:io';
import '../domain/domain.dart';
import '../data/appointment_repository.dart';

class ConsoleUI {
  final HospitalManagement hospital;
  final AppointmentRepository repo;

  ConsoleUI({required this.hospital, required this.repo});

  void start() {
    while (true) {
      print('\n=== Hospital Management ===');
      print('1. Add Doctor');
      print('2. Add Patient');
      print('3. Assign Schedule to Doctor');
      print('4. Schedule Appointment');
      print('5. View Doctor Schedule');
      print('6. Save Appointments');
      print('0. Exit');
      stdout.write('Choose option: ');
      final input = stdin.readLineSync();

      switch (input) {
        case '1':
          _addDoctor();
          break;
        case '2':
          _addPatient();
          break;
        case '3':
          _assignSchedule();
          break;
        case '4':
          _scheduleAppointment();
          break;
        case '5':
          _viewSchedule();
          break;
        case '6':
          repo.save(hospital.appointments);
          print('Appointments saved.');
          break;
        case '0':
          print('Exiting...');
          return;
        default:
          print('Invalid choice.');
      }
    }
  }

  void _addDoctor() {
    stdout.write('Enter doctor name: ');
    final name = stdin.readLineSync() ?? '';
    stdout.write('Enter specialization: ');
    final spec = stdin.readLineSync() ?? '';

    final doctor = Doctor(
      id: hospital.doctors.length + 1,
      name: name,
      age: 40,
      gender: 'Male',
      contactNumber: 'N/A',
      specialization: spec,
    );
    hospital.addDoctor(doctor);
    print('Doctor added successfully.');
  }

  void _addPatient() {
    stdout.write('Enter patient name: ');
    final name = stdin.readLineSync() ?? '';
    stdout.write('Enter medical history: ');
    final history = stdin.readLineSync() ?? '';

    final patient = Patient(
      id: hospital.patients.length + 1,
      name: name,
      age: 30,
      gender: 'Female',
      contactNumber: 'N/A',
      medicalHistory: history,
    );
    hospital.addPatient(patient);
    print('Patient added successfully.');
  }

  void _assignSchedule() {
    if (hospital.doctors.isEmpty) {
      print('No doctors available.');
      return;
    }

    final doctor = hospital.doctors.first;
    stdout.write('Enter working hours (e.g., 09:00-17:00): ');
    final schedule = Schedules(
      id: hospital.schedules.length + 1,
      doctor: doctor,
    );

    hospital.assignSchedule(doctor, schedule);
    print('Schedule assigned to ${doctor.name}.');
  }

  void _scheduleAppointment() {
    if (hospital.doctors.isEmpty || hospital.patients.isEmpty) {
      print('At least one doctor and patient are required.');
      return;
    }
    final doctor = hospital.doctors.first;
    final patient = hospital.patients.first;
    final date = DateTime.now();

    hospital.scheduleAppointment(doctor, patient, date);
    print('Appointment scheduled between ${doctor.name} and ${patient.name}.');
  }

  void _viewSchedule() {
    if (hospital.doctors.isEmpty) {
      print('No doctors available.');
      return;
    }
    final doctor = hospital.doctors.first;
    print(hospital.viewSchedule(doctor));
  }
}
