// ignore_for_file: file_names

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_cropper_for_web/image_cropper_for_web.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class PickImageScreen extends StatefulWidget {
  const PickImageScreen({super.key});

  @override
  State<PickImageScreen> createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  File? imageFile;
  late Uint8List pickedImageAsBytes;
  bool isCrop = false;
  late File image;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePickerPlugin().pickImage(
      source: ImageSource.gallery,
    );
    pickedImageAsBytes = await pickedImage.readAsBytes();
    imageFile = File(
      pickedImage.path,
    );
    setState(() {});
    Timer(
      const Duration(milliseconds: 100),
      () {
        _cropImage();
      },
    );
  }

  Future<void> _takePhoto() async {
    final pickedImage = await ImagePickerPlugin().pickImage(
      source: ImageSource.camera,
    );

    pickedImageAsBytes = await pickedImage.readAsBytes();
    imageFile = File(
      pickedImage.path,
    );
    setState(() {});
    Timer(
      const Duration(milliseconds: 100),
      () {
        _cropImage();
      },
    );
  }

  Future<void> _cropImage() async {
    if (imageFile != null) {
      CroppedFile? cropped = await ImageCropperPlugin().cropImage(
        sourcePath: imageFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            cropGridColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(title: 'Cropper'),
          WebUiSettings(
            context: context,
            boundary: CroppieBoundary(
              width: getWidth(context, 250).toInt(),
              height: getHeight(context, 250).toInt(),
            ),
            viewPort: const CroppieViewPort(
              width: 200,
              height: 200,
              type: 'circle',
            ),
            enableZoom: true,
            mouseWheelZoom: true,
            showZoomer: false,
            translations: const WebTranslations(
              title: 'Маштабирование',
              rotateLeftTooltip: 'Поворот влево',
              rotateRightTooltip: 'Поворот вправо',
              cancelButton: 'Отмена',
              cropButton: 'Обрезать',
            ),
          ),
        ],
      );

      if (cropped != null) {
        imageFile = File(cropped.path);
        pickedImageAsBytes = await cropped.readAsBytes();
        isCrop = true;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: state.isDark
              ? AppTheme.backgroundColor
              : const Color.fromRGBO(240, 247, 254, 1),
          appBar: const CustomAppBarRegistration(
            name: 'Сервис желанных подарков',
          ),
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: getHeight(context, 31),
                ),
                SizedBox(
                  height: getHeight(context, 497),
                  width: getWidth(context, 250),
                  child: imageFile != null
                      ? DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromRGBO(110, 210, 182, 1),
                            ),
                            color: const Color.fromRGBO(110, 210, 182, 0.05),
                          ),
                          child: isCrop
                              ? Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: getHeight(context, 50),
                                    ),
                                    child: SizedBox(
                                      height: getHeight(context, 240),
                                      width: getWidth(context, 240),
                                      child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color.fromRGBO(
                                                  110, 210, 182, 1),
                                            ),
                                            color: const Color.fromRGBO(
                                                110, 210, 182, 0.05),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.memory(
                                            pickedImageAsBytes,
                                            fit: BoxFit.fill,
                                          ) //Image.file(imageFile!),
                                          ),
                                    ),
                                  ),
                                )
                              : Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: getHeight(context, 50),
                                        ),
                                        child: SizedBox(
                                          height: getHeight(context, 240),
                                          width: getWidth(context, 240),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      110, 210, 182, 1)),
                                              color: const Color.fromRGBO(
                                                  110, 210, 182, 0.05),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Opacity(
                                      opacity: 0.8,
                                      child: Image.memory(
                                        pickedImageAsBytes,
                                        fit: BoxFit.fill,
                                      ),
                                    ), //Image.file(imageFile!),
                                  ],
                                ),
                        )
                      : DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromRGBO(110, 210, 182, 1),
                            ),
                            color: const Color.fromRGBO(110, 210, 182, 0.05),
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: getHeight(context, 50),
                              ),
                              child: SizedBox(
                                height: getHeight(context, 240),
                                width: getWidth(context, 240),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          110, 210, 182, 1),
                                    ),
                                    color: const Color.fromRGBO(
                                        110, 210, 182, 0.05),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buttonGreen(
                          context,
                          title: 'Добавить фотографию',
                          fontSize: 14,
                          onTap: _pickImage,
                        ),
                        buttonGreen(
                          context,
                          title: 'Сделать фотографию',
                          fontSize: 14,
                          onTap: _takePhoto,
                        ),
                        buttonGreen(
                          context,
                          title: 'Сохранить и\nпродолжить',
                          fontSize: 14,
                          onTap: () {
                            Navigator.pop(context, pickedImageAsBytes);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buttonGreen(
    BuildContext context, {
    required String title,
    double? fontSize,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: getWidth(context, 100),
        height: getHeight(context, 50),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(98, 198, 170, 0.3),
                Color.fromRGBO(68, 168, 140, 0.3),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color.fromRGBO(98, 198, 170, 1),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextLocalStyles.roboto500.copyWith(
                color: const Color.fromRGBO(110, 210, 182, 1),
                fontSize: fontSize,
                height: 16.41 / 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
