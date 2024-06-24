import 'package:flutter/material.dart';

class TicketEmpty extends StatelessWidget {
  final VoidCallback onAddTicket;
  // const TicketEmpty({super.key});
  const TicketEmpty({super.key, required this.onAddTicket});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.black,
      height: MediaQuery.of(context).size.height,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
                color: Colors.white,
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 40, 25, 40),
                  child: Column(
                    children: <Widget>[
                      const Center(
                        child: Image(
                            image: AssetImage('assets/images/item-empty.png'),
                            width: 300,
                            height: 300),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 60),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Hallo Users',
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(
                              'Untuk saat ini data masih kosong, tekan tombol dibawah untuk menambahkan data baru.',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onAddTicket,
                        // onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(335, 50),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            Text(
                              'Tambah Perangkat',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
          ]),
    );
  }
}
