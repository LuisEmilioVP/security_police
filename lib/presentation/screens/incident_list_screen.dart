import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:security_police_app/domain/entities/user.dart';
import 'package:security_police_app/domain/entities/incident.dart';
import 'package:security_police_app/domain/usecases/get_incidents.dart';
import 'package:security_police_app/presentation/screens/profile_screen.dart';
import 'package:security_police_app/presentation/components/icon_with_text.dart';
import 'package:security_police_app/presentation/screens/add_incident_screen.dart';
import 'package:security_police_app/presentation/screens/incident_detail_screen.dart';

class IncidentListScreen extends StatefulWidget {
  final User user;

  const IncidentListScreen({Key? key, required this.user}) : super(key: key);

  @override
  createState() => _IncidentListScreenState();
}

class _IncidentListScreenState extends State<IncidentListScreen> {
  late Future<List<Incident>> _incidentsFuture;

  @override
  void initState() {
    super.initState();
    final getIncidents = GetIt.instance<GetIncidents>();
    print(
        'Cargando incidentes para el usuario: ${widget.user.id}, rol: ${widget.user.role}');
    _incidentsFuture = getIncidents.call(widget.user.id!, widget.user.role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Incidentes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(userId: widget.user.id!),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Incident>>(
        future: _incidentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar incidentes: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red, fontSize: 18)),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No se encontraron incidentes',
                  style: TextStyle(color: Colors.red, fontSize: 18)),
            );
          }

          final incidents = snapshot.data!;

          return ListView.builder(
            itemCount: incidents.length,
            itemBuilder: (context, index) {
              final incident = incidents[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: IconWithText(
                    icon: Icons.report,
                    text: incident.title,
                    color: Colors.blue,
                  ),
                  subtitle: IconWithText(
                    icon: Icons.description,
                    text: incident.description,
                    color: Colors.grey,
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.blue),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IncidentDetailScreen(
                          incident: incident,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddIncidentScreen(user: widget.user),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
