import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/utils/colors.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});
  static const routeName = "/privacy-policy";
  @override
  Widget build(BuildContext context) {
    var htmlData = r'''<h1>Cyber Society uchun maxfiylik siyosati</h1>

<p>Naseeb.uz saytidan foydalanish mumkin, bizning asosiy ustuvorliklarimizdan biri tashrif buyuruvchilarimizning shaxsiy daxlsizligidir. Ushbu Maxfiylik siyosati hujjatida Naseeb tomonidan to'plangan va yozib olingan ma'lumotlar turlari va ulardan qanday foydalanishimiz mavjud.</p>

<p>Agar sizda qoʻshimcha savollaringiz boʻlsa yoki Maxfiylik siyosatimiz haqida qoʻshimcha maʼlumotga muhtoj boʻlsangiz, biz bilan bogʻlanishdan tortinmang.</p>

<p>Ushbu Maxfiylik siyosati faqat bizning onlayn faoliyatimizga taalluqlidir va veb-saytimizga tashrif buyuruvchilar uchun ular Nasibda baham ko'rgan va/yoki to'plagan ma'lumotlarga nisbatan amal qiladi. Ushbu siyosat oflayn yoki ushbu veb-saytdan boshqa kanallar orqali to'plangan har qanday ma'lumotlarga taalluqli emas.</p>

<h2>Rozilik</h2>

<p>Veb-saytimizdan foydalanish orqali siz Maxfiylik siyosatimizga rozilik bildirasiz va uning shartlariga rozilik bildirasiz.</p>

<h2>Biz to'playdigan ma'lumotlar</h2>

<p>Sizdan taqdim etishingiz soʻralgan shaxsiy maʼlumotlar va uni taqdim etishingiz sabablari, biz sizdan shaxsiy maʼlumotlaringizni taqdim etishingizni soʻragan paytda sizga aniq boʻladi.</p>
<p>Agar biz bilan bevosita bog'lansangiz, biz siz haqingizda ismingiz, elektron pochta manzilingiz, telefon raqamingiz, bizga yuborishingiz mumkin bo'lgan xabar mazmuni va/yoki qo'shimchalar va siz taqdim etishni tanlashingiz mumkin bo'lgan boshqa ma'lumotlar kabi qo'shimcha ma'lumotlarni olishimiz mumkin. .</p>
<p>Hisob qaydnomasi uchun roʻyxatdan oʻtganingizda biz sizdan aloqa maʼlumotlarini, jumladan, ismingiz, kompaniya nomi, manzili, elektron pochta manzili va telefon raqami kabi maʼlumotlarni soʻrashimiz mumkin.</p>

<h2>Ma'lumotlaringizdan qanday foydalanamiz</h2>

<p>Biz to'plagan ma'lumotlardan turli yo'llar bilan foydalanamiz, jumladan:</p>

<ul>
<li>Veb-saytimizni taqdim eting, ishlating va qo'llab-quvvatlang</li>
<li>Veb-saytimizni yaxshilang, shaxsiylashtiring va kengaytiring</li>
<li>Saytimizdan qanday foydalanayotganingizni tushuning va tahlil qiling</li>
<li>Yangi mahsulotlar, xizmatlar, xususiyatlar va funksionallikni ishlab chiqish</li>
<li>Siz bilan toʻgʻridan-toʻgʻri yoki hamkorlarimizdan biri orqali, jumladan, mijozlarga xizmat koʻrsatish uchun veb-saytga oid yangilanishlar va boshqa maʼlumotlarni taqdim etish hamda marketing va reklama maqsadlarida muloqot qilish</li>
<li>Sizga elektron pochta xabarlarini yuborish</li>
<li>Firibgarlikni toping va oldini oling</li>
</ul>

<h2>Jurnal fayllari</h2>

<p>Naseeb jurnal fayllaridan foydalanishning standart protsedurasiga amal qiladi. Ushbu fayllar veb-saytlarga tashrif buyuruvchilarni qayd qiladi. Barcha hosting kompaniyalari buni va hosting xizmatlari tahlilining bir qismini amalga oshiradilar. Jurnal fayllari tomonidan to'plangan ma'lumotlarga internet protokoli (IP) manzillari, brauzer turi, Internet xizmat ko'rsatuvchi provayder (ISP), sana va vaqt tamg'asi, havola/chiqish sahifalari va, ehtimol, bosishlar soni kiradi. Bular shaxsni aniqlash mumkin bo'lgan har qanday ma'lumotlar bilan bog'liq emas. Ma'lumotdan maqsad tendentsiyalarni tahlil qilish, saytni boshqarish, veb-saytdagi foydalanuvchilar harakatini kuzatish va demografik ma'lumotlarni to'plashdan iborat.</p>




<h2>Reklama hamkorlari maxfiylik siyosati</h2>

<P>Naseeb kompaniyasining har bir reklama hamkori uchun Maxfiylik siyosatini topish uchun ushbu roʻyxatga murojaat qilishingiz mumkin.</p>

<p>Uchinchi tomon reklama serverlari yoki reklama tarmoqlari cookie fayllari, JavaScript yoki veb-mayoqlar kabi texnologiyalardan foydalanadi, ular oʻzlarining tegishli reklamalarida va Naseeb’da paydo boʻladigan havolalarda foydalaniladi va ular bevosita foydalanuvchilarning brauzeriga yuboriladi. Bu sodir bo'lganda ular avtomatik ravishda sizning IP manzilingizni oladi. Bu texnologiyalar reklama kampaniyalarining samaradorligini oʻlchash va/yoki siz tashrif buyurgan veb-saytlarda koʻradigan reklama kontentini moslashtirish uchun ishlatiladi.</p>

<p>Esda tutingki, Naseeb uchinchi tomon reklama beruvchilari tomonidan foydalaniladigan ushbu cookie-fayllarga kirish yoki ularni boshqarish huquqiga ega emas.</p>

<h2>Uchinchi tomon maxfiylik siyosati</h2>

<p>Naseeb maxfiylik siyosati boshqa reklama beruvchilar yoki veb-saytlarga taalluqli emas. Shunday qilib, batafsilroq ma'lumot olish uchun ushbu uchinchi tomon reklama serverlarining tegishli Maxfiylik siyosati bilan tanishib chiqishingizni maslahat beramiz. Bu ularning amaliyotlari va muayyan variantlardan qanday voz kechish bo'yicha ko'rsatmalarni o'z ichiga olishi mumkin. </p>

<p>Alohida brauzer opsiyalari orqali cookie-fayllarni oʻchirib qoʻyishni tanlashingiz mumkin. Muayyan veb-brauzerlar yordamida cookie-fayllarni boshqarish haqida batafsil ma'lumotni brauzerlarning tegishli veb-saytlarida topish mumkin.</p>

<h2>CCPA Maxfiylik huquqlari (Shaxsiy ma'lumotimni sotmang)</h2>

<p>CCPAga ko'ra, Kaliforniya iste'molchilari boshqa huquqlar qatorida:</p>
<p>Iste'molchining shaxsiy ma'lumotlarini to'playdigan biznesdan iste'molchilar haqida to'plagan shaxsiy ma'lumotlarning toifalari va alohida qismlarini oshkor qilishni so'rang.</p>
<p>Biznes to'plagan iste'molchi haqidagi shaxsiy ma'lumotlarni o'chirishni so'rang.</p>
<p>Iste'molchining shaxsiy ma'lumotlarini sotuvchi biznesdan iste'molchining shaxsiy ma'lumotlarini sotmasligini so'rang.</p>
<p>Agar so'rov yuborsangiz, sizga javob berish uchun bir oy vaqtimiz bor. Agar siz ushbu huquqlardan birini amalga oshirishni istasangiz, biz bilan bog'laning.</p>

<h2>GDPR ma'lumotlarini himoya qilish huquqlari</h2>

<p>Maʼlumotlaringizni himoya qilish boʻyicha barcha huquqlaringizdan toʻliq xabardor ekanligingizga ishonch hosil qilishni istaymiz. Har bir foydalanuvchi quyidagi huquqlarga ega:</p>
<p>Kirish huquqi - Siz shaxsiy ma'lumotlaringiz nusxalarini talab qilish huquqiga egasiz. Sizdan haq olishimiz mumkinbu xizmat uchun kichik toʻlov.</p>
<p> Tuzatish huquqi - Siz noto'g'ri deb hisoblagan har qanday ma'lumotni tuzatishimizni so'rash huquqiga egasiz. Shuningdek, siz toʻliq emas deb hisoblagan maʼlumotlarni toʻldirishimizni soʻrash huquqiga egasiz.</p>
<p>Oʻchirish huquqi – Siz maʼlum shartlar ostida shaxsiy maʼlumotlaringizni oʻchirib tashlashimizni soʻrash huquqiga egasiz.</p>
<p>Qayta ishlashni cheklash huquqi - Siz shaxsiy ma'lumotlaringizga ma'lum shartlar ostida ishlov berishni cheklashimizni so'rash huquqiga egasiz.</p>
<p>Qayta ishlashga e'tiroz bildirish huquqi - Siz ma'lum shartlar ostida shaxsiy ma'lumotlaringizni qayta ishlashimizga e'tiroz bildirish huquqiga egasiz.</p>
<p>Ma'lumotlarni ko'chirish huquqi - Siz biz to'plagan ma'lumotlarni boshqa tashkilotga yoki to'g'ridan-to'g'ri sizga ma'lum shartlar ostida o'tkazishimizni so'rash huquqiga egasiz.</p>
<p>Agar so'rov yuborsangiz, sizga javob berish uchun bir oy vaqtimiz bor. Agar siz ushbu huquqlardan birini amalga oshirishni istasangiz, biz bilan bog'laning.</p>

<h2>Bolalar haqida ma'lumot</h2>

<p>Bizning ustuvor vazifalarimizdan yana biri - internetdan foydalanishda bolalarni himoya qilish. Biz ota-onalar va vasiylarni ularning onlayn faoliyatini kuzatish, ishtirok etish va/yoki kuzatish va boshqarishga taklif qilamiz.</p>

<p>Naseeb 13 yoshga to'lmagan bolalardan ataylab hech qanday shaxsiy ma'lumot to'plamaydi. Agar farzandingiz veb-saytimizda bunday ma'lumotlarni taqdim etgan deb hisoblasangiz, biz bilan darhol bog'lanishingizni tavsiya qilamiz va biz qo'limizdan kelganicha harakat qilamiz. bunday ma'lumotlarni bizning yozuvlarimizdan tezda olib tashlash uchun.</p>

<h2>Ushbu Maxfiylik siyosatiga kiritilgan o'zgartirishlar</h2>

<p>Biz vaqti-vaqti bilan Maxfiylik siyosatimizni yangilashimiz mumkin. Shunday qilib, har qanday o'zgarishlar uchun vaqti-vaqti bilan ushbu sahifani ko'rib chiqishingizni maslahat beramiz. Ushbu sahifada yangi Maxfiylik siyosatini joylashtirish orqali har qanday o'zgarishlar haqida sizni xabardor qilamiz. Bu oʻzgarishlar ushbu sahifada eʼlon qilingandan soʻng darhol kuchga kiradi.</p>


<h2>Biz bilan bog'laning</h2>

<p>Maxfiylik siyosatimiz boʻyicha savollaringiz yoki takliflaringiz boʻlsa, biz bilan bogʻlanishdan tortinmang.</p>''';
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
              fontFamily: "sfPro", fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Html(
          data: htmlData,
          style: {
            'h2': Style(color: isDarkMode ? white : black, fontFamily: 'sfPro'),
            'p': Style(color: isDarkMode ? white : black, fontFamily: 'sfPro'),
            'ul': Style(color: isDarkMode ? white : black, fontFamily: 'sfPro'),
            'h1': Style(color: isDarkMode ? white : black, fontFamily: 'sfPro'),
            'li': Style(color: isDarkMode ? white : black, fontFamily: 'sfPro'),
          },
        ),
      ),
    );
  }
}
