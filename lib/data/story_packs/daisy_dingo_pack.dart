import 'package:flutter/material.dart';
import '../../core/constants/age_groups.dart';
import '../../core/constants/safety_themes.dart';
import '../../domain/models/story_pack.dart';
import '../../domain/models/story_page.dart';
import '../../domain/models/educator_guide.dart';
import '../../domain/models/discussion_prompt.dart';
import '../../domain/models/activity.dart';
import '../../domain/models/comprehension_question.dart';

final List<StoryPack> daisyDingoPacks = [
  StoryPack(
    id: 'daisy_laughing_trickster',
    title: 'Daisy and the Laughing Trickster',
    mascotId: 'daisy_dingo',
    regionId: 'australia',
    safetyTheme: SafetyTheme.falseAlarms,
    ageGroups: AgeGroup.values.toList(),
    synopsis:
        'Deep in the Australian outback, a clever kookaburra uses its loud '
        'laughter-like call to trick Daisy\'s dingo pack into abandoning their '
        'food. Daisy must learn to tell the difference between a real warning '
        'and a false alarm.',
    pages: [
      StoryPage(
        pageNumber: 1,
        narration:
            'Daisy the dingo pup loved exploring the red-dirt trails of the '
            'outback with her pack. Every morning they trotted together past '
            'spinifex grass and termite mounds, sniffing for breakfast.',
        visualDescription:
            'A golden dingo pup leading a small pack across a vast, sunlit '
            'Australian outback landscape with red earth, scattered spinifex '
            'grass tufts, and tall termite mounds under a wide orange sky.',
        learningCue:
            'Ask the children what they notice about Daisy\'s pack travelling '
            'together. Why might animals stick close to their family group?',
        sceneColor: Colors.orange.shade100,
        imageUrl: 'https://openclipart.org/image/800px/355582',
      ),
      StoryPage(
        pageNumber: 2,
        narration:
            'One afternoon, a kookaburra\'s loud laugh echoed through the bush. '
            '"Eagle overhead!" the pack leader barked, and everyone ducked into '
            'the scrub. The kookaburra had warned them just in time.',
        visualDescription:
            'A kookaburra perched on a dead gum tree branch, beak open in a '
            'loud call, while dingoes below scatter into brown scrubland. A '
            'large eagle silhouette circles in the sky above.',
        learningCue:
            'Discuss how animals use sounds to warn each other. Have the '
            'children ever heard a bird call that sounded like laughter?',
        sceneColor: Colors.brown.shade100,
        imageUrl: 'https://openclipart.org/image/800px/321966',
      ),
      StoryPage(
        pageNumber: 3,
        narration:
            'After that day, the pack trusted the kookaburra completely. '
            'Whenever its rattling laugh rang out, they knew to hide. The bird '
            'became their most reliable lookout in the treetops.',
        visualDescription:
            'A lush eucalyptus canopy with the kookaburra perched alertly on a '
            'high branch, scanning the sky. Below, the dingo pack rests '
            'peacefully in dappled green shade, feeling safe.',
        learningCue:
            'Talk about trust. What makes someone a trusted lookout or helper? '
            'How did the kookaburra earn the pack\'s trust?',
        sceneColor: Colors.green.shade100,
        imageUrl: 'https://openclipart.org/image/800px/354992',
      ),
      StoryPage(
        pageNumber: 4,
        narration:
            'One bright morning, Daisy stood guard over a juicy lizard the pack '
            'had caught. Suddenly the kookaburra let out its loudest laugh yet. '
            '"Danger! Run!" yelped the older dingoes.',
        visualDescription:
            'A sunny clearing with Daisy standing protectively over a large '
            'lizard on a flat rock. The kookaburra is mid-call on a nearby '
            'branch, beak wide open. Adult dingoes are beginning to bolt away '
            'in alarm.',
        learningCue:
            'Pause and ask: do you think there is really danger this time? '
            'What clues could Daisy look for to find out?',
        sceneColor: Colors.yellow.shade100,
        imageUrl: 'https://openclipart.org/image/800px/355582',
      ),
      StoryPage(
        pageNumber: 5,
        narration:
            'The whole pack bolted into the bushes, but Daisy hesitated. She '
            'looked up and saw no eagle in the sky. When she crept back to the '
            'clearing, the kookaburra was pecking at their lizard, gobbling it '
            'up.',
        visualDescription:
            'Daisy crouching at the edge of the clearing, eyes wide with '
            'surprise. The kookaburra stands on the flat rock eating the '
            'lizard. The sky behind is completely clear with no eagle in sight.',
        learningCue:
            'Ask how Daisy feels seeing this. Has anyone ever been tricked by '
            'someone they trusted? How did it feel?',
        sceneColor: Colors.red.shade100,
        imageUrl: 'https://openclipart.org/image/800px/355895',
      ),
      StoryPage(
        pageNumber: 6,
        narration:
            'That evening, Daisy told her mum what happened. Her mum nuzzled '
            'her gently and said, "Some creatures use noise to confuse, not to '
            'help. A real warning matches what your own eyes can see."',
        visualDescription:
            'A warm twilight scene with Daisy\'s mother nuzzling the pup under '
            'a large boab tree. Soft blue and purple tones in the sky. The '
            'kookaburra is a small distant silhouette on a far branch.',
        learningCue:
            'Discuss the mum\'s advice. What does it mean to check if a '
            'warning matches what you can see for yourself?',
        sceneColor: Colors.blue.shade100,
        imageUrl: 'https://openclipart.org/image/800px/355582',
      ),
      StoryPage(
        pageNumber: 7,
        narration:
            'From that day on, Daisy learned to pause before panicking. When '
            'she heard a warning call, she would stop, look around carefully, '
            'and check the sky before running.',
        visualDescription:
            'Daisy standing tall and alert in an open outback clearing, ears '
            'pricked forward, eyes scanning the sky confidently. Teal-tinted '
            'eucalyptus trees frame the scene. Other pack members watch her '
            'with respect.',
        learningCue:
            'Practice the stop-look-check steps with the children. What are '
            'three things Daisy does before deciding to run?',
        sceneColor: Colors.teal.shade100,
        imageUrl: 'https://openclipart.org/image/800px/355582',
      ),
      StoryPage(
        pageNumber: 8,
        narration:
            'Daisy smiled as the morning sun warmed her fur. She whispered to '
            'her little brother, "A loud voice doesn\'t always speak the truth. '
            'Trust your own eyes too."',
        visualDescription:
            'A golden sunrise over the outback with Daisy and a smaller dingo '
            'pup sitting side by side on a gentle hill, looking out over the '
            'landscape. Warm amber light bathes the scene in a hopeful glow.',
        learningCue:
            'Reflect on the story\'s message together. When should we double-'
            'check what someone tells us instead of reacting right away?',
        sceneColor: Colors.amber.shade50,
        imageUrl: 'https://openclipart.org/image/800px/355582',
      ),
    ],
    educatorGuide: EducatorGuide(
      learningObjectives: [
        'Understand that loud or confident voices do not always tell the truth.',
        'Recognise the difference between a genuine warning and a false alarm '
            'designed to manipulate.',
        'Practise pausing to verify information before reacting in fear.',
        'Build the habit of checking what you can see and hear for yourself '
            'before trusting a claim.',
      ],
      discussionPrompts: [
        DiscussionPrompt(
          question:
              'The kookaburra made a very loud noise. Does a loud voice always '
              'mean someone is telling the truth?',
          guidanceNote:
              'Help young children connect loudness with attention-seeking '
              'rather than honesty. Use examples like a fire alarm versus a car '
              'horn honking for fun.',
          targetAge: AgeGroup.preschool,
        ),
        DiscussionPrompt(
          question:
              'Why did the dingo pack believe the kookaburra every time at '
              'first? What changed?',
          guidanceNote:
              'Guide children to explore how repeated truthful behaviour builds '
              'trust, and how one betrayal can break it. Relate to playground '
              'experiences.',
          targetAge: AgeGroup.earlyPrimary,
        ),
        DiscussionPrompt(
          question:
              'Have you ever seen someone spread a false alarm or fake news? '
              'What happened when people believed it?',
          guidanceNote:
              'Encourage older children to think about real-world examples like '
              'online misinformation or chain messages. Discuss how false '
              'alarms waste time and erode trust.',
          targetAge: AgeGroup.latePrimary,
        ),
        DiscussionPrompt(
          question:
              'What are Daisy\'s three steps before she reacts to a warning? '
              'Can we use those steps in our own lives?',
          guidanceNote:
              'Reinforce the stop-look-check framework. Have children role-play '
              'scenarios where they practise pausing before reacting to '
              'alarming information.',
          targetAge: AgeGroup.earlyPrimary,
        ),
      ],
      activities: [
        Activity(
          title: 'True Call or Trick Call',
          description:
              'Play a listening game where the educator makes different animal '
              'sounds. Children hold up a green card if they think it is a real '
              'warning and a red card if they think it is a trick. Discuss each '
              'answer together.',
          materials: [
            'Green card per child',
            'Red card per child',
            'List of animal warning sounds',
          ],
          durationMinutes: 15,
          targetAge: AgeGroup.preschool,
        ),
        Activity(
          title: 'Fact-Check Relay',
          description:
              'Split into teams. Each team receives a statement card that is '
              'either true or a false alarm. Teams race to find clues around '
              'the room that prove or disprove their statement, then present '
              'their findings.',
          materials: [
            'Statement cards with true and false claims',
            'Clue cards hidden around the room',
            'Team score sheet',
          ],
          durationMinutes: 25,
          targetAge: AgeGroup.earlyPrimary,
        ),
        Activity(
          title: 'Misinformation Detective Journal',
          description:
              'Children keep a journal for one week, noting any time they '
              'encounter a claim that turned out to be exaggerated or false. '
              'They record what the claim was, how they checked it, and what '
              'they found. Share entries in a group discussion.',
          materials: [
            'Notebook or journal per child',
            'Pencils or pens',
            'Printed verification checklist',
          ],
          durationMinutes: 30,
          targetAge: AgeGroup.latePrimary,
        ),
      ],
      culturalContext:
          'Dingoes are Australia\'s native wild dogs, living in family packs '
          'across the outback. Kookaburras are iconic Australian birds famous '
          'for their loud, laugh-like call that echoes through eucalyptus '
          'forests. In Aboriginal Australian culture, the kookaburra\'s laugh '
          'is said to signal the start of each new day. This story reimagines '
          'the kookaburra\'s distinctive call as a tool for both genuine '
          'warning and deliberate deception, teaching children that familiar '
          'and trusted signals can sometimes be misused.',
      safetyTakeaway:
          'Not every alarm is real. When someone shouts a warning, take a '
          'moment to stop, look around, and check for yourself before you '
          'react. A loud voice does not always mean the truth is being told.',
    ),
    questions: [
      ComprehensionQuestion(
        id: 'daisy_q1',
        questionText: 'How did the kookaburra trick the dingo pack?',
        options: [
          'By hiding their food in a tree',
          'By using its loud laugh to scare them away from food',
          'By pretending to be a friendly bird',
          'By singing a beautiful song',
        ],
        correctIndex: 1,
        explanation:
            'The kookaburra used its loud laughter-like call to create '
            'false alarms, making the dingoes abandon their food.',
        mascotEncouragement: 'Sharp ears, mate! You caught the trick!',
      ),
      ComprehensionQuestion(
        id: 'daisy_q2',
        questionText:
            'What is the best thing to do when you hear a warning or alarm?',
        options: [
          'Run away as fast as you can',
          'Ignore it completely',
          'Stop, look around, and check if it is real',
          'Shout even louder',
        ],
        correctIndex: 2,
        explanation:
            'Before reacting to any alarm, it is important to stop, look '
            'around, and check whether the danger is real.',
        mascotEncouragement: 'Bonzer! That is exactly what Daisy learned!',
      ),
      ComprehensionQuestion(
        id: 'daisy_q3',
        questionText: 'Why is it important to check if an alarm is real?',
        options: [
          'Because loud sounds are always dangerous',
          'Because some people use false alarms to trick others',
          'Because alarms are always fake',
          'Because checking is more fun than running',
        ],
        correctIndex: 1,
        explanation:
            'Some people or animals use false alarms to trick others into '
            'doing what they want. Checking helps you avoid being tricked.',
        mascotEncouragement: 'You are learning to think before you react!',
      ),
    ],
  ),
];
