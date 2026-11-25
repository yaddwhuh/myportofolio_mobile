import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _techStack = '';
  String _projectUrl = '';
  String _projectImageUrl = '';
  bool _isSubmitting = false;

  bool _isValidHttpUrl(String value) {
    final uri = Uri.tryParse(value.trim());
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final loggedIn = await ensureLoggedIn(context);
    if (!mounted || !loggedIn) return;

    final token = context.read<AuthState>().token;
    if (token == null) return;

    setState(() {
      _isSubmitting = true;
    });

    final newProject = Project(
      projectName: _title.trim(),
      description: _description.trim(),
      technologies: _techStack.trim(),
      projectLink: _projectUrl.trim(),
      projectImageUrl: _projectImageUrl.trim(),
    );

    try {
      final created = await context.read<ApiClient>().createProject(
        newProject,
        token: token,
      );
      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Proyek berhasil ditambahkan!'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Title: ${created.projectName}'),
                  Text('Description: ${created.description}'),
                  Text('Tech Stack: ${created.technologies}'),
                  Text('Project URL: ${created.projectLink}'),
                  if (created.projectImageUrl.isNotEmpty)
                    Text('Project Image URL: ${created.projectImageUrl}'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  _formKey.currentState!.reset();
                  setState(() {
                    _title = '';
                    _description = '';
                    _techStack = '';
                    _projectUrl = '';
                    _projectImageUrl = '';
                  });
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } on ApiException catch (e) {
      if (!mounted) return;

      if (e.statusCode == 401) {
        await context.read<AuthState>().logout();
        if (!mounted) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Sesi berakhir (401). Silakan login ulang.'),
            ),
          );
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                'Gagal menyimpan proyek (HTTP ${e.statusCode}): ${e.message}',
              ),
            ),
          );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Project Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Title ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Judul Proyek',
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _title = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Title tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Deskripsi Proyek',
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _description = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Description tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // === Tech Stack ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Contoh: Flutter, Django, PostgreSQL',
                    labelText: 'Tech Stack',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _techStack = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Tech Stack tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // === Project URL ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: 'https://github.com/username/project',
                    labelText: 'Project URL',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _projectUrl = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Project URL tidak boleh kosong!';
                    }
                    if (!_isValidHttpUrl(value)) {
                      return 'Masukkan URL yang valid (diawali http:// atau https://)!';
                    }
                    return null;
                  },
                ),
              ),

              // === Project Image URL (Optional) ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: 'https://example.com/preview.png (opsional)',
                    labelText: 'Project Image URL (Optional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _projectImageUrl = value,
                  validator: (value) {
                    if (value != null &&
                        value.trim().isNotEmpty &&
                        !_isValidHttpUrl(value)) {
                      return 'Masukkan URL gambar yang valid (diawali http:// atau https://)!';
                    }
                    return null;
                  },
                ),
              ),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
