// device_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_e_service_app/controller/device_controller.dart';
import 'package:flutter_e_service_app/model/device_model.dart';
import 'package:flutter_e_service_app/ui/device_particle/deviceEmpty.dart';
import 'package:flutter_e_service_app/ui/device_particle/deviceNotEmpty.dart';
import 'package:flutter_e_service_app/ui/device_particle/deviceForm.dart'; // Import the new DeviceForm widget

class DeviceView extends StatefulWidget {
  const DeviceView({super.key});

  @override
  State<DeviceView> createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  List<DeviceModel> devices = [];

  bool showForm = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _driveLinkController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _animation;

  Future<void> _getDeviceData() async {
    var response = await DeviceController().index();
    setState(() {
      devices = response;
    });
  }

  @override
  void initState() {
    _getDeviceData();
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _yearController.dispose();
    _driveLinkController.dispose();
    super.dispose();
  }

  void _toggleFormVisibility() {
    setState(() {
      if (showForm) {
        _animationController.reverse().then((_) {
          setState(() {
            showForm = false;
          });
        });
      } else {
        showForm = true;
        _animationController.forward();
      }
    });
  }

  Future<void> _addDevice() async {
    if (!_formKey.currentState!.validate()) {
      return; // Jika form tidak valid, hentikan eksekusi fungsi
    }

    setState(() {
      isLoading = true;
    });

    // Replace with actual user ID retrieval logic
    String userId = '1';
    String deviceName = _nameController.text;
    String deviceYear = _yearController.text;
    String driveLink = _driveLinkController.text;

    bool success = await DeviceController()
        .store(userId, deviceName, deviceYear, driveLink);

    setState(() {
      isLoading = false;
    });

    if (success) {
      // Optionally, you can fetch the updated device list from the server
      await _getDeviceData();
      _toggleFormVisibility();
      _formKey.currentState!.reset();
      _nameController.clear();
      _yearController.clear();
      _driveLinkController.clear();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Row(children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
            child: const Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
          ),
          const Text('Berhasil menambahkan data Perangkat!')
        ])),
      );
    } else {
      // Handle the error, e.g., show a message to the user
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Row(children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
            child: const Icon(
              Icons.cancel,
              color: Colors.white,
            ),
          ),
          const Text('Galat menambahkan data Perangkat!')
        ])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/mydoodle.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (showForm)
                SlideTransition(
                  position: _animation,
                  child: DeviceForm(
                    formKey: _formKey,
                    nameController: _nameController,
                    yearController: _yearController,
                    driveLinkController: _driveLinkController,
                    isLoading: isLoading,
                    toggleFormVisibility: _toggleFormVisibility,
                    addDevice: _addDevice,
                  ),
                )
              else if (devices.isEmpty)
                DeviceEmpty(onAddDevice: _toggleFormVisibility)
              else
                DeviceNotEmpty(
                    devices: devices, onAddDevice: _toggleFormVisibility),
            ],
          ),
        )
      ]),
    );
  }
}
