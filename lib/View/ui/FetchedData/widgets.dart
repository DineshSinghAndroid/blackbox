import 'dart:typed_data';

import 'package:blackbox/Utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ScanResultTile extends StatelessWidget {
  const ScanResultTile({Key? key, required this.result, this.onTap}) : super(key: key);

  final ScanResult result;
  final VoidCallback? onTap;

  Widget _buildTitle(BuildContext context) {
    if (result.device.name.length > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            result.device.name,
            overflow: TextOverflow.ellipsis,
          ),
          Text(result.device.id.toString(), style: TextStyle(color: Colors.black))
        ],
      );
    } else {
      return Text(result.device.id.toString());
    }
  }

  Widget _buildAdvRow(BuildContext context, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.black),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  String getNiceHexArray(List<int> bytes) {
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]'.toUpperCase();
  }

  String getNiceManufacturerData(Map<int, List<int>> data) {
    if (data.isEmpty) {
      return 'N/A';
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add('${id.toRadixString(16).toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  String getNiceServiceData(Map<String, List<int>> data) {
    if (data.isEmpty) {
      return 'N/A';
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add('${id.toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    var manufacturerData = Uint8List.fromList([0x01, 0xB7, 0x0A, 0x01, 0x2C, 0x0D, 0xFA, 0xC7, 0x00,  0xAC, 0x6B]);
    var flags = ByteData.sublistView(manufacturerData, 1).getUint8(0);
/*
0 – Temperature value presence
1 – Humidity value presence
2 – Magnetic sensor presence
3 – Magnetic sensor state (1 magnetic field is detected/0 magnetic field is not detected) Valid value is present only if bit 2 flag is set.
4 – Movement sensor counter
5 – Movement sensor angle
6 – Low Battery indication (if set to 1 low battery voltage detected)
7 – Battery voltage value presence
 */
    var flagTemperature = flags >> 0 & 1;
    var flagHumidity = flags >> 1 & 1;
    var flagMagPresence = flags >> 2 & 1;
    var flagMagState = flags >> 3 & 1;
    var flagMoveCount = flags >> 4 & 1;
    var flagMoveAngle = flags >> 5 & 1;
    var flagLowBatt = flags >> 6 & 1;
    var flagBattery = flags >> 7 & 1;
    var temperature = ByteData.sublistView(manufacturerData, 2, 4);
    var humidity = ByteData.sublistView(manufacturerData, 4, 5);
    var movement = ByteData.sublistView(manufacturerData, 5, 7);
    var movementStatus = movement.getUint16(0) >> 15 & 1;
    var movementCount = movement.getUint16(0) & 0x7fff;
    var devicePitch = ByteData.sublistView(manufacturerData, 7, 8);
    var deviceRoll = ByteData.sublistView(manufacturerData, 8, 10);
    var battery = ByteData.sublistView(manufacturerData, 10, 11);
    main() {
      print("Temperature Value presence: $flagTemperature");
      print("Humidity Value presence: $flagHumidity");
      print("Magnetic Value presence: $flagMagPresence");
      print("Magnetic State: $flagMagState");
      print("Move Sensor: $flagMoveCount");
      print("Move Angle: $flagMoveAngle");
      print("Low Battery: $flagLowBatt");
      print("Battery Value Presence: $flagBattery");
      print("Temperature: ${temperature.getUint16(0)  / 100}");
      print("Humidity: ${humidity.getUint8(0)}");
      print("Movement Status: $movementStatus");
      print("Movement count: $movementCount");
      print("Device Pitch: ${devicePitch.getInt8(0)}");
      print("Device Roll: ${deviceRoll.getInt16(0)}");
      print("Battery: ${2000 + (battery.getUint8(0) * 10)}");
    }

    return ExpansionTile(
      title: _buildTitle(context),
      leading: Text(result.rssi.toString()),
      trailing: MaterialButton(
        child: Text('CONNECT'),
        color: Colors.black,
        textColor: Colors.white,
        onPressed: (result.advertisementData.connectable) ? onTap : null,
      ),
      children: <Widget>[
        MaterialButton(onPressed: main,child:Text("Print"))
        ,
         _buildAdvRow(context, 'Complete Local Name', result.advertisementData.localName),
        _buildAdvRow(context, 'Tx Power Level', '${result.advertisementData.txPowerLevel ?? 'N/A'}'),
        _buildAdvRow(context, 'Manufacturer Data', getNiceManufacturerData(result.advertisementData.manufacturerData)),
        _buildAdvRow(context, 'Service UUIDs', (result.advertisementData.serviceUuids.isNotEmpty) ? result.advertisementData.serviceUuids.join(', ').toUpperCase() : 'N/A'),
        _buildAdvRow(context, 'Service Data', getNiceServiceData(result.advertisementData.serviceData)),
      ],
    );
  }
}

class ServiceTile extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile> characteristicTiles;

  const ServiceTile({Key? key, required this.service, required this.characteristicTiles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (characteristicTiles.length > 0) {
      return ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[Text('Service'), Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}', style: TextStyle(color: Colors.black))],
        ),
        children: characteristicTiles,
      );
    } else {
      return ListTile(
        title: Text('Service'),
        subtitle: Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}'),
      );
    }
  }
}

class CharacteristicTile extends StatelessWidget {
  final BluetoothCharacteristic characteristic;
  final List<DescriptorTile> descriptorTiles;
  final VoidCallback? onReadPressed;
  final VoidCallback? onWritePressed;
  final VoidCallback? onNotificationPressed;

  const CharacteristicTile({Key? key, required this.characteristic, required this.descriptorTiles, this.onReadPressed, this.onWritePressed, this.onNotificationPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
      stream: characteristic.value,
      initialData: characteristic.lastValue,
      builder: (c, snapshot) {
        final value = snapshot.data;
        return ExpansionTile(
          title: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[Text('Characteristic'), Text('0x${characteristic.uuid.toString().toUpperCase().substring(4, 8)}', style: TextStyle(color: Colors.black))],
            ),
            subtitle: Text(value.toString()),
            contentPadding: EdgeInsets.all(0.0),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.file_download,
                  color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                ),
                onPressed: onReadPressed,
              ),
              IconButton(
                icon: Icon(Icons.file_upload, color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                onPressed: onWritePressed,
              ),
              IconButton(
                icon: Icon(characteristic.isNotifying ? Icons.sync_disabled : Icons.sync, color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                onPressed: onNotificationPressed,
              )
            ],
          ),
          children: descriptorTiles,
        );
      },
    );
  }
}

class DescriptorTile extends StatelessWidget {
  final BluetoothDescriptor descriptor;
  final VoidCallback? onReadPressed;
  final VoidCallback? onWritePressed;

  const DescriptorTile({Key? key, required this.descriptor, this.onReadPressed, this.onWritePressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[Text('Descriptor'), Text('0x${descriptor.uuid.toString().toUpperCase().substring(4, 8)}', style: TextStyle(color: Colors.black))],
      ),
      subtitle: StreamBuilder<List<int>>(
        stream: descriptor.value,
        initialData: descriptor.lastValue,
        builder: (c, snapshot) => Text(snapshot.data.toString()),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.file_download,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
            ),
            onPressed: onReadPressed,
          ),
          IconButton(
            icon: Icon(
              Icons.file_upload,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
            ),
            onPressed: onWritePressed,
          )
        ],
      ),
    );
  }
}

class AdapterStateTile extends StatelessWidget {
  const AdapterStateTile({Key? key, required this.state}) : super(key: key);

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: ListTile(
        title: Text('Bluetooth adapter is ${state.toString().substring(15)}', style: TextStyle(color: Colors.black)),
        trailing: Icon(Icons.error, color: AppTheme.primaryColorBlue),
      ),
    );
  }
}
