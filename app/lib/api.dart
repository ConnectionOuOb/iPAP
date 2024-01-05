import 'package:file_picker/file_picker.dart';

Future<String> uploadFileSequence() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['fa', 'fasta'],
  );

  String fileName = "";
  if (result != null) {
    fileName = result.files.single.name;
  }

  return fileName;
}

Future<String> uploadFileStructure() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdb', 'mmcif'],
  );

  String fileName = "";
  if (result != null) {
    fileName = result.files.single.name;
  }

  return fileName;
}
