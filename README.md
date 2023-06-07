# icloud_kv_storage

A Key Value Storage Flutter Plugin Sync multiple iOS & Mac Devices base on iCloud.

![Snip20230607_1](https://github.com/JerryFans/icloud_kv_storage/assets/14149080/3c622c18-f5d7-49b2-a2ff-2e63634229b6)

## Usage

NOTE: It is recommended to use real device testing for iOS devices as the iOS simulator may not synchronize in real-time. Mac devices can be compiled and tested directly. Only the same iCloud account needs to be logged in on different Apple devices to synchronize lightweight Key Value data.

- FirstStep:

Enable your iOS Or Mac Project iCloud Key Value Services.

![image](https://github.com/JerryFans/icloud_kv_storage/assets/14149080/09325cd2-ac57-4e27-a716-e819c06d3a69)

- And Then Enjoy It.

Sample Code.

```
import 'package:icloud_kv_storage/icloud_kv_storage.dart';

var iCloudStorage = CKKVStorage();
```

Update A Key

```
void _incrementCounter() {
    setState(() {
      _counter++;
      iCloudStorage.writeString(key: key, value: _counter.toString());
    });
  }

```

Read A Key

```
iCloudStorage.getString('k_storage_count').then((value) {
      if (value != null) {
        setState(() {
          _counter = int.parse(value);
        });
      }
    });
```

Delete A Key
```
void _clearCounter() {
    setState(() {
      _counter = 0;
      iCloudStorage.delete(key);
    });
  }
```

Real Time Call Back Key Value Update on other devices 
```
iCloudStorage.onCloudKitKVUpdateCallBack(
      onCallBack: (kvMap) {
        print('receive icloud_key_update map $kvMap');
        //if receive remove key will rec {flutter.k_storage_count: null}
        //if receive update key will rec {flutter.k_storage_count: 1}
        //because have prefix flutter. so need use my method to get real key.
        var key = iCloudStorage.getRealKey('k_storage_count');
        if (kvMap.containsKey(key)) {
          String? value = kvMap[key];
          setState(() {
            if (value != null) {
              _counter =
                int.parse(kvMap[iCloudStorage.getRealKey('k_storage_count')]);
            } else {
              _counter = 0;
            }
          });
        }
      },
    );
```

## Release Log

### 0.0.1

Based on Apple CloudKit, lightweight Key value storage data can be synchronized between different Apple devices, such as iOS and Mac devices. For the time being, only String data can be synchronized.

## Future

Currently, only String data is supported, and basic data types such as int and double will be added in the future
 
