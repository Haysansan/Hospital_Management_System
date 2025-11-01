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
      // print('4. Schedule Appointment');
      print('4. View Doctor Schedule');
      print('5. Save Appointments');
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
        // case '4':
        //   _scheduleAppointment();
        //   break;
        case '4':
          _viewSchedule();
          break;
        case '5':
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
    stdout.write('Enter age: ');
    final age = stdin.readLineSync() ?? '';
    stdout.write('Enter gender: ');
    final gender = stdin.readLineSync() ?? '';
    stdout.write('Enter contact number: ');
    final contact = stdin.readLineSync() ?? '';
    stdout.write('Enter specialization: ');
    final spec = stdin.readLineSync() ?? '';

    final doctor = Doctor(
      id: hospital.doctors.length + 1,
      name: name,
      age: int.tryParse(age) ?? 0,
      gender: gender,
      contactNumber: contact,
      specialization: spec,
    );
    hospital.addDoctor(doctor);
    print('Doctor added successfully.');
  }

  void _addPatient() {
    stdout.write('Enter patient name: ');
    final name = stdin.readLineSync() ?? '';
    stdout.write('Enter age: ');
    final age = stdin.readLineSync() ?? '';
    stdout.write('Enter gender: ');
    final gender = stdin.readLineSync() ?? '';
    stdout.write('Enter contact number: ');
    final contact = stdin.readLineSync() ?? '';
    stdout.write('Enter medical history: ');
    final history = stdin.readLineSync() ?? '';

    final patient = Patient(
      id: hospital.patients.length + 1,
      name: name,
      age: int.tryParse(age) ?? 0,
      gender: gender,
      contactNumber: contact,
      medicalHistory: history,
    );
    hospital.addPatient(patient);
    print('Patient added successfully.');
  }

  void _assignSchedule() {
    if (hospital.doctors.isEmpty || hospital.patients.isEmpty) {
      print('No doctors available or patients to assign schedule.');
      return;
    }

    print('\nAvailable Patients:');
    for (var i = 0; i < hospital.patients.length; i++) {
      print('${i + 1}. ${hospital.patients[i].name} '
          '(${hospital.patients[i].medicalHistory})');
    }

    stdout.write('Select patient number: ');
    final input = stdin.readLineSync();
    final index = int.tryParse(input ?? '') ?? 0;

    if (index < 1 || index > hospital.patients.length) {
      print('Invalid selection.');
      return;
    }

    final patient = hospital.patients[index - 1];

    print('\nAvailable Doctors:');
    for (var i = 0; i < hospital.doctors.length; i++) {
      print('${i + 1}. ${hospital.doctors[i].name} '
          '(${hospital.doctors[i].specialization})');
    }

    stdout.write('Select doctor number: ');
    final doctorInput = stdin.readLineSync();
    final doctorIndex = int.tryParse(doctorInput ?? '') ?? 0;

    if (doctorIndex < 1 || doctorIndex > hospital.doctors.length) {
      print('Invalid selection.');
      return;
    }

    final doctor = hospital.doctors[doctorIndex - 1];

    final date = DateTime.now();
    hospital.scheduleAppointment(doctor, patient, date);

    print('\nAppointment scheduled successfully:');
    print('Doctor: ${doctor.name} (${doctor.specialization})');
    print('Patient: ${patient.name}');
    print('Date: $date');
  }

  void _viewSchedule() {
    if (hospital.appointments.isEmpty) {
      print('No scheduled appointments found.');
      return;
    }

    print('\n=== Scheduled Appointments ===');
    for (var i = 0; i < hospital.appointments.length; i++) {
      final a = hospital.appointments[i];
      print('${i + 1}. Doctor: ${a.doctor.name} (${a.doctor.specialization}) '
          '| Patient: ${a.patient.name} '
          '| Date: ${a.date}'
          '| Status: ${a.status}');
    }
  }
}
