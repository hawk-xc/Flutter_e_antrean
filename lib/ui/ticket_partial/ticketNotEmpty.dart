import 'package:flutter/material.dart';
import 'package:flutter_e_service_app/model/ticket_model.dart';

class TicketNotEmpty extends StatelessWidget {
  final String? username;
  final List<Ticket> tickets;
  final VoidCallback onAddDevice;
  final Function(Ticket) onEditDevice;

  const TicketNotEmpty({
    super.key,
    required this.username,
    required this.tickets,
    required this.onAddDevice,
    required this.onEditDevice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card(
          color: Colors.white,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Antrean Anda'),
                    Text(
                      tickets.length.toString(),
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: onAddDevice,
                  child: const Row(children: [Icon(Icons.add), Text("Tambah")]),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: tickets.isEmpty
                ? const CircularProgressIndicator()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = tickets[index];
                      return GestureDetector(
                        onTap: () => onEditDevice(ticket),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 5),
                          decoration: BoxDecoration(
                              color: const Color(0xFFEFF0F9),
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.devices),
                            ),
                            title: Text(
                              ticket.device.deviceName,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  const Icon(
                                    Icons.person,
                                    size: 12,
                                  ),
                                  Text(
                                    // ticket.process.userId.toString(),
                                    username ?? "guest",
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                                Row(children: [
                                  const Icon(Icons.access_alarm, size: 12),
                                  Text(
                                    ticket.createdAtDiff.toString(),
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
