import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto_mobile_app/blocs/social_media_bloc/social_media_bloc.dart';
import 'package:tobeto_mobile_app/blocs/social_media_bloc/social_media_event.dart';
import 'package:tobeto_mobile_app/blocs/social_media_bloc/social_media_state.dart';
import 'package:tobeto_mobile_app/screens/profile_editting/widgets/custom_column.dart';
import 'package:tobeto_mobile_app/screens/profile_editting/widgets/custom_dropdown_input.dart';
import 'package:tobeto_mobile_app/screens/profile_editting/widgets/custom_elevated_button.dart';
import 'package:tobeto_mobile_app/screens/profile_editting/widgets/custom_mini_card.dart';
import 'package:tobeto_mobile_app/screens/profile_editting/widgets/custom_textfield.dart';
import 'package:tobeto_mobile_app/screens/profile_editting/widgets/custom_title.dart';
import 'package:tobeto_mobile_app/screens/profile_editting/widgets/input_text.dart';
import 'package:tobeto_mobile_app/utils/constant/constants.dart';
import 'package:tobeto_mobile_app/utils/snack_bar.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({super.key});

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  final TextEditingController socialMediaNameController =
      TextEditingController();
  final TextEditingController socialMediaLinkController =
      TextEditingController();
  String? errorMessage;
  bool _actionPerformed = false;

  void _clearControllers() {
    socialMediaNameController.clear();
    socialMediaLinkController.clear();
  }

  bool _areControllersValid() {
    if (socialMediaNameController.text.isNotEmpty &&
        socialMediaLinkController.text.isNotEmpty) {
      final socialMediaName = socialMediaNameController.text;
      final socialMediaLink = socialMediaLinkController.text;

      final patterns = {
        'Facebook': r'^(https?:\/\/)?(www\.)?facebook\.com\/.*$',
        'Twitter': r'^(https?:\/\/)?(www\.)?twitter\.com\/.*$',
        'Instagram': r'^(https?:\/\/)?(www\.)?instagram\.com\/.*$',
        'LinkedIn': r'^(https?:\/\/)?(www\.)?linkedin\.com\/.*$',
      };

      if (patterns.containsKey(socialMediaName)) {
        final regex = RegExp(patterns[socialMediaName]!);
        if (!regex.hasMatch(socialMediaLink)) {
          setState(() {
            errorMessage =
                'Lütfen $socialMediaName profil adresinizi kontrol ediniz.';
          });
          return false;
        }
      }

      setState(() {
        errorMessage = null;
      });
      return true;
    }
    return false;
  }

  void _addSocialMedia() {
    final media = {
      'socialMediaName': socialMediaNameController.text,
      'socialMediaLink': socialMediaLinkController.text,
    };
    context.read<SocialMediaBloc>().add(AddSocialMedia(media));
    _clearControllers();
    _actionPerformed = true;
  }

  Map<String, String> socialMediaIcons = {
    'Facebook': ImagePath.facebook,
    'Twitter': ImagePath.blackX,
    'Instagram': ImagePath.instagram,
    'LinkedIn': ImagePath.linkedin,
  };

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialMediaBloc, SocialMediaState>(
      listener: (context, state) {
        if (_actionPerformed) {
          if (!state.isLoading) {
            if (state.error != null) {
              snackBar(context, "İşleminiz başarısız: ${state.error}");
            } else {
              snackBar(context, "İşleminiz başarılı!",
                  bgColor: TobetoColor.state.success);
            }
            _actionPerformed =
                false; // Reset the flag after handling the result
          }
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.error != null) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return ListView(
          children: [
            CustomTitle(title: TobetoText.profileEditSocialMedia),
            InputText(
              child: CustomDropDownInput(
                onChanged: (newValue) {
                  socialMediaNameController.text =
                      newValue ?? socialMediaNameController.text;
                },
                items: TobetoText.socialMediaName.map((label) {
                  return DropdownMenuItem(
                    value: label,
                    child: Text(label),
                  );
                }).toList(),
                title: TobetoText.profileEditSocialMediaName,
                controller: socialMediaNameController,
              ),
            ),
            InputText(
              child: CustomTextField(
                title: TobetoText.profileEditSocialMediaLink,
                controller: socialMediaLinkController,
              ),
            ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            CustomElevatedButton(
              onPressed: () {
                if (_areControllersValid() &&
                    !state.media
                        .toString()
                        .contains(socialMediaNameController.text)) {
                  _addSocialMedia();
                } else if (state.media
                    .toString()
                    .contains(socialMediaNameController.text)) {
                  snackBar(context, TobetoText.alertSocialMedia);
                }
              },
            ),
            if (state.media.isEmpty)
              CustomColumn(title: TobetoText.emptySocialMedia)
            else
              ...state.media.map((media) {
                final socialMediaName = media['socialMediaName'];
                final iconPath = socialMediaIcons[socialMediaName] ?? '';
                return InputText(
                  child: CustomMiniCard(
                    imagepath: Image.asset(iconPath),
                    onpressed: () {
                      context
                          .read<SocialMediaBloc>()
                          .add(RemoveSocialMedia(media));
                    },
                    title: media['socialMediaLink'],
                  ),
                );
              })
          ],
        );
      },
    );
  }
}
