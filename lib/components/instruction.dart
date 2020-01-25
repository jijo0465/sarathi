import 'dart:ui';
import 'package:flutter/material.dart';

class Instrunction extends StatelessWidget {
  final String language;
  final int category;
  const Instrunction({Key key, this.language, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            instructionTitle(
              category == 2
                  ? language == 'ml'
                      ? '8 ടെസ്റ്റ് ട്രാക്കിലെ നിബന്ധനകൾ'
                      :language == 'hi'?
                      '8 परीक्षण ट्रैक में शर्तें'
                      : 'Terms - 8 Test Track'
                  : language == 'ml'
                      ? 'H ട്രാക്കിലെ നിബന്ധനകൾ'
                      :language == 'hi'?
                      'H ट्रैक पर शर्तें'
                      : 'Terms - H Test Track',
            ),
            instructionCard(category == 2
                ? language == 'ml'
                    ? 'മോട്ടോർ സൈക്കിൾ എടുക്കുന്ന ആൾ വാഹനം സ്റ്റാർട്ട് ചെയ്ത്, ഹെൽമറ്റ് ധരിച്ച് ചിൻസ്ട്രാപ്പ് ഇട്ടതിനുശേഷം, കൺട്രോൾ റൂമിൽനിന്നുള്ള നിർദ്ദേശം കിട്ടിയാലുടൻ തന്നെ ടെസ്റ്റ് ആരംഭിക്കേണ്ടതാണ്.'
                    :language == 'hi'?
                      'मोटरसाइकिल स्टार्ट करने के बाद वाहन को हैलमेट पर रखें और चैंबर को लगाएं। कंट्रोल रूम से निर्देश मिलते ही परीक्षण शुरू कर दिया जाना चाहिए।'
                    : 'The motorcyclist starts the vehicle, wears the helmet and puts on the chinstrap. The test should be started immediately after receiving instruction from the control room.'
                : language == 'ml'
                    ? 'സ്റ്റാർട്ടിങ്ങ് പോയിന്റിൽ നിന്നും നിർദ്ദേശം ലഭിക്കുന്നതനുസരിച്ച്\n1. H ആകൃതിയിൽ ഉള്ളട്രാക്കിൽ, A യിൽ നിന്നും B യിലേക്ക് മുന്നോട്ടും \n2. B യിൽ നിന്ന് C യിലേയ്ക്ക് പിന്നോട്ടും \n3. C യിൽനിന്നും D യിലേയ്ക്ക് മുന്നോട്ടും \n4. D യിൽനിന്ന് A യിലേയ്ക്ക് പിന്നോട്ടും വാഹനം ഓടിക്കുക.'
                    :language == 'hi'?
                      'केवल निर्देश प्राप्त करें\n1. A से B तक आगे बढ़ना शुरू करें\n2. B से C की ओर पीछे\n3. आगे से C से D तक\n4. और "H" आकृति वाले ट्रैक पर D से A की ओर पीछे'
                    : 'Once gotten instruction:\n1. Start moving forward from A to B,\n2. Backwards towards B to C,\n3. Forwards from C to D.\n4. Backwards towards D to A on the track having “H” Shape.'),
            instructionCard(category == 2
                ? language == 'ml'
                    ? 'ട്രാക്കിലേയ്ക്ക് ഇടവിട്ടിട്ടുള്ള വെള്ള വര വഴി വലത്തോട്ട് പ്രവേശിച്ച് 8 ആകൃതിയിൽ വാഹനം ഓടിച്ച് ടെസ്റ്റ് മുഴുവിപ്പിക്കേണ്ടതാണ്.'
                    :language == 'hi'?
                      'आपको ट्रैक पर जाने वाली सफेद लाइन के चौराहे के आकार 8 में सही ड्राइविंग करके परीक्षण पूरा करना होगा'
                    : 'Form an 8-Shape using the vehicle after entering the right side of the line via intermittent white lines.'
                : language == 'ml'
                    ? 'ഒരു പോയിന്റിൽ നിന്നും മറ്റൊരു പോയിന്റിലേയ്ക്ക് പോകുമ്പോൾ വാഹനത്തിന്റെ വീലുകൾ നിശ്ചലമാകാൻ പാടുള്ളതല്ല. '
                    :language == 'hi'?
                      'एक बिंदु से दूसरे पर जाते समय वाहन के पहिए नहीं रुकने चाहिए।'
                    : 'The wheels of the vehicle must not stop while moving from a point to another.'),
            SizedBox(
              height: 8,
            ),
            instructionTitle(language == 'ml'
                ? 'പരാജയപ്പെടാവുന്ന സാഹചര്യങ്ങൾ'
                :language == 'hi'?
                      'असफल स्थितियों'
                : 'Failing situations'),
            instructionCard(category == 2
                ? language == 'ml'
                    ? 'മോട്ടോർ സൈക്കിളിലെ ടെസ്റ്റിൽ ട്രാക്കിനുള്ളിൽ കാലുകുത്തുന്നതും വാഹനം നിന്ന് പോകുന്നതും, വാഹനത്തിന്റെയോ വസ്ത്രത്തിന്റെയോ, ശരീരത്തിന്റെയോ ഭാഗങ്ങൾ ട്രാക്കിന്റെ വെള്ളവര മറികടക്കുന്നത്.'
                    :language == 'hi'?
                      'मोटरसाइकिल परीक्षण में, वाहन का पैर वाहन की सफेद रेखा को पार करता है, जिससे वाहन और वाहन वाहन को छोड़ दिया जाता है'
                    : 'Placing feet on the ground, vehicles getting stuck in the track or the parts of vehicle, clothing and body crossing the white line in the event of test of a motorcycle.'
                : language == 'ml' ? 'ഒരു വാഹനം H ട്രാക്കിന്റെ നാല് അറ്റങ്ങളിലും എത്താത്ത സാഹചര്യത്തിൽ.' 
                :language == 'hi'?
                      'इस घटना में कि वाहन "एच" के सभी 4 कोनों तक नहीं पहुंचता है'
                : 'In the event that the  vehicle does not reach all the 4 corners of the “H”.'),
            instructionCard(
              category == 2?
              language == 'ml'
                ? 'ഓട്ടോറിക്ഷ ട്രാക്കിൽ നിന്നുപോകുന്നത്, വെള്ള വര മറികടക്കുന്നത്.'
                :language == 'hi'?
                'ऑटो रिक्शा ट्रैक से बाहर निकलकर या सफेद लाइन को पार करते हुए'
                : 'Autorikshaw exiting the track or crossing the white line.'
                : language == 'ml' ? 'ഒരു പോയിന്റിൽ നിന്നും മറ്റൊരു പോയിന്റിലേയ്ക്കുള്ള വാഹന യാത്രയ്ക്കിടയിൽ വീലുകൾ നിശ്ചലമായാൽ.' 
                :language == 'hi'?
                'वाहन के एक बिंदु से दूसरे बिंदु तक यात्रा के दौरान पहिया रुक जाता है'
                : 'The wheel stops during the journey of the vehicle from one point to other.'),
            category != 2?instructionCard(
              language == 'ml'?'A,B,C,D എന്നീ പോയിന്റുകൾ ഒഴിച്ച് ട്രാക്കിലെ വെള്ള വര വീലുകളൊ വാഹനത്തിന്റെ ഭാഗങ്ങളൊ മറി കടന്നാൽ.'
              :language == 'hi'?
              'यदि बिंदु A, B, C & D को छोड़कर या तो पहियों या वाहन के किसी भी शरीर के अंग सफेद रेखा को पार करते हैं'
              :'If either the wheels or any body parts of the vehicle crosses the white line except for the point A, B, C & D.'
            ):Container(),
            category != 2?instructionCard(
              language == 'ml'?'A,B,C,D എന്നീ പോയിന്റുകൾ ഒഴിച്ച് ട്രാക്കിൽ വാഹനത്തിന്റെ ദിശ മാറ്റിയാൽ.'
              :language == 'hi'?
              'यदि आप A, B, C और D को छोड़कर ट्रैक पर वाहन की दिशा बदलते हैं'
              :'Change in direction of the vehicle except for the point A, B, C & D.'
            ):Container(),
            // Container(
            //     // padding: EdgeInsets.only(bottom: 57),
            //     // alignment: Alignment.bottomCenter,
            //     child: Text(
            //       'Swipe right to go back to animation',
            //       style: TextStyle(color: Colors.black54, fontSize: 12),
            //     ))
            SizedBox(
              height: 56,
            )
          ],
        ),
      ),
    );
  }

  Widget instructionCard(String text) {
    return Container(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    topLeft: Radius.circular(12))),
            elevation: 0,
            color: Colors.white.withOpacity(0.25),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                text,
                style:
                    TextStyle(fontSize: 16, letterSpacing: 0.3, wordSpacing: 2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget instructionTitle(String text) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(text,
          style: TextStyle(
            fontSize: 18, letterSpacing: 0.3, wordSpacing: 2,fontWeight: FontWeight.w600)),
    );
  }
}
