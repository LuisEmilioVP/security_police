import 'dart:io';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:security_police_app/domain/entities/user.dart';
import 'package:security_police_app/core/utils/validators.dart';
import 'package:security_police_app/domain/entities/incident.dart';
import 'package:security_police_app/domain/usecases/add_incident.dart';
import 'package:security_police_app/presentation/components/primary_button.dart';
import 'package:security_police_app/presentation/components/custom_text_field.dart';
import 'package:security_police_app/presentation/components/icon_with_text.dart';

class AddIncidentScreen extends StatefulWidget {
  final User user;

  const AddIncidentScreen({super.key, required this.user});

  @override
  createState() => _AddIncidentScreenState();
}

class _AddIncidentScreenState extends State<AddIncidentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final AddIncident _addIncident = GetIt.instance<AddIncident>();
  File? _imageFile;
  File? _audioFile;
  DateTime? _selectedDate;
  FlutterSoundRecorder? _recorder;

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _recorder!.openRecorder();
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    _recorder = null;
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.microphone,
      Permission.storage,
    ].request();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final path =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
      final imageFile = File(pickedFile.path);
      await imageFile.copy(path);
      setState(() {
        _imageFile = File(path);
      });
    }
  }

  Future<void> _selectAudio() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (result != null) {
      final directory = await getApplicationDocumentsDirectory();
      final path =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.aac';
      final audioFile = File(result.files.single.path!);
      await audioFile.copy(path);
      setState(() {
        _audioFile = File(path);
      });
    }
  }

  Future<void> _startRecording() async {
    final status = await Permission.microphone.status;
    if (status.isGranted) {
      final directory = await getApplicationDocumentsDirectory();
      final path =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.aac';
      await _recorder!.startRecorder(
        toFile: path,
      );
      setState(() {
        _audioFile = File(path);
      });
    } else {
      // Solicitar permiso si no está concedido
      await _requestPermissions();
      final newStatus = await Permission.microphone.status;
      if (newStatus.isGranted) {
        final directory = await getApplicationDocumentsDirectory();
        final path =
            '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.aac';
        await _recorder!.startRecorder(
          toFile: path,
        );
        setState(() {
          _audioFile = File(path);
        });
      } else {
        // Manejar caso donde el permiso aún no está concedido
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Permiso para grabar audio no concedido'),
          ),
        );
      }
    }
  }

  Future<void> _stopRecording() async {
    await _recorder!.stopRecorder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar incidente'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _titleController,
                hintText: 'Titulo del incidente',
                validator: Validators.validateIncidentTitle,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _descriptionController,
                hintText: 'Descripción del incidente',
                validator: Validators.validateIncidentDescription,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  IconTextButton(
                    icon: Icons.date_range,
                    text: _selectedDate == null
                        ? 'Seleccionar fecha'
                        : DateFormat.yMd().format(_selectedDate!),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (_imageFile != null) Image.file(_imageFile!),
              IconTextButton(
                icon: Icons.image,
                text: 'Seleccionar imagen',
                onPressed: _selectImage,
              ),
              const SizedBox(height: 10),
              if (_audioFile != null)
                Text('Audio seleccionado: ${_audioFile!.path}'),
              IconTextButton(
                icon: Icons.audiotrack,
                text: 'Seleccionar audio',
                onPressed: _selectAudio,
              ),
              const SizedBox(height: 10),
              IconTextButton(
                icon: Icons.mic,
                text: 'Empezar a grabar',
                onPressed: _startRecording,
              ),
              const SizedBox(height: 10),
              IconTextButton(
                icon: Icons.stop,
                text: 'Parar de grabar',
                onPressed: _stopRecording,
              ),
              const SizedBox(height: 10),
              PrimaryButton(
                text: 'Agregar incidente',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final incident = Incident(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      date: _selectedDate!,
                      photoPath: _imageFile?.path,
                      audioPath: _audioFile?.path,
                      userId: widget.user.id!,
                    );
                    final success = await _addIncident.call(incident);
                    if (success) {
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Error al agregar el incidente')),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
