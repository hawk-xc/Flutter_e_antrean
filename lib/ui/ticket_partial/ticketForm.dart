import 'package:flutter/material.dart';

class TicketForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController driveLinkController;
  final bool isLoading;
  final VoidCallback toggleFormVisibility;
  final VoidCallback addDevice;
  final bool isEditing;
  final VoidCallback? deleteDevice;

  TicketForm({
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
    required this.driveLinkController,
    required this.isLoading,
    required this.toggleFormVisibility,
    required this.addDevice,
    required this.isEditing,
    this.deleteDevice,
    Key? key,
  }) : super(key: key);

  @override
  _TicketFormState createState() => _TicketFormState();
}

class _TicketFormState extends State<TicketForm> {
  String? _selectedItem;
  final List<String> _items = ['Item 1', 'Item 2', 'Item 3'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Form(
              key: widget.formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        widget.isEditing ? 'Edit Antrean' : 'Tambah Antrean',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F7EF),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info, color: Colors.black),
                              SizedBox(width: 8.0),
                              Text(
                                'Perhatian',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '• Pastikan menambahkan perangkat yang anda pilih dengan benar',
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '• Berikan deskripsi yang jelas untuk kendala atau kerusakan dari perangkat yang anda pilih',
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(height: 4.0),
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.symmetric(
                  //       horizontal: 20, vertical: 15),
                  //   child: TextFormField(
                  //     controller: widget.nameController,
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return 'Nama perangkat wajib diisi!';
                  //       }
                  //       return null;
                  //     },
                  //     decoration: InputDecoration(
                  //       labelText: 'Nama Perangkat',
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: DropdownButtonFormField<String>(
                      value: _selectedItem,
                      decoration: InputDecoration(
                        labelText: 'Pilih Item',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: _items.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedItem = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select an item';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: TextFormField(
                      controller: widget.descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tahun perangkat wajib diisi!';
                        } else if (int.tryParse(value) == null) {
                          return 'Tahun perangkat harus berupa angka';
                        } else if (int.parse(value) > DateTime.now().year) {
                          return 'Tahun perangkat tidak boleh melebihi tahun sekarang';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Deskripsi Kerusakan',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        // keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: TextFormField(
                      controller: widget.driveLinkController,
                      decoration: InputDecoration(
                        labelText: 'Drive Link',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  widget.isLoading
                      ? const CircularProgressIndicator()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: widget.toggleFormVisibility,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade200,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Padding(
                                padding: widget.isEditing
                                    ? const EdgeInsets.fromLTRB(2, 12, 2, 12)
                                    : const EdgeInsets.fromLTRB(25, 12, 25, 12),
                                child: const Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                    Text('Batalkan',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14)),
                                  ],
                                ),
                              ),
                            ),
                            if (widget.isEditing)
                              ElevatedButton(
                                onPressed: widget.deleteDevice,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(2, 12, 2, 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delete_outline,
                                        color: Colors.white,
                                      ),
                                      Text('Hapus',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14)),
                                    ],
                                  ),
                                ),
                              ),
                            ElevatedButton(
                              onPressed: widget.addDevice,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Padding(
                                padding: widget.isEditing
                                    ? const EdgeInsets.fromLTRB(2, 12, 2, 12)
                                    : const EdgeInsets.fromLTRB(25, 12, 25, 12),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                    Text(widget.isEditing ? 'Ubah' : 'Simpan',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 14)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
