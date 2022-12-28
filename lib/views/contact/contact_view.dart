import '../../controllers/contact/contact_view_controller.dart';
import '../../export.dart';
import '../../models/mail/send_mail_req_model.dart';
import '../../services/contact/contact_service.dart';

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

  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

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
                          controller.categoryError = false;
                        },
                      );
                    }),
                  ),
                  Obx(() {
                    return controller.categoryError
                        ? Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.005,
                              ),
                              SizedBox(
                                width: Get.width * 0.8,
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/info-circle.svg'),
                                    SizedBox(
                                      width: Get.width * 0.01,
                                    ),
                                    Text(
                                      'Lütfen kategori seçiniz!',
                                      style: TextStyle(
                                        color: Color(0xFFFF6666),
                                        fontFamily: 'Mulish-Medium',
                                        fontSize: Get.width * 0.035,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : SizedBox();
                  }),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
                    width: Get.width * 0.8,
                    child: TextFormField(
                      cursorColor: AppConstants.kHintText,
                      controller: nameController,
                      onChanged: (value) {
                        controller.nameError = false;
                      },
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
                  Obx(() {
                    return controller.nameError
                        ? Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.005,
                              ),
                              SizedBox(
                                width: Get.width * 0.8,
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/info-circle.svg'),
                                    SizedBox(
                                      width: Get.width * 0.01,
                                    ),
                                    Text(
                                      'Ad Soyad boş bırakılamaz!',
                                      style: TextStyle(
                                        color: Color(0xFFFF6666),
                                        fontFamily: 'Mulish-Medium',
                                        fontSize: Get.width * 0.035,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : SizedBox();
                  }),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
                    width: Get.width * 0.8,
                    child: TextFormField(
                      onChanged: (value) {
                        controller.mailError = false;
                      },
                      cursorColor: AppConstants.kHintText,
                      keyboardType: TextInputType.emailAddress,
                      controller: mailController,
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
                  Obx(() {
                    return controller.mailError
                        ? Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.005,
                              ),
                              SizedBox(
                                width: Get.width * 0.8,
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/info-circle.svg'),
                                    SizedBox(
                                      width: Get.width * 0.01,
                                    ),
                                    Text(
                                      'Geçersiz mail adresi!',
                                      style: TextStyle(
                                        color: Color(0xFFFF6666),
                                        fontFamily: 'Mulish-Medium',
                                        fontSize: Get.width * 0.035,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : SizedBox();
                  }),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  SizedBox(
                    height: Get.height * 0.2,
                    width: Get.width * 0.8,
                    child: TextFormField(
                      controller: messageController,
                      onChanged: (value) {
                        if (value.length > 50) controller.messageError = false;
                      },
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
                  Obx(() {
                    return controller.messageError
                        ? Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.005,
                              ),
                              SizedBox(
                                width: Get.width * 0.8,
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/info-circle.svg'),
                                    SizedBox(
                                      width: Get.width * 0.01,
                                    ),
                                    Flexible(
                                      child: Text(
                                        'Mesajınız çok kısa! Mesajınız en az 50 karakterden oluşmalıdır.',
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Color(0xFFFF6666),
                                          fontFamily: 'Mulish-Medium',
                                          fontSize: Get.width * 0.035,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : SizedBox();
                  }),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  InkWell(
                    onTap: () {
                      if (controller.value == '') {
                        controller.categoryError = true;
                      }

                      if (!mailController.text.isEmail) {
                        controller.mailError = true;
                      }

                      if (nameController.text.isEmpty) {
                        controller.nameError = true;
                      }

                      if (messageController.text.length < 50) {
                        controller.messageError = true;
                      }

                      if (!controller.categoryError && !controller.nameError && !controller.mailError && !controller.messageError) {
                        controller.loading = true;
                        ContactService()
                            .sendMail(SendMailReqModel(
                                category: controller.value,
                                mailBody: messageController.text,
                                eMail: mailController.text,
                                userName: nameController.text))
                            .then((value) {
                          controller.loading = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(milliseconds: 1600),
                              content: Container(
                                height: Get.height * 0.08,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: AppConstants.kAppGrey.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset('assets/icons/like.svg'),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                        child: Text(
                                          'Mesajınız başarıyla gönderildi. Bizimle iletişime geçtiğiniz için teşekkür ederiz 😊',
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontFamily: 'Mulish-ExtraBold',
                                            color: Colors.white,
                                            fontSize: Get.width * 0.03,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          Get.back();
                        });
                      }
                    },
                    child: Container(
                      height: Get.height * 0.06,
                      width: Get.width * 0.8,
                      decoration: BoxDecoration(
                        color: AppConstants.kPrimaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Obx(() {
                        return Center(
                          child: controller.loading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Gönder',
                                  style: TextStyle(color: Colors.white, fontFamily: 'Mulish-ExtraBold', fontSize: Get.width * 0.05),
                                ),
                        );
                      }),
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
