import 'package:agendacliente/ajudantes/appbargeral.dart';
import 'package:agendacliente/ajudantes/cores.dart';
import 'package:agendacliente/ajudantes/drawergeral.dart';
import 'package:agendacliente/modelo/singleton.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatefulWidget {
  const new({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    Map<String, Color> cores = corAjuda.getMetod(PrefsService.instance.cor);
    return Scaffold(
      backgroundColor: cores['corDeFundoPrincipal'],
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: ListView(
            children: [
              TableCalendar(
                locale: 'pt_BR',
                firstDay: DateTime.now().add(Duration(days: -365)),
                lastDay: DateTime.now().add(Duration(days: 365)),
                focusedDay: DateTime.now(),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  print(
                    'selectedDay + $selectedDay --------- focusedDay + $focusedDay ',
                  );
                  setState(() {
                    _selectedDay = selectedDay;
                  });
                },
                // onPageChanged: (focusedDay) {
                //   _focusedDay = focusedDay;
                // },
              ),
            ],
          ),
        ),
      ),
      drawer: Drawergeral(),
      appBar: Appbargeral(titulo: 'Sua Agenda'),
    );
  }
}
