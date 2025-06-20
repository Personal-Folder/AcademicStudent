// String subDomain = "dev";
String subDomain = "www"; // For Production

String defaultApi(route, locale) => 'https://$subDomain.academic-student.com/api/v1/$route?locale=$locale';
String storageApi = 'https://$subDomain.academic-student.com/storage/';
String websiteUrl = 'https://$subDomain.academic-student.com/';
