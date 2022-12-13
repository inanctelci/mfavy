import '../../controllers/contact/contact_view_controller.dart';
import '../../export.dart';

class ContactView extends StatelessWidget {
  ContactView({super.key});

  List<DropdownMenuItem<String>> categories = <DropdownMenuItem<String>>[
    const DropdownMenuItem<String>(
      value: 'Sorun',
      child: Text(
        'Sorun',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Mulish-Medium',
        ),
      ),
    ),
    const DropdownMenuItem<String>(
      value: 'Reklam',
      child: Text(
        'Reklam',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Mulish-Medium',
        ),
      ),
    ),
    const DropdownMenuItem<String>(
      value: 'İletişim',
      child: Text(
        'İletişim',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Mulish-Medium',
        ),
      ),
    ),
    const DropdownMenuItem<String>(
      value: 'Telif',
      child: Text(
        'Telif Bildirimi',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Mulish-Medium',
        ),
      ),
    ),
    const DropdownMenuItem<String>(
      value: 'Teşekkür',
      child: Text(
        'Teşekkür',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Mulish-Medium',
        ),
      ),
    ),
    const DropdownMenuItem<String>(
      value: 'VIP',
      child: Text(
        'VIP Uyelik',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Mulish-Medium',
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    ContactViewController controller = Get.put<ContactViewController>(ContactViewController());
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      appBar: AppBar(
        backgroundColor: AppConstants.kAppBlack,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'İletişim',
          style: TextStyle(
            fontFamily: 'Mulish-ExtraBold',
            color: Colors.white,
            fontSize: Get.width * 0.05,
          ),
        ),
      ),
      body: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSwatch(
              accentColor: Colors.white,
            ),
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              width: Get.width,
              height: Get.height * 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bizimle iletişime geçin!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width * 0.05,
                      fontFamily: 'Mulish-ExtraBold',
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Text(
                    'İletişim bilgilerinizi ve mesajınızı bırakın, size ulaşalım.',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width * 0.03,
                      fontFamily: 'Mulish-ExtraBold',
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: Get.width * 0.03,
                    ),
                    height: Get.height * 0.06,
                    width: Get.width * 0.8,
                    decoration: BoxDecoration(
                      color: AppConstants.kBoxGrey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Obx(() {
                      return DropdownButton(
                        underline: const SizedBox(),
                        value: controller.value == '' ? null : controller.value,
                        dropdownColor: AppConstants.kBoxGrey,
                        hint: const Text(
                          'Kategori seçiniz',
                          style: TextStyle(
                            color: AppConstants.kHintText,
                            fontFamily: 'Mulish-Medium',
                          ),
                        ),
                        icon: const SizedBox(),
                        items: categories,
                        onChanged: (value) {
                          controller.value = value;
                        },
                      );
                    }),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
                    width: Get.width * 0.8,
                    child: TextFormField(
                      cursorColor: AppConstants.kHintText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Mulish-Medium',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Adınız soyadınız',
                        hintStyle: const TextStyle(
                          color: AppConstants.kHintText,
                          fontFamily: 'Mulish-Medium',
                        ),
                        filled: true,
                        fillColor: AppConstants.kBoxGrey,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: AppConstants.kHintText,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
                    width: Get.width * 0.8,
                    child: TextFormField(
                      cursorColor: AppConstants.kHintText,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Mulish-Medium',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Mail adresiniz',
                        hintStyle: const TextStyle(
                          color: AppConstants.kHintText,
                          fontFamily: 'Mulish-Medium',
                        ),
                        filled: true,
                        fillColor: AppConstants.kBoxGrey,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: AppConstants.kHintText,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  SizedBox(
                    height: Get.height * 0.2,
                    width: Get.width * 0.8,
                    child: TextFormField(
                      maxLines: 10,
                      cursorColor: AppConstants.kHintText,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Mulish-Medium',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Mesajınız',
                        hintStyle: const TextStyle(
                          color: AppConstants.kHintText,
                          fontFamily: 'Mulish-Medium',
                        ),
                        filled: true,
                        fillColor: AppConstants.kBoxGrey,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: AppConstants.kHintText,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.8,
                    decoration: BoxDecoration(
                      color: AppConstants.kPrimaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        'Gönder',
                        style: TextStyle(color: Colors.white, fontFamily: 'Mulish-ExtraBold', fontSize: Get.width * 0.05),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
