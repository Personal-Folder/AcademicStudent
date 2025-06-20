import 'package:get/get.dart';

class LocaleTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        // English Translations
        'en': {
          'academic_student': "Academic Student",
          "welcome": "Welcome",
          // Common Stuff
          'okay': 'Okay',
          'cancel': 'Cancel',
          'loading': 'Loading',
          'arabic': 'Arabic',
          'english': 'English',
          'join': 'Join',
          'no_data_yet': 'There is no data yet',
          "recorded_videos": "Recorded Videos",
          'course_summary': "Summary",
          'send': 'Send',
          'for_technical_support_label': 'For Technical Support:',
          'try_with_email': 'Send OTP via Email',
          'try_with_phone': 'Send OTP via Phone Number',

          // Splash Screen Translations
          'copy_right': 'The Academic Student © 2023 All rights reserved.',
          'main_website': 'www.academic-student.com',

          // Login Screen Translations
          'login_title': 'Login',
          'login_button': 'Login',
          'forget_password': 'Forgot password',
          'register_instead': 'Don\'t have an account? Sign up',
          'password_hint': 'Password',
          'phone_number_hint': 'Phone Number',
          'email_hint': 'Email',

          // Register Screen Translations
          'register_title': 'New User',
          'register_button': 'Register',
          'country_label': 'Country',
          'university_label': 'University',
          'first_name_label': 'First Name',
          'father_name_label': 'Father Name',
          'last_name_label': 'Last Name',
          'phone_number_label': 'Phone Number',
          'university_id_label': 'University ID',
          'email_label': 'Email',
          'nationality_id_label': 'Nationality ID',

          'register_password_label': 'New Password',
          'register_confirm_password_label': 'Confirm Password',
          'login_instead': 'Already registered? Login here!',
          'registration_complete': 'Registration Complete',

          // OTP Verification SCreen
          'otp_verification': 'Verify Code',
          'otp_verification_number': 'Verification Code sent to ',
          'otp_verification_email': 'Verification Code sent to ',
          're_send_otp_code': 'Re-Send OTP Code? @time',
          'enter': 'Enter',
          'not_valid': 'Please enter the correct OTP Code',

          // Reset Password Screen
          'reset_password': 'Reset Password',
          'new_password_hint': 'New Password',
          'new_confirm_password_hint': 'Confirm New Password',
          'send_code': "Send Code",
          'verify_code': "Verify Code",

          // Fields Validations
          'field_required': 'This Field is Required',
          'min_8_length': '@field should be greater than 8',
          'numeric_only': '@field should be a only numeric',
          'field_email': '@field should be an email',
          'identical_passwords': 'Passwords should be identical!',

          // Home Screen
          'home': 'Home',
          'more': 'More',
          'settings': "Settings",
          'whatsapp_group_headline': 'Whatsapp Groups',
          'sections_headline': 'Sections',
          'doctors_headline': 'Doctors',
          'university_files': 'University Files',
          "next_class": "Next Class",
          "see_all": "See All",
          "chat_showcase": "Whatsapp groups , university files and courses",

          // Profile Screen
          'email_profile_label': 'Email',
          'phone_number_profile_label': 'Profile Number',
          'university_profile_label': 'University',
          'university_id_profile_label': 'University Id',
          'logout': 'SIGNOUT',
          "logout_title": "SIGNOUT",
          "logout_content": "Are you sure you want to sign out?",
          'delete': 'Delete User',
          'edit': 'Edit',
          'are_you_sure_delete_title': 'Are you Sure To Delete Your User?',
          'are_you_sure_delete_body':
              'Deleting your user, will make you loose all your information, and this action cannot be undo!',
          'are_you_sure_edit_title': 'Are you Sure To Edit Your User?',
          'are_you_sure_edit_body':
              'Editing your user, will make you loose all your old information, and this action cannot be undo!',
          'registered_course': 'Registered Courses',
          'no_registered_course': 'No Registered Courses',

          // Technical Support
          'subject_field': 'Subject',
          'body_field': 'How we can help you?',
          'msg_sent_successfully': "Message Sent Successfully",
          'submit_msg': 'Submit',
          "subscriptions": "Subscriptions",

          // Online Request
          'title_field': 'Title:',
          'material_field': 'Material',
          'select_material_text': 'Select Your Material',
          'request_type_field': 'Request Type:',
          'select_type_text': 'Select Request Type',
          'files_field': 'Insert Files:',
          'delivery_date_field': 'Enter Delivery Date:',
          'note_field': 'Note:',
          'student_note_field': 'Student Notes',
          'instructor_note_field': 'Instructor Notes',
          'student_attachments_field': 'Student Attachmentss',
          'instructor_attachments_field': 'Instructor Attachmentss',
          'submit_button': 'Submit Request',

          // Payemnt Method
          'payment_method': 'Payment Method',
          'pay_button_label': 'Pay',

          // Drawer Items
          'sections': 'Sections',
          'courses': 'Courses',
          'online_request': 'Online Request',
          'request_list': 'Request List',

          // Session Detail
          'days_label': 'Days',
          'time_label': "Time",
          'description': 'Description',
          "warning_content":
              "It's prohibited to share any of the course's data.",
          "warning_title": "Warning",
          'academic_plan': 'Academic Plan',
          'profile': 'Profile',
          'about_us': 'About Us',
          'terms_conditions': 'Terms And Conditions',
          'privacy_policy': 'Privacy Policy',
          'technical_support': 'Technical Support',
          'whatsapp': 'Whatsapp Groups',
          'switch_language': 'Switch Language',

          //settings screen
          'edit_profile': "Edit Profile",
          'delete_account': "Delete Account",
          "instructors": "Instructors",
          'delete_account_title': "Delete Account",
          'delete_account_content':
              "Are you sure you want to delete your account",
          "change_language": "Change Language",

          //notifications screen
          'notifications': "Notifications",
          "today": "Today",
          "yesterday": "Yesterday",
          "later": "Later",

          //schedule screen
          "schedule": "Schedule",
          "this_week": "This week",

          //favorites screem
          "favorites": "Favorites",

          //course details screen
          "lesson_lectures": "Lesson Lectures",
          "course_attachments": "Course Attachments",
          "course_information": "Course Information"
        },
        // Arabic Translations
        'ar': {
          'academic_student': "الطالب الأكاديمي",

          // Common Stuff
          'okay': 'حسنا',
          'cancel': ' إلغاء',
          'loading': 'تحميل',
          'arabic': 'العربية',
          'english': 'الانجليزية',
          "open": "افتح",
          'join': 'إنضم',
          'no_data_yet': "لا يوجد معلومات للآن!",
          "recorded_videos": "المحاضرات المسجلة",
          'course_summary': "الملخصات",
          'send': 'أرسل',
          'for_technical_support_label': 'للدعم الفني:',
          'try_with_email': 'إعادة الإرسال الى البريد الالكتروني',
          'try_with_phone': 'إعادة الإرسال الى رقم الهاتف',

          // Splash Screen Translations
          'copy_right': 'الطالب الأكاديمي © 2023 جميع الحقوق محفوظة',
          'main_website': 'www.academic-student.com',

          // Login Screen Translations
          'login_title': 'تسجيل الدخول',
          'login_button': 'تسجيل الدخول',
          'forget_password': 'نسيت رقم السري؟ إضغط هنا',
          'register_instead': 'مستخدم جديد؟ سجل هنا',
          'phone_number_hint': 'رقم الهاتف',
          'email_hint': 'البريد الالكتروني',
          'password_hint': 'الرقم السري',

          // Register Screen Translations
          'register_title': 'مستخدم جديد',
          'register_button': 'سجل الآن',
          'country_label': 'الدولة',
          'university_label': 'الجامعة',
          'first_name_label': 'الاسم الأول',
          'father_name_label': 'إسم الوالد',
          'last_name_label': 'الاسم الأخير',
          'phone_number_label': 'رقم الهاتف',
          'university_id_label': 'الرقم الجامعي',
          'email_label': 'البريد الالكتروني',
          'nationality_id_label': 'رقم الهوية',

          'register_password_label': 'الرقم السري الجديد',
          'register_confirm_password_label': 'إعادة الرقم السري',
          'login_instead': 'لديك حساب؟ سجل هنا!',
          'registration_complete': 'تم التسجيل بنجاح',

          // OTP Verification SCreen
          'otp_verification': 'التحقق من الرمز',
          'otp_verification_number': 'تم إرسال رمز التحقق للرقم ',
          'otp_verification_email': 'تم إرسال رمز التحقق للبريد ',
          're_send_otp_code': 'إعادة إرسال رمز التحقق؟ @time',
          'enter': 'إدخال',
          'not_valid': ' الرجاء ادخال الرقم الصحيح!',

          // Reset Password Screen
          'reset_password': 'اعادة تعيين كلمة المرور',
          'new_password_hint': 'كلمة المرور',
          'new_confirm_password_hint': 'تأكيد كلمة المرور',
          'send_code': "أرسل الرمز",
          'verify_code': "تحقق من الرمز",

          // Fields Validations
          'field_required': 'هذا الحقل مطلوب',
          'min_8_length': '@field يجب ان يكون اكثر من ثمان احرف',
          'numeric_only': '@field يجب ان يكون ارقام فقط',
          'field_email': '@field يجب ان يكون بريد الكتروني',
          'identical_passwords': 'يجب ان تتطابق كلمات المرور!',

          // Home Screen
          'home': 'الرئيسية',
          'more': 'المزيد',
          'whatsapp_group_headline': "مجموعات واتس اب",
          'sections_headline': 'الأقسام',
          'doctors_headline': 'الدكاترة',
          'university_files': 'ملفات الجامعة',
          "check_it": "Check it",
          "chat_showcase": "مجموعات واتساب، ملفات الجامعة والدورات",
          "subscriptions": "اشتراكات",

          // Profile Screen
          'email_profile_label': 'البريد الالكتروني',
          'phone_number_profile_label': 'رقم الهاتف',
          'university_profile_label': 'الجامعة',
          'university_id_profile_label': 'الرقم الجامعي',
          'logout': 'تسجيل الخروج',
          'delete': 'حذف المستخدم',
          'edit': 'تعديل',
          'are_you_sure_delete_title': 'هل أنت متأكد من حذف المستخدم؟',
          'are_you_sure_delete_body':
              'ستؤدي هذه العملية إلى حذف كل بيانانك، ولا يمكن إستعادتها',
          'are_you_sure_edit_title': 'هل أنت متأكد من تعديل المستخدم الخاص بك؟',
          'are_you_sure_edit_body':
              'تحرير المستخدم الخاص بك ، سيجعلك تفقد كل معلوماتك القديمة ، ولا يمكن التراجع عن هذا الإجراء!',
          'registered_course': 'المواد المسجل بها',
          'no_registered_course': 'لا يوجد مواد مسجل فيها',

          // Technical Support
          'subject_field': 'العنوان',
          'body_field': 'كيف نستطيع مساعدتك؟',
          'msg_sent_successfully': "لقد تم ارسال الرسالة بنجاح",
          'submit_msg': 'ارسال الرسالة',

          // Online Request
          'title_field': 'العنوان:',
          'material_field': 'المادة',
          'select_material_text': 'اختر المادة',
          'request_type_field': 'نوع الطلب:',
          'select_type_text': 'اختر نوع الطلب',
          'files_field': 'ادخل الملفات:',
          'delivery_date_field': 'ادخل الوقت المحدد:',
          'note_field': 'ملاحظات:',
          'submit_button': 'ارسال الطلب',

          // Payment Method
          'payment_method': 'بوابة الدفع',
          'pay_button_label': "ادفع",

          // Drawer Items
          'sections': 'الأقسام',
          'courses': 'الدورات',
          'online_request': 'طلب الكتروني',
          'request_list': 'الطلبات الالكترونية',

          // Session Detail
          'days_label': 'الأيام',
          'time_label': "الوقت",
          'description': 'الوصف',
          "warning_content":
              "يُمنع مشاركة أي من بيانات الدورة التدريبية او المادة",
          "warning_title": "تحذير",
          'academic_plan': 'خطة دراسية',
          'profile': 'الطالب',
          'about_us': 'عن مركز الطالب الأكاديمي',
          'terms_conditions': 'الشروط والأحكام',
          'privacy_policy': 'سياسة الخصوصية',
          'technical_support': 'الدعم الفني',
          'whatsapp': "مجموعات واتس اب",
          "instructors": "المعلمين",
          'switch_language': 'تغيير اللغة',

          //notifications screen
          'notifications': "الإشعارات",
          "today": "اليوم",
          "yesterday": "أمس",
          "later": "لاحقًا",

          //favorites screem
          "favorites": "المفضلة",

          "schedule": "الجدول",
          "this_week": "هذا الأسبوع",
          "lesson_lectures": "محاضرات الدرس",
          "course_attachments": "مرفقات الدورة",
          "course_information": "معلومات الدورة",
          "edit_profile": "تعديل الملف الشخصي",
          "delete_account": "حذف الحساب",
          "delete_account_title": "حذف الحساب",
          "delete_account_content": "هل أنت متأكد أنك تريد حذف الحساب؟",
          "change_language": "تغيير اللغة",
          "next_class": "الحصة القادمة",
          "see_all": "عرض الكل",
          "settings": "الإعدادات",
          "logout_title": "تسجيل الخروج",
          "logout_content": "هل أنت متأكد أنك تريد تسجيل الخروج؟"
        },
      };
}
