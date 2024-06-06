import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SafetyMeasures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 129, 199, 220),
        title: Text(
          "safety Measures".tr,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double fem = MediaQuery.of(context).size.width / 430;

          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 129, 199, 220),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x26000000),
                    offset: Offset(0, 0),
                    blurRadius: 37.5 * fem,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        EdgeInsets.fromLTRB(0, 45.91 * fem, 0, 105.29 * fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              81 * fem, 0, 90 * fem, 5 * fem),
                          width: double.infinity,
                          height: 150 * fem,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 77 * fem,
                                top: 2 * fem,
                                child: Align(
                                  child: SizedBox(
                                    width: 97 * fem,
                                    height: 109 * fem,
                                    child: Image.asset(
                                      'assets/images/women-1.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 472 * fem,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SafetyButton(
                                  title: 'safety at Work'.tr,
                                  dialogTitle: 'safety at Work'.tr,
                                  dialogContent: 'precautionary Measures for Safety at Work:\n'
                                          '1. training and Education: Regular training sessions to educate employees on safety protocols, procedures, and proper equipment handling.\n'
                                          '2. risk Assessment: Conducting thorough risk assessments to identify potential hazards in the workplace and taking proactive steps to mitigate them.\n'
                                          '3. personal Protective Equipment (PPE): Ensuring the availability and proper use of PPE such as helmets, gloves, goggles, and masks to minimize the risk of injury or exposure to harmful substances.\n'
                                          '4. emergency Preparedness: Developing and practicing emergency response plans, including evacuation procedures and first aid training, to effectively respond to any unforeseen accidents or incidents.\n'
                                          '5. equipment Maintenance: Regular maintenance and inspection of machinery and equipment to ensure they are in safe working condition, reducing the likelihood of accidents due to equipment malfunction.\n'
                                          '6. safety Signage: Clearly marking hazardous areas, providing safety signs and labels, and ensuring proper lighting to enhance visibility and awareness of potential risks.\n'
                                          '7. workplace Ergonomics: Implementing ergonomic principles to design workspaces and tasks in a way that reduces strain and injury, promoting employee comfort and wellbeing.\n\n'
                                          'safety Measures at Work:\n'
                                          'in maintaining safety at the workplace, a combination of precautionary measures and ongoing safety protocols is imperative. Firstly, comprehensive training and education programs should be implemented to familiarize employees with safety procedures, equipment usage, and hazard recognition. Regular risk assessments should be conducted to identify potential dangers, and appropriate measures should be taken to address them promptly. Personal Protective Equipment (PPE) should be readily available and used correctly by all personnel to minimize exposure to risks.\n'
                                          'furthermore, emergency preparedness is vital. Establishing clear emergency response plans and conducting regular drills ensures that employees know how to react swiftly and effectively in case of accidents or emergencies. Additionally, regular maintenance and inspection of equipment not only prolong their lifespan but also reduce the likelihood of malfunctions that could lead to accidents.\n'
                                          'the workplace environment should be designed with safety in mind, including proper lighting, clear signage indicating hazardous areas, and ergonomic considerations to minimize physical strain. By prioritizing safety through these measures, employers can create a secure and conducive work environment where employees can perform their duties confidently and without unnecessary risk to their health and wellbeing.'
                                      .tr),
                              SafetyButton(
                                title: 'safety at Home'.tr,
                                dialogTitle: 'safety at Home'.tr,
                                dialogContent: 'install smoke detectors in key areas of your home and check them regularly to ensure they\'re working properly.\n'
                                        'Keep emergency numbers, such as those for the fire department, police, and poison control, readily accessible.\n'
                                        'Store hazardous materials, such as cleaning products and medicines, out of reach of children and pets, preferably in locked cabinets.\n'
                                        'Regularly inspect electrical cords and outlets for signs of wear or damage, and replace them if necessary.\n'
                                        'Use safety gates at the top and bottom of stairs to prevent falls, especially for households with young children or elderly individuals.\n'
                                        'Secure heavy furniture and appliances to the wall to prevent them from tipping over, especially in earthquake-prone areas.\n'
                                        'Keep a first aid kit stocked and easily accessible in case of minor injuries or emergencies.\n'
                                        'Practice fire escape drills with your family, establishing multiple exit routes and a designated meeting place outside.\n'
                                        'Ensure that your home has proper lighting both indoors and outdoors to reduce the risk of slips, trips, and falls.'
                                    .tr,
                              ),
                              SafetyButton(
                                  title: 'safety at University'.tr,
                                  dialogTitle: 'safety at University'.tr,
                                  dialogContent: 'precautionary Measures:\n'
                                          '1. always lock your dorm or apartment doors when you leave.\n'
                                          '2. Don\'t leave your belongings unattended in public areas.\n'
                                          '3. Be cautious when walking alone, especially at night.\n'
                                          '4. Avoid poorly lit or deserted areas on campus.\n'
                                          '5. Be mindful of your surroundings and trust your instincts if something feels off.\n'
                                          '6. Don\'t share personal information or keys with strangers.\n'
                                          '7. Familiarize yourself with emergency procedures and exits in buildings.\n\n'
                                          'safety Measures:\n'
                                          'In ensuring safety at university, it\'s crucial to adhere to precautionary measures such as always locking doors, avoiding isolated areas, and being cautious when walking alone, especially at night. Additionally, utilizing campus resources like security escorts or shuttle services can provide added safety when traveling late at night. Installing security measures such as peepholes or cameras in your living space and keeping emergency contact numbers handy are proactive steps towards ensuring personal safety. Building a support network by getting to know neighbors and staying informed about campus safety policies can further contribute to a secure environment. Lastly, being vigilant and reporting any suspicious activity promptly to campus security helps maintain a safe community for all students and staff.\n'
                                      .tr),
                              SafetyButton(
                                title: 'women Safety Online'.tr,
                                dialogTitle: 'women Safety Online'.tr,
                                dialogContent: 'precautionary Measures:\n'
                                        '1. privacy Settings: Regularly review and adjust privacy settings on social media and other online platforms to control who can see your information.\n'
                                        '2. Be Cautious with Personal Information: Avoid sharing sensitive personal information such as your address, phone number, or financial details online.\n'
                                        '3. Strong Passwords: Use strong, unique passwords for each online account and consider using a password manager to keep track of them.\n'
                                        '4. Beware of Phishing: Be cautious of suspicious emails, messages, or links, and never provide personal information in response to unsolicited requests.\n'
                                        '5. Secure Wi-Fi: Use secure Wi-Fi connections, especially when accessing sensitive information or making online transactions.\n'
                                        '6. Stay Informed: Keep yourself updated on common online threats and scams to recognize and avoid them.\n\n'
                                        'safety Measures:\n'
                                        'in today\'s digital age, ensuring women\'s safety online requires a proactive approach. Precautionary measures such as regularly reviewing and adjusting privacy settings, being cautious with personal information, and using strong passwords are crucial steps in protecting oneself from online threats. Additionally, staying informed about common online scams and phishing attempts can help women recognize and avoid potential dangers. Safety measures include trusting one\'s instincts, reporting instances of harassment or abuse, and utilizing blocking and filtering tools on social media platforms. Building a support network of friends, family, and online communities can provide assistance and guidance in navigating online threats. It\'s also essential to educate others about online safety practices and seek help from law enforcement or legal professionals if faced with serious online threats. By implementing these measures and staying vigilant, women can enhance their safety and security in the online world.'
                                    .tr,
                              ),
                              SafetyButton(
                                title: 'safety on the Streets'.tr,
                                dialogTitle: 'safety on the Streets'.tr,
                                dialogContent: 'precautionary Measures:\n'
                                        '1. always stay aware of your surroundings.\n'
                                        '2. Use well-lit and populated routes, especially at night.\n'
                                        '3. Avoid isolated or poorly lit areas.\n'
                                        '4. Walk confidently and with purpose.\n'
                                        '5. Keep valuable belongings out of sight.\n'
                                        '6. Trust your instincts and avoid potentially risky situations.\n\n'
                                        'safety Measures:\n'
                                        'Ensuring safety on the streets involves a combination of precautionary and proactive measures. It\'s essential to always stay aware of your surroundings, choosing well-lit and populated routes, especially at night, while avoiding isolated or poorly lit areas. Walking confidently and purposefully can deter potential threats. Additionally, keeping valuable belongings out of sight and trusting your instincts are crucial. Safety measures such as wearing bright or reflective clothing, carrying a personal alarm or whistle, and having emergency contacts readily available can enhance personal security. When sidewalks are unavailable, walking facing traffic can improve visibility and safety. It\'s important to remain sober and avoid distractions like texting while walking. When feasible, utilizing public transportation or trusted rideshare services can provide added security. By incorporating these precautionary and safety measures, individuals can help ensure their safety while navigating the streets.'
                                    .tr,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SafetyButton extends StatelessWidget {
  final String title;
  final String dialogTitle;
  final String dialogContent;

  const SafetyButton({
    Key? key,
    required this.title,
    required this.dialogTitle,
    required this.dialogContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double buttonWidth = constraints.maxWidth * 0.8;
        double buttonHeight = 65;
        double fontSize = constraints.maxWidth * 0.05;

        return Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 7.0),
            child: SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(dialogTitle.tr),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: dialogContent
                                .split('\n')
                                .map((text) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Text(text.tr),
                                    ))
                                .toList(),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('close'.tr),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 28, 41, 72),
                ),
                child: Text(
                  title.tr,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
