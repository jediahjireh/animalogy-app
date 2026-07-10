import 'package:flutter/material.dart';
import '../../core/constants/age_groups.dart';
import '../../core/constants/safety_themes.dart';
import '../../domain/models/story_pack.dart';
import '../../domain/models/story_page.dart';
import '../../domain/models/educator_guide.dart';
import '../../domain/models/discussion_prompt.dart';
import '../../domain/models/activity.dart';
import '../../domain/models/comprehension_question.dart';

final List<StoryPack> taraTurtlePacks = [
  StoryPack(
    id: 'tara_crocodile_compliment',
    title: "Tara and the Crocodile's Compliment",
    mascotId: 'tara_turtle',
    regionId: 'india',
    safetyTheme: SafetyTheme.flatteryManipulation,
    ageGroups: [
      AgeGroup.preschool,
      AgeGroup.earlyPrimary,
      AgeGroup.latePrimary,
    ],
    synopsis:
        'A river crocodile uses flattery and offers of help to lure Tara, '
        'a young star tortoise, into danger. Tara must learn to look past '
        'sweet words and recognise when kindness is being used as bait.',
    pages: [
      StoryPage(
        pageNumber: 1,
        narration:
            'Tara the star tortoise lived happily near a jungle river in '
            'India. She was slow, but she never minded. The warm rocks and '
            'shady trees were all she needed.',
        visualDescription:
            'A small star tortoise with a golden-brown patterned shell '
            'resting on a sunny rock beside a lush green jungle river. '
            'Tropical trees and ferns line the banks.',
        learningCue:
            'Ask the children what they notice about Tara and where she '
            'lives. What makes her feel safe and happy?',
        sceneColor: Colors.green.shade100,
        imageUrl: 'https://openclipart.org/image/800px/355182',
      ),
      StoryPage(
        pageNumber: 2,
        narration:
            'One morning, a crocodile surfaced from the water with a wide '
            'grin. "What a beautiful shell you have!" he said. "You must '
            'be very special to have markings like those."',
        visualDescription:
            'A large crocodile with its head just above the water surface, '
            'smiling broadly at Tara on the riverbank. The crocodile looks '
            'friendly but its teeth are visible.',
        learningCue:
            'Pause and ask: how does the crocodile make Tara feel with '
            'his words? Is he being kind or is something else going on?',
        sceneColor: Colors.teal.shade100,
        imageUrl: 'https://openclipart.org/image/800px/355569',
      ),
      StoryPage(
        pageNumber: 3,
        narration:
            'The crocodile paddled closer. "I know where the sweetest '
            'mangoes grow, just across the river. Climb on my back and '
            'I will carry you there safely."',
        visualDescription:
            'The crocodile floating near the riverbank with its back flat '
            'and inviting. Across the wide river, a distant tree heavy '
            'with bright orange mangoes is visible.',
        learningCue:
            'Discuss why the crocodile is offering to help. What would '
            'happen if Tara climbed onto a crocodile in the water?',
        sceneColor: Colors.blue.shade100,
        imageUrl: 'https://openclipart.org/image/800px/355721',
      ),
      StoryPage(
        pageNumber: 4,
        narration:
            'Tara felt a warm glow inside. No one had ever called her '
            'special before. She looked at the crocodile and took a small '
            'step forward, thinking about those mangoes.',
        visualDescription:
            'Close-up of Tara looking thoughtful and tempted, one foot '
            'lifted as if about to step toward the water. A soft golden '
            'glow surrounds her, showing her flattered feelings.',
        learningCue:
            'Explore why flattery feels so good. Ask: has anyone ever '
            'said something nice to you that made you want to do what '
            'they asked?',
        sceneColor: Colors.amber.shade100,
        imageUrl: 'https://openclipart.org/image/800px/355182',
      ),
      StoryPage(
        pageNumber: 5,
        narration:
            'Suddenly, a wise old crane called out from a tall tree. '
            '"Tara, stop! Look at his teeth, not his words! A true '
            'friend does not need to flatter you into danger."',
        visualDescription:
            'A tall grey crane perched on a high branch, wings spread '
            'in warning. The crane looks down at Tara with a firm but '
            'caring expression. Tara freezes mid-step.',
        learningCue:
            'Talk about the crane as a trusted adult. Who in the '
            "children's lives would warn them like the crane warned Tara?",
        sceneColor: Colors.orange.shade100,
        imageUrl: 'https://openclipart.org/image/800px/355909',
      ),
      StoryPage(
        pageNumber: 6,
        narration:
            'Tara pulled her foot back just in time. The crocodile '
            'lunged forward with a mighty snap, his jaws crashing shut '
            'right where Tara had been standing. His true plan was clear.',
        visualDescription:
            'The crocodile lunging out of the water with jaws wide open, '
            'teeth gleaming. Tara is safely pulled back on the bank, '
            'her eyes wide with shock. Water splashes dramatically.',
        learningCue:
            'Ask how Tara feels now. What would have happened if the '
            'crane had not spoken up? Why did the crocodile pretend to '
            'be nice?',
        sceneColor: Colors.red.shade100,
        imageUrl: 'https://openclipart.org/image/800px/355182',
      ),
      StoryPage(
        pageNumber: 7,
        narration:
            'Tara thanked the crane with all her heart. "I almost '
            'fell for his trick," she said quietly. The crane nodded. '
            '"Words can be bait, little one, not just kindness."',
        visualDescription:
            'Tara and the crane together on the safe riverbank. The '
            'crane has one wing gently resting near Tara. The crocodile '
            'is a distant shape slipping back under the water.',
        learningCue:
            'Discuss what "words can be bait" means. Help children '
            'understand that compliments can sometimes be used to trick '
            'people.',
        sceneColor: Colors.purple.shade100,
        imageUrl: 'https://openclipart.org/image/800px/355622',
      ),
      StoryPage(
        pageNumber: 8,
        narration:
            'From that day on, Tara remembered the crane\'s lesson. '
            'Sweet words can hide sharp teeth. Listen with your head, '
            'not just your heart, and always look at what people do, '
            'not only what they say.',
        visualDescription:
            'Tara walking confidently along the riverbank in warm '
            'morning light. She looks content and wise. The jungle '
            'stretches peacefully behind her with golden sunlight '
            'filtering through the canopy.',
        learningCue:
            'Reinforce the takeaway message. Ask children to repeat '
            'the lesson in their own words and think of a time when '
            'actions did not match words.',
        sceneColor: Colors.amber.shade50,
        imageUrl: 'https://openclipart.org/image/800px/355182',
      ),
    ],
    educatorGuide: EducatorGuide(
      learningObjectives: [
        'Recognise that flattery can be used as a tool for manipulation, '
            'not just as genuine kindness.',
        'Understand the difference between a sincere compliment and one '
            'designed to gain trust or compliance.',
        'Identify grooming patterns where an adult or peer uses excessive '
            'praise and offers to isolate or lure a child.',
        'Build the habit of checking actions against words before trusting '
            'someone new.',
      ],
      discussionPrompts: [
        DiscussionPrompt(
          question:
              'The crocodile said Tara had a beautiful shell. Was he '
              'being nice or was he trying to trick her?',
          guidanceNote:
              'For younger children, keep it simple: sometimes people '
              'say nice things because they want something, not because '
              'they mean it. Use the crocodile as a concrete example '
              'without making children fearful of all compliments.',
          targetAge: AgeGroup.preschool,
        ),
        DiscussionPrompt(
          question:
              'Why did the flattery work so well on Tara? What made '
              'her want to believe the crocodile?',
          guidanceNote:
              'Guide children to understand that flattery works best '
              'when someone feels unseen or unappreciated. Tara had '
              'never been called special before, which made her '
              'vulnerable to the crocodile\'s words.',
          targetAge: AgeGroup.earlyPrimary,
        ),
        DiscussionPrompt(
          question:
              'How can you tell the difference between a real '
              'compliment and one that someone is using to get '
              'something from you?',
          guidanceNote:
              'Encourage children to think about context and patterns. '
              'A real compliment expects nothing in return. If someone '
              'compliments you and then immediately asks for something '
              'or wants you to go somewhere, that is a warning sign.',
          targetAge: AgeGroup.latePrimary,
        ),
        DiscussionPrompt(
          question:
              'The crane told Tara to look at the crocodile\'s teeth, '
              'not his words. What does that mean for us in real life?',
          guidanceNote:
              'Help children translate the metaphor: "teeth" represent '
              'actions and true intentions, "words" represent what '
              'someone says. We should judge people by what they do '
              'over time, not just by what they say in the moment.',
          targetAge: AgeGroup.earlyPrimary,
        ),
      ],
      activities: [
        Activity(
          title: 'Kind Words Sorting Game',
          description:
              'Create cards with different compliment scenarios. Children '
              'sort them into two piles: "real kindness" where the person '
              'expects nothing back, and "tricky words" where the person '
              'wants something. Use simple examples like sharing a toy '
              'versus saying "you are my best friend" only when they want '
              'a turn on the swing.',
          materials: [
            'Printed scenario cards',
            'Two sorting baskets or labelled areas',
            'Stickers for correct sorts',
          ],
          durationMinutes: 15,
          targetAge: AgeGroup.preschool,
        ),
        Activity(
          title: 'Flattery Detective Role-Play',
          description:
              'In pairs, one child plays the "flatterer" and the other '
              'plays the "detective." The flatterer tries to convince the '
              'detective to do something using only compliments. The '
              'detective practises saying "That is nice of you to say, '
              'but I need to think about it first." Swap roles and '
              'discuss how it felt on each side.',
          materials: [
            'Role-play prompt cards with scenarios',
            'A detective badge or hat for fun',
          ],
          durationMinutes: 20,
          targetAge: AgeGroup.earlyPrimary,
        ),
        Activity(
          title: 'Manipulation Pattern Journal',
          description:
              'Children identify and write about three real-world '
              'scenarios where flattery or excessive niceness could be '
              'used to manipulate someone. For each scenario, they write '
              'what the manipulator says, what they actually want, and '
              'what warning signs to look for. Discuss as a group how '
              'these patterns appear online and in person.',
          materials: [
            'Lined journal or worksheet',
            'Pens or pencils',
            'Example scenario handout for reference',
          ],
          durationMinutes: 25,
          targetAge: AgeGroup.latePrimary,
        ),
      ],
      culturalContext:
          'This story draws on the Panchatantra tradition of Indian animal '
          'fables, where animals embody human virtues and flaws to teach '
          'moral lessons. The crocodile-and-tortoise pairing echoes classic '
          'tales from this tradition, where river creatures represent hidden '
          'danger beneath a calm surface. Star tortoises are native to India '
          'and are beloved for their distinctive shell patterns, making Tara '
          'a culturally grounded character that Indian children can connect '
          'with.',
      safetyTakeaway:
          'Sweet words can hide sharp teeth. When someone uses flattery to '
          'get you to do something, pause and think. A real friend does not '
          'need to trick you with compliments. Always look at what people '
          'do, not just what they say, and talk to a trusted adult if '
          "someone's kindness feels like it comes with strings attached.",
    ),
    questions: [
      ComprehensionQuestion(
        id: 'tara_q1',
        questionText: 'How did the crocodile try to lure Tara closer?',
        options: [
          'By chasing her through the jungle',
          'By using flattery and offers of help',
          'By giving her real gifts',
          'By singing a pretty song',
        ],
        correctIndex: 1,
        explanation:
            'The crocodile used sweet words and compliments to make Tara '
            'feel special, hoping she would trust it and come closer.',
        mascotEncouragement: 'Well spotted! You can see through flattery!',
      ),
      ComprehensionQuestion(
        id: 'tara_q2',
        questionText:
            'How can you tell if someone is using flattery to manipulate you?',
        options: [
          'They give you lots of compliments for no reason',
          'They are always honest with you',
          'They never talk to you',
          'They ask your parents first',
        ],
        correctIndex: 0,
        explanation:
            'When someone gives you lots of compliments or praise to get '
            'you to do something, they might be using flattery as a trick.',
        mascotEncouragement:
            'Excellent! Look at what people do, not just what they say!',
      ),
      ComprehensionQuestion(
        id: 'tara_q3',
        questionText:
            'What is the safest thing to do if a stranger is overly kind?',
        options: [
          'Go with them because they are nice',
          'Give them what they want',
          'Talk to a trusted adult about it',
          'Pretend you did not hear them',
        ],
        correctIndex: 2,
        explanation:
            'If someone you do not know well is being unusually kind or '
            'offering things, the safest choice is to talk to a trusted adult.',
        mascotEncouragement:
            'That is exactly right! Trusted adults can help you stay safe!',
      ),
    ],
  ),
];
