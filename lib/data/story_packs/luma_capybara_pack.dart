import 'package:flutter/material.dart';
import '../../core/constants/age_groups.dart';
import '../../core/constants/safety_themes.dart';
import '../../domain/models/story_pack.dart';
import '../../domain/models/story_page.dart';
import '../../domain/models/educator_guide.dart';
import '../../domain/models/discussion_prompt.dart';
import '../../domain/models/activity.dart';

final List<StoryPack> lumaCapybaraPacks = [
  StoryPack(
    id: 'luma_sneaky_snake',
    title: 'Luma and the Sneaky Snake',
    mascotId: 'luma_capybara',
    regionId: 'brazil',
    safetyTheme: SafetyTheme.hiddenDanger,
    ageGroups: AgeGroup.values.toList(),
    synopsis:
        'Deep in the Amazon, an anaconda lies still and silent by the riverbank, '
        'pretending to be nothing more than a fallen log. Day after day it stays '
        'motionless, gaining the capybaras\u0027 trust through sheer inaction. Luma must '
        'learn that patience is not always kindness \u2014 sometimes danger waits quietly '
        'until you stop looking.',
    pages: [
      StoryPage(
        pageNumber: 1,
        narration:
            'Luma the capybara loved splashing in the cool Amazon river with her '
            'friends. Every morning they raced to the water, diving and tumbling '
            'through the gentle current together.',
        visualDescription:
            'A group of cheerful capybaras playing in a wide, sun-dappled Amazon '
            'river surrounded by lush green rainforest. Luma, slightly smaller '
            'with bright curious eyes, leaps into the water.',
        learningCue:
            'Ask the children what their favourite place to play with friends is '
            'and what makes them feel safe there.',
        sceneColor: Colors.green.shade100,
      ),
      StoryPage(
        pageNumber: 2,
        narration:
            'One day a new shape appeared by the riverbank \u2014 a long, dark log half '
            'buried in the mud. The capybaras swam past it without a second thought. '
            'Logs were everywhere, after all.',
        visualDescription:
            'A murky brown riverbank with a long, dark shape resting motionless at '
            'the water\u0027s edge. Several capybaras swim casually nearby, paying it '
            'no attention.',
        learningCue:
            'Ask: have you ever seen something new appear in a familiar place and '
            'assumed it was harmless because everything else around it was normal?',
        sceneColor: Colors.brown.shade100,
      ),
      StoryPage(
        pageNumber: 3,
        narration:
            'Days passed and the log never moved. Not even a twitch. Some of the '
            'braver capybaras began resting against it in the afternoon heat. It '
            'seemed as solid and safe as any rock.',
        visualDescription:
            'A peaceful afternoon scene with capybaras lounging on and around the '
            'still shape by the riverbank. Warm light filters through the canopy, '
            'everything looks calm and safe.',
        learningCue:
            'Discuss how something staying quiet and still for a long time can make '
            'us believe it is safe, even when we never actually checked.',
        sceneColor: Colors.teal.shade100,
      ),
      StoryPage(
        pageNumber: 4,
        narration:
            'Luma\u0027s friend wandered to the riverbank alone one evening. She sat down '
            'right next to the log. Then, just barely, the log twitched. A tiny, '
            'almost invisible movement.',
        visualDescription:
            'A single young capybara sitting beside the dark shape at dusk. The '
            'shape has shifted ever so slightly \u2014 a faint ripple in the mud beside '
            'it. The scene feels tense and uneasy.',
        learningCue:
            'Ask: what small warning signs might you notice if something online or '
            'in real life is not what it seems?',
        sceneColor: Colors.yellow.shade100,
      ),
      StoryPage(
        pageNumber: 5,
        narration:
            'Luma crept closer and froze. Beneath the mud she saw scales \u2014 smooth, '
            'glistening scales. "That\u0027s not a log!" she cried out. The enormous '
            'anaconda began to unfurl, its body uncoiling like a thick, heavy rope.',
        visualDescription:
            'A dramatic close-up of Luma staring wide-eyed at the shape, which now '
            'reveals patterned scales beneath cracked mud. The anaconda\u0027s head lifts '
            'slightly, eyes glinting. Luma\u0027s fur stands on end.',
        learningCue:
            'Talk about the courage it takes to speak up when you notice something '
            'wrong, even if everyone else seems unbothered.',
        sceneColor: Colors.red.shade100,
      ),
      StoryPage(
        pageNumber: 6,
        narration:
            'Luma\u0027s warning rang across the river. The capybaras bolted together, '
            'splashing through the shallows to the far bank. Because Luma spoke up, '
            'every single one of them made it to safety.',
        visualDescription:
            'Capybaras racing through churning water toward the opposite bank, '
            'spray flying around them. Behind them the anaconda is fully visible, '
            'massive and dark against the muddy shore. Luma runs at the rear, '
            'making sure no one is left behind.',
        learningCue:
            'Highlight how telling a trusted adult or friend about something '
            'suspicious can protect everyone, not just yourself.',
        sceneColor: Colors.orange.shade100,
      ),
      StoryPage(
        pageNumber: 7,
        narration:
            'That night, Grandpa Capybara gathered the little ones close. "Danger '
            'is patient," he said softly. "It waits and waits until you stop '
            'looking. Never stop looking."',
        visualDescription:
            'An elderly capybara with greying fur sits beneath a moonlit tree, '
            'surrounded by young capybaras listening intently. Fireflies drift '
            'around them. The mood is warm but serious.',
        learningCue:
            'Reinforce the idea that some dangers are designed to seem boring or '
            'invisible on purpose. Ask who they would talk to if something felt '
            'off.',
        sceneColor: Colors.blue.shade100,
      ),
      StoryPage(
        pageNumber: 8,
        narration:
            'Luma looked out at the quiet river and understood. Not everything '
            'quiet is safe. Not everything still is harmless. Stay curious, stay '
            'watchful, and always trust that little feeling inside.',
        visualDescription:
            'Luma standing at the river\u0027s edge at sunrise, gazing calmly across the '
            'water. The far bank is peaceful but she watches with wise, attentive '
            'eyes. Golden light wraps around her.',
        learningCue:
            'End with a reflection: what is one thing you will pay more attention '
            'to from now on?',
        sceneColor: Colors.amber.shade50,
      ),
    ],
    educatorGuide: EducatorGuide(
      learningObjectives: [
        'Understand that danger can be hidden in things that look ordinary or harmless.',
        'Recognise that silence and stillness do not always mean safety, especially online.',
        'Build the confidence to speak up when something feels wrong, even without proof.',
        'Learn to stay watchful and curious rather than assuming familiar surroundings are risk-free.',
      ],
      discussionPrompts: [
        DiscussionPrompt(
          question:
              'The log stayed very still for a long time. Why did the capybaras '
              'think it was safe?',
          guidanceNote:
              'Guide children to understand that familiarity breeds false comfort. '
              'Something being around for a while does not make it trustworthy. '
              'Relate to online profiles or apps that seem harmless because they '
              'have been there a long time.',
          targetAge: AgeGroup.preschool,
        ),
        DiscussionPrompt(
          question:
              'Luma noticed something small \u2014 the scales under the mud. What are '
              'some small warning signs you might see online that tell you something '
              'is not right?',
          guidanceNote:
              'Help children brainstorm concrete examples: a stranger asking for '
              'personal information, a message that feels too good to be true, or '
              'a website that looks slightly different from the real one. Emphasise '
              'that small clues matter.',
          targetAge: AgeGroup.earlyPrimary,
        ),
        DiscussionPrompt(
          question:
              'Why do you think the anaconda stayed still for so many days instead '
              'of attacking right away?',
          guidanceNote:
              'Connect patience as a predatory strategy to online grooming and '
              'scam tactics. Discuss how some dangers build trust slowly on purpose. '
              'Appropriate for older children who can grasp longer-term deception.',
          targetAge: AgeGroup.latePrimary,
        ),
        DiscussionPrompt(
          question:
              'Luma warned her friends even though she was scared. What would you '
              'do if you noticed something suspicious but were not completely sure?',
          guidanceNote:
              'Reassure children that they do not need to be certain before telling '
              'a trusted adult. It is always better to speak up and be wrong than '
              'to stay silent and be right. Practise the phrase: "Something does '
              'not feel right."',
          targetAge: AgeGroup.earlyPrimary,
        ),
      ],
      activities: [
        Activity(
          title: 'Log or Not? Sorting Game',
          description:
              'Print or draw pictures of safe objects (a real log, a rock, a park '
              'bench) and hidden dangers (an anaconda disguised as a log, a broken '
              'step covered by leaves). Children sort them into "safe" and "look '
              'closer" piles, explaining their reasoning.',
          materials: [
            'Printed picture cards or drawing supplies',
            'Two sorting baskets or labelled areas',
          ],
          durationMinutes: 15,
          targetAge: AgeGroup.preschool,
        ),
        Activity(
          title: 'Spot the Difference: Safe or Sneaky?',
          description:
              'Show pairs of nearly identical screenshots \u2014 one from a real website '
              'or app and one from a fake version with subtle differences (misspelled '
              'name, slightly wrong logo, unusual URL). Children work in pairs to '
              'find the clues that reveal the fake.',
          materials: [
            'Printed screenshot pairs or a tablet to display them',
            'Magnifying glasses for dramatic effect',
            'Pencils and a checklist worksheet',
          ],
          durationMinutes: 20,
          targetAge: AgeGroup.earlyPrimary,
        ),
        Activity(
          title: 'The Patience Predator Journal',
          description:
              'Children keep a one-week journal noting things in their digital life '
              'that seem normal but they have never actually verified \u2014 an app '
              'permission they always skip, a group chat member they do not really '
              'know, a website they visit without checking the URL. At the end of '
              'the week, discuss findings as a group and decide which items deserve '
              'a closer look.',
          materials: [
            'Small notebook or printed journal template',
            'Pen or pencil',
            'Optional: internet-safe device for supervised checking',
          ],
          durationMinutes: 30,
          targetAge: AgeGroup.latePrimary,
        ),
      ],
      culturalContext:
          'Capybaras are the world\u0027s largest rodents and are native to the '
          'wetlands and rivers of South America, particularly the Amazon basin in '
          'Brazil. They are gentle, social animals that live in groups and spend '
          'much of their time in or near water. Green anacondas, also native to the '
          'Amazon, are among the largest snakes on Earth and are ambush predators '
          'that rely on camouflage and patience, lying motionless for long periods '
          'before striking. This natural dynamic between capybaras and anacondas '
          'provides an authentic ecological backdrop for teaching children about '
          'hidden dangers that use stillness and familiarity to avoid detection.',
      safetyTakeaway:
          'Not everything that looks safe actually is. Some dangers are patient '
          '\u2014 they stay quiet and still until you stop paying attention. Always '
          'stay curious, look closely at things you take for granted, and speak up '
          'the moment something feels wrong. You do not need to be sure to ask for '
          'help.',
    ),
  ),
];
