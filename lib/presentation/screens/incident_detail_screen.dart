import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:security_police_app/domain/entities/incident.dart';
import 'package:security_police_app/presentation/components/icon_with_text.dart';
import 'package:security_police_app/presentation/screens/profile_screen.dart';

class IncidentDetailScreen extends StatefulWidget {
  final Incident incident;

  const IncidentDetailScreen({super.key, required this.incident});

  @override
  createState() => _IncidentDetailScreenState();
}

class _IncidentDetailScreenState extends State<IncidentDetailScreen> {
  late AudioPlayer _audioPlayer;
  PlayerState _audioPlayerState = PlayerState.stopped;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        _audioPlayerState = state;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPauseAudio() async {
    if (_audioPlayerState == PlayerState.playing) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(DeviceFileSource(widget.incident.audioPath!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del incidente'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ProfileScreen(userId: widget.incident.userId),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconWithText(
                icon: Icons.title,
                text: 'Titulo: ${widget.incident.title}',
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              IconWithText(
                icon: Icons.description,
                text: 'Descripción: ${widget.incident.description}',
                color: Colors.white54,
              ),
              const SizedBox(height: 8),
              IconWithText(
                icon: Icons.date_range,
                text: 'Fecha: ${widget.incident.date}',
                color: Colors.white70,
              ),
              if (widget.incident.photoPath != null) ...[
                const SizedBox(height: 16),
                IconWithText(
                  icon: Icons.image,
                  text: 'Foto:',
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                Image.file(File(widget.incident.photoPath!)),
              ],
              if (widget.incident.audioPath != null) ...[
                const SizedBox(height: 16),
                IconWithText(
                  icon: Icons.audiotrack,
                  text: 'Audio:',
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                Text(widget.incident.audioPath!,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.white70)),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: _playPauseAudio,
                  icon: Icon(
                    _audioPlayerState == PlayerState.playing
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                  label: Text(_audioPlayerState == PlayerState.playing
                      ? 'Pausar Audio'
                      : 'Reproducir Audio'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
