import 'package:flutter/material.dart';
import 'package:flutter_e_service_app/controller/ticket_controller.dart';
import 'package:flutter_e_service_app/helpers/user_info.dart';
import 'package:flutter_e_service_app/model/device_model.dart';
import 'package:flutter_e_service_app/model/ticket_model.dart';
import 'package:flutter_e_service_app/ui/ticket_partial/ticketEmpty.dart';
import 'package:flutter_e_service_app/ui/ticket_partial/ticketForm.dart';
import 'package:flutter_e_service_app/ui/ticket_partial/ticketNotEmpty.dart';

class TicketView extends StatefulWidget {
  const TicketView({super.key});

  @override
  State<TicketView> createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView>
    with SingleTickerProviderStateMixin {
  String? _username;
  final TicketController _ticketController = TicketController();
  List<DeviceModel> _devices = [];
  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  List<Ticket> tickets = [];

  bool showForm = false;
  bool isEditing = false;
  Ticket? editingTicket;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _driveLinkController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _animation;

  Future<void> _getTicketData() async {
    var response = await TicketController().fetchTickets();
    setState(() {
      tickets = response;
    });
  }

  @override
  void initState() {
    _getTicketData();
    super.initState();
    _loadUsername();
    _fetchDevices();
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

  Future<void> _fetchDevices() async {
    try {
      List<DeviceModel> devices = await _ticketController.fetchDevices();
      setState(() {
        _devices = devices;
        _isLoading = false;
      });
      // print(
      //     'Devices fetched: ${devices.map((device) => device.deviceName).toList()}');
    } catch (e) {
      print('Failed to load devices: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadUsername() async {
    UserInfo userInfo = UserInfo();
    String? username = await userInfo.getUsername();
    setState(() {
      _username = username;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _driveLinkController.dispose();
    super.dispose();
  }

  void _toggleFormVisibility({bool editing = false, Ticket? device}) {
    setState(() {
      if (showForm) {
        _animationController.reverse().then((_) {
          setState(() {
            showForm = false;
            isEditing = false;
            editingTicket = null;
            _resetControllers(); // Reset controllers when hiding form
          });
        });
      } else {
        if (editing && device != null) {
          _populateFormForEditing(device);
        } else {
          _resetControllers(); // Reset controllers when showing form for adding
        }
        showForm = true;
        isEditing = editing;
        _animationController.forward();
      }
    });
  }

  void _resetControllers() {
    _nameController.clear();
    _descriptionController.clear();
    _driveLinkController.clear();
  }

  // void _populateFormForEditing(Ticket ticket) {
  //   // _nameController.text = ticket.id.toString();
  //   final device = _devices.firstWhere((device) => device.id == ticket.id,
  //       orElse: () => null);
  //   if (device != null) {
  //     _nameController.text = device.deviceName;
  //   } else {
  //     _nameController.text = ticket.id.toString();
  //   }
  //   _descriptionController.text = ticket.description ?? '';
  //   _driveLinkController.text = ticket.imageLink ?? '';
  //   editingTicket = ticket;
  // }
  void _populateFormForEditing(Ticket ticket) {
    final device = _devices.firstWhere((device) => device.id == ticket.deviceId,
        orElse: () => DeviceModel(
              id: 0,
              userId: 0,
              userName: '',
              deviceName: '',
              deviceYear: '',
              createdAt: '',
              updatedAt: '',
              driveLink: '',
              imageLink: '',
              createdAtDiff: '',
            ));
    if (device.id != 0) {
      _nameController.text = device.deviceName;
    } else {
      _nameController.text = '';
    }
    _descriptionController.text = ticket.description ?? '';
    _driveLinkController.text = ticket.imageLink ?? '';
    editingTicket = ticket;
  }

  Future<void> _addOrEditTicket() async {
    if (!_formKey.currentState!.validate()) {
      return; // If the form is not valid, stop execution
    }

    setState(() {
      isLoading = true;
    });

    // String userId = '1';
    String deviceName = _nameController.text;
    String description = _descriptionController.text;
    String driveLink = _driveLinkController.text;
    bool success;

    if (isEditing && editingTicket != null) {
      success = await TicketController().update(
          editingTicket!.id,
          // userId,
          deviceName,
          description,
          driveLink);
    } else {
      success = await TicketController().store(
        // userId,
        deviceName,
        description,
        driveLink,
      );
    }

    setState(() {
      isLoading = false;
    });

    if (success) {
      await _getTicketData();
      _toggleFormVisibility();
      _formKey.currentState!.reset();
      _nameController.clear();
      _descriptionController.clear();
      _driveLinkController.clear();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
              ),
              Text(isEditing
                  ? 'Berhasil memperbarui data antrean!'
                  : 'Berhasil menambahkan data antrean!'),
            ],
          ),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
              ),
              Text(isEditing
                  ? 'Galat memperbarui data antrean!'
                  : 'Galat menambahkan data antrean!'),
            ],
          ),
        ),
      );
    }
  }

  Future<void> _deleteDevice() async {
    if (editingTicket != null) {
      setState(() {
        isLoading = true;
      });

      try {
        await TicketController().destroy(editingTicket!.id);
        await _getTicketData();
        _toggleFormVisibility();

        // Reset the form and clear the TextEditingControllers
        _formKey.currentState!.reset();
        _nameController.clear();
        _descriptionController.clear();
        _driveLinkController.clear();

        // Show a success snackbar
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
                SizedBox(width: 8.0),
                Text('Berhasil menghapus data perangkat!'),
              ],
            ),
          ),
        );
      } catch (error) {
        // Handle error (show error message, etc.)
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
                SizedBox(width: 8.0),
                Text('Galat menghapus data perangkat!'),
              ],
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
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
                  child: TicketForm(
                    formKey: _formKey,
                    deviceNames:
                        _devices.map((device) => device.deviceName).toList(),
                    nameController: _nameController,
                    descriptionController: _descriptionController,
                    driveLinkController: _driveLinkController,
                    isLoading: isLoading,
                    toggleFormVisibility: _toggleFormVisibility,
                    addTicket: _addOrEditTicket,
                    isEditing: isEditing,
                    deleteDevice: _deleteDevice,
                  ),
                )
              else if (tickets.isEmpty)
                TicketEmpty(onAddTicket: () => _toggleFormVisibility())
              else
                TicketNotEmpty(
                  tickets: tickets,
                  username: _username,
                  onAddTicket: () => _toggleFormVisibility(),
                  onEditTicket: (device) =>
                      _toggleFormVisibility(editing: true, device: device),
                ),
            ],
          ),
        )
      ]),
    );
  }
}
