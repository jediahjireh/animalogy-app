import 'package:flutter/material.dart';
import '../../core/constants/age_groups.dart';
import '../../core/constants/safety_themes.dart';
import '../../domain/models/story_pack.dart';
import '../../domain/models/story_page.dart';
import '../../domain/models/educator_guide.dart';
import '../../domain/models/discussion_prompt.dart';
import '../../domain/models/activity.dart';
import '../../domain/models/comprehension_question.dart';

final List<StoryPack> kaiaMeerkatPacks = [
  StoryPack(
    id: 'kaia_bird_danger',
    title: 'Kaia and the Bird Who Cried Danger',
    mascotId: 'kaia_meerkat',
    regionId: 'southern_africa',
    safetyTheme: SafetyTheme.onlineDeception,
    ageGroups: [
      AgeGroup.preschool,
      AgeGroup.earlyPrimary,
      AgeGroup.latePrimary,
    ],
    synopsis:
        'Kaia the meerkat trusts a clever drongo bird that fakes danger calls '
        'to steal food. Through this betrayal, Kaia learns that not everyone '
        'who sounds helpful is telling the truth \u2014 a lesson about recognising '
        'deception online and in everyday life.',
    pages: [
      StoryPage(
        pageNumber: 1,
        narration:
            'Kaia loved lunchtime more than anything. She and her friends '
            'would dig for beetles and grubs under the warm golden sun, '
            'chattering and laughing together.',
        visualDescription:
            'A group of meerkats foraging happily in sandy Kalahari terrain '
            'under a bright midday sun, with scattered tufts of dry grass '
            'and a clear blue sky overhead.',
        learningCue:
            'Ask the children what their favourite part of lunchtime is. '
            'Feeling safe and happy with friends is something we all enjoy.',
        sceneColor: Color(0xFFFFECB3),
      ),
      StoryPage(
        pageNumber: 2,
        narration:
            'One day, a sleek black bird swooped down from the sky. '
            '"Danger! Danger!" it cried in a sharp, urgent voice. '
            'The meerkats scattered into their burrows in a flash.',
        visualDescription:
            'A glossy fork-tailed drongo diving towards a group of startled '
            'meerkats who are mid-scatter, some already ducking into sandy '
            'burrow entrances, dust rising around them.',
        learningCue:
            'Talk about how the meerkats reacted without thinking. '
            'When someone shouts something scary, we often react before '
            'checking if it is true.',
        sceneColor: Color(0xFFFFE0B2),
      ),
      StoryPage(
        pageNumber: 3,
        narration:
            'The drongo bird visited every day after that, always watching '
            'over the meerkats. "It always looks out for us," Kaia told her '
            'mama proudly. The whole family trusted the helpful bird.',
        visualDescription:
            'The drongo perched on a low acacia branch near the meerkat '
            'colony, looking attentive while meerkats forage below. '
            'Kaia gazes up at the bird with admiration.',
        learningCue:
            'Discuss how trust builds over time. Someone who seems kind '
            'again and again can make us believe they will always be kind.',
        sceneColor: Color(0xFFC8E6C9),
      ),
      StoryPage(
        pageNumber: 4,
        narration:
            'Then one sunny lunchtime, just as the meerkats found the '
            'juiciest grubs, the drongo screeched, "Danger! Run!" '
            'Kaia and her friends raced underground without a second thought.',
        visualDescription:
            'Meerkats abandoning a pile of freshly dug beetles and grubs '
            'as they bolt toward their burrows. The drongo watches from '
            'above with its head tilted.',
        learningCue:
            'Ask if the children noticed anything different this time. '
            'Was there real danger, or did the bird have another reason '
            'to call out?',
        sceneColor: Color(0xFFFFF9C4),
      ),
      StoryPage(
        pageNumber: 5,
        narration:
            'When the meerkats crept back out, every last grub was gone. '
            'The drongo had tricked them and gobbled up their lunch. '
            'It had never been watching over them at all \u2014 it was hungry.',
        visualDescription:
            'Meerkats emerging cautiously from burrows to find empty ground '
            'where their food was. In the distance, the drongo flies away '
            'with something in its beak. Kaia stares at the bare sand.',
        learningCue:
            'Help children name the feeling of being tricked by someone '
            'they trusted. This is what deception feels like.',
        sceneColor: Color(0xFFFFCDD2),
      ),
      StoryPage(
        pageNumber: 6,
        narration:
            'Kaia felt a heavy sadness in her chest. Mama Meerkat nuzzled '
            'her gently and said, "Not everyone who seems nice is truly kind, '
            'little one. Some use kindness to get what they want."',
        visualDescription:
            'Mama Meerkat comforting a visibly sad young Kaia near the '
            'burrow entrance at golden hour. Warm light casts long shadows '
            'across the sandy ground.',
        learningCue:
            'This is a key moment to talk about online strangers who seem '
            'friendly but may have hidden motives, just like the drongo.',
        sceneColor: Color(0xFFBBDEFB),
      ),
      StoryPage(
        pageNumber: 7,
        narration:
            'Kaia decided she would learn to check for danger herself. '
            'The next time the drongo cried out, she peeked carefully first. '
            'No eagle. No jackal. She stayed and finished her lunch.',
        visualDescription:
            'Kaia standing upright on her hind legs, scanning the horizon '
            'with sharp eyes while other meerkats hesitate near burrow '
            'entrances. The drongo sits on a branch looking frustrated.',
        learningCue:
            'Celebrate how Kaia verified the information before reacting. '
            'We can do this online too \u2014 check before we click, share, '
            'or believe.',
        sceneColor: Color(0xFFB2DFDB),
      ),
      StoryPage(
        pageNumber: 8,
        narration:
            'From that day on, Kaia always looked twice and asked questions '
            'before believing a warning. Kind does not always mean safe. '
            'And that is a very clever thing to know.',
        visualDescription:
            'Kaia confidently leading her meerkat friends in foraging, '
            'standing tall with a watchful but calm expression. The sun '
            'is setting in warm amber tones across the Kalahari.',
        learningCue:
            'Wrap up by asking children what they will do differently when '
            'someone online tells them something surprising or scary.',
        sceneColor: Color(0xFFFFF8E1),
      ),
    ],
    educatorGuide: EducatorGuide(
      learningObjectives: [
        'Understand that people online may pretend to be helpful in order '
            'to deceive or take advantage of others.',
        'Recognise the pattern of building trust over time as a manipulation '
            'tactic used in phishing, catfishing, and social engineering.',
        'Develop the habit of verifying information before reacting, '
            'especially when a message creates urgency or fear.',
        'Build confidence to pause, question, and seek a trusted adult '
            'when something online feels wrong.',
      ],
      discussionPrompts: [
        DiscussionPrompt(
          question:
              'The drongo bird seemed really nice at first. Can you think of '
              'a time someone seemed nice but was not being honest?',
          guidanceNote:
              'For younger children, keep examples concrete and from daily '
              'life. Avoid leading them toward fearfulness; focus on the idea '
              'that checking is smart, not that everyone is bad.',
          targetAge: AgeGroup.preschool,
        ),
        DiscussionPrompt(
          question:
              'Why did Kaia and her friends believe the drongo so quickly '
              'every time it called danger?',
          guidanceNote:
              'Guide children to identify the pattern: the drongo built trust '
              'by being consistent before exploiting it. Relate this to how '
              'online scammers establish credibility before asking for '
              'something.',
          targetAge: AgeGroup.earlyPrimary,
        ),
        DiscussionPrompt(
          question:
              'What could the meerkats have done differently the very first '
              'time the drongo warned them?',
          guidanceNote:
              'Encourage critical thinking about verification. Could they have '
              'posted a lookout? Checked the sky themselves? Connect this to '
              'verifying links, messages, and requests online.',
          targetAge: AgeGroup.earlyPrimary,
        ),
        DiscussionPrompt(
          question:
              'How is the drongo bird like someone online who sends fake '
              'warnings or pretends to be your friend to get your personal '
              'information?',
          guidanceNote:
              'For older children, draw direct parallels to phishing emails, '
              'fake social media accounts, and clickbait that creates false '
              'urgency. Discuss how scammers use the same trust-building '
              'pattern as the drongo.',
          targetAge: AgeGroup.latePrimary,
        ),
      ],
      activities: [
        Activity(
          title: 'True or Tricky Sorting Game',
          description:
              'Prepare cards with simple statements \u2014 some true, some tricky '
              'or misleading. Children sort them into "True" and "Tricky" '
              'piles, then explain their reasoning. Reinforce that checking '
              'is always the smart choice.',
          materials: [
            'Printed or handwritten statement cards',
            'Two sorting baskets or labelled areas',
            'Stickers or stamps for correct sorts',
          ],
          durationMinutes: 15,
          targetAge: AgeGroup.preschool,
        ),
        Activity(
          title: 'The Trust Timeline',
          description:
              'Children draw a timeline of the drongo story showing when '
              'trust was built and when it was broken. They then create a '
              'second timeline for an online scenario (such as a stranger '
              'in a game chat) and mark where they would stop and check '
              'with a grown-up.',
          materials: [
            'Large paper or poster board',
            'Coloured markers or pencils',
            'Printed story summary for reference',
          ],
          durationMinutes: 25,
          targetAge: AgeGroup.earlyPrimary,
        ),
        Activity(
          title: 'Spot the Drongo: Phishing Detective',
          description:
              'Present age-appropriate examples of real and fake messages '
              '(simplified phishing emails, suspicious chat messages, '
              'clickbait headlines). Children work in pairs to identify '
              'red flags, explain the deception tactic, and propose a '
              'safe response for each one.',
          materials: [
            'Printed example messages (real and fake)',
            'Red flag checklist worksheet',
            'Pencils or pens',
            'Discussion answer key for the educator',
          ],
          durationMinutes: 30,
          targetAge: AgeGroup.latePrimary,
        ),
      ],
      culturalContext:
          'Meerkats are iconic cooperative mammals of the Kalahari Desert in '
          'Southern Africa, famous for their sentinel behaviour where one '
          'member stands guard while others forage. The fork-tailed drongo is '
          'a real bird found across sub-Saharan Africa that is scientifically '
          'documented to mimic the alarm calls of meerkats and other species '
          'to scare them away from food, which the drongo then steals. This '
          'remarkable example of interspecies deception in nature provides a '
          'powerful and culturally grounded analogy for teaching children '
          'about online deception and social engineering.',
      safetyTakeaway:
          'Just because someone seems helpful or friendly does not mean they '
          'are being honest. Online, people can pretend to be kind to trick '
          'you into sharing information, clicking links, or doing things that '
          'are not safe. Always pause, check the facts, and ask a trusted '
          'adult before believing something that feels urgent or too good '
          'to be true.',
    ),
    questions: [
      ComprehensionQuestion(
        id: 'kaia_q1',
        questionText: 'Why did the drongo bird make fake danger calls?',
        options: [
          'To warn the meerkats about real danger',
          'To steal food while the meerkats ran away',
          'To make friends with the meerkats',
          'To practise its singing voice',
        ],
        correctIndex: 1,
        explanation:
            'The drongo bird used fake danger calls as a trick to make '
            'the meerkats leave their food behind so it could steal it.',
        mascotEncouragement: 'Great thinking! You spotted the trick!',
      ),
      ComprehensionQuestion(
        id: 'kaia_q2',
        questionText:
            'What should you do if someone online sends you an urgent '
            'message that seems scary?',
        options: [
          'Do whatever they say immediately',
          'Share it with all your friends',
          'Stop, check the facts, and ask a trusted adult',
          'Ignore all messages forever',
        ],
        correctIndex: 2,
        explanation:
            'When something feels urgent or scary, the best thing to do '
            'is pause, check if it is real, and ask a trusted adult for help.',
        mascotEncouragement: 'You are learning to stay safe, just like Kaia!',
      ),
      ComprehensionQuestion(
        id: 'kaia_q3',
        questionText: 'What did Kaia learn by the end of the story?',
        options: [
          'All birds are dangerous',
          'Never eat food outside',
          'Not everyone who sounds helpful is telling the truth',
          'Meerkats should live alone',
        ],
        correctIndex: 2,
        explanation:
            'Kaia learned that just because someone sounds helpful or '
            'friendly, it does not mean they are being honest.',
        mascotEncouragement: 'Well done! That is an important safety lesson!',
      ),
    ],
  ),
];
