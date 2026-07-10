import 'package:flutter/material.dart';
import '../../core/constants/age_groups.dart';
import '../../core/constants/safety_themes.dart';
import '../../domain/models/story_pack.dart';
import '../../domain/models/story_page.dart';
import '../../domain/models/educator_guide.dart';
import '../../domain/models/discussion_prompt.dart';
import '../../domain/models/activity.dart';
import '../../domain/models/comprehension_question.dart';

final List<StoryPack> rickyRaccoonPacks = [
  StoryPack(
    id: 'ricky_owl_lied',
    title: 'Ricky and the Owl That Lied',
    mascotId: 'ricky_raccoon',
    regionId: 'north_america',
    safetyTheme: SafetyTheme.betrayalOfTrust,
    ageGroups: AgeGroup.values.toList(),
    synopsis:
        'Deep in the moonlit forest, a great horned owl watches over the animals. '
        'Everyone trusts the owl because it sees everything and warns them of danger. '
        'But Ricky the raccoon discovers that the wise owl has been using false danger '
        'alerts to scare smaller animals away from their food, only to steal it for '
        'itself. Ricky learns that trust must be earned through honest actions, and '
        'that even someone wise and respected can choose to be unkind.',
    pages: [
      StoryPage(
        pageNumber: 1,
        narration:
            'Ricky the raccoon loved foraging for berries in the moonlit forest. '
            'Every evening, he would scurry along the mossy paths, filling his '
            'little paws with the sweetest blackberries he could find.',
        visualDescription:
            'A cheerful raccoon with bright eyes picking blackberries under a '
            'glowing full moon, surrounded by tall pine trees and soft mossy ground.',
        learningCue:
            'Ask children what makes them feel safe in familiar places.',
        sceneColor: Color(0xFFC5CAE9),
        imageUrl: 'https://openclipart.org/image/800px/355825',
      ),
      StoryPage(
        pageNumber: 2,
        narration:
            'High up in the tallest oak tree sat a great horned owl. "I see '
            'everything," it hooted in its deep, important voice. All the '
            'forest animals trusted the owl to keep watch.',
        visualDescription:
            'A large great horned owl perched on a thick oak branch, looking '
            'down with wide golden eyes over a darkened forest clearing filled '
            'with small animals gazing up respectfully.',
        learningCue:
            'Discuss what makes someone seem trustworthy and why animals might '
            'look up to the owl.',
        sceneColor: Color(0xFFD1C4E9),
        imageUrl: 'https://openclipart.org/image/800px/355964',
      ),
      StoryPage(
        pageNumber: 3,
        narration:
            'Whenever danger was near, the owl would call out a warning. The '
            'rabbits, mice, and raccoons all listened carefully. Ricky always '
            'felt safe knowing the owl was watching.',
        visualDescription:
            'The owl spreading its wings and hooting loudly while small forest '
            'animals below look alert but calm, with a soft green forest glow.',
        learningCue:
            'Explore the idea of protectors in everyday life and why we rely on them.',
        sceneColor: Color(0xFFC8E6C9),
        imageUrl: 'https://openclipart.org/image/800px/355811',
      ),
      StoryPage(
        pageNumber: 4,
        narration:
            'One night, the owl screeched from above: "Fox! A fox is coming!" '
            'Ricky and his friends dropped their berry stash and scattered into '
            'the bushes, hearts pounding with fear.',
        visualDescription:
            'Panicked forest animals running in different directions, dropping '
            'berries on the ground, while the owl watches from above with a '
            'shadowy expression against a yellow-tinged night sky.',
        learningCue:
            'Ask how it feels when someone you trust tells you something scary.',
        sceneColor: Color(0xFFFFF9C4),
        imageUrl: 'https://openclipart.org/image/800px/355825',
      ),
      StoryPage(
        pageNumber: 5,
        narration:
            'But there was no fox. Not even a shadow of one. The owl swooped '
            'down silently, scooped up all the berries, and flew back to its '
            'branch to feast alone.',
        visualDescription:
            'The owl gliding low over the forest floor, clutching a pile of '
            'berries in its talons, with an empty clearing and scattered berry '
            'juice stains on the ground.',
        learningCue:
            'Help children identify the moment where trust was broken and how '
            'the owl used its position unfairly.',
        sceneColor: Color(0xFFFFCDD2),
        imageUrl: 'https://openclipart.org/image/800px/355273',
      ),
      StoryPage(
        pageNumber: 6,
        narration:
            'Ricky crept back and looked up at the owl. "Why did you lie to '
            'us?" he asked, his voice shaking. The owl simply shrugged its '
            'great wings. "Because I could," it said.',
        visualDescription:
            'A small raccoon standing at the base of the oak tree, looking up '
            'at a dismissive owl perched above, surrounded by a muted grey '
            'forest atmosphere.',
        learningCue:
            'Discuss how power and position can be misused by people who seem '
            'trustworthy.',
        sceneColor: Color(0xFFEEEEEE),
        imageUrl: 'https://openclipart.org/image/800px/355825',
      ),
      StoryPage(
        pageNumber: 7,
        narration:
            'That night, Ricky told his dad what happened. His dad hugged him '
            'close. "Even someone who knows a lot can choose to use what they '
            'know against you," he said gently.',
        visualDescription:
            'An older raccoon hugging a smaller raccoon inside a cozy hollow '
            'log den, with warm lantern light and a calm blue night visible '
            'through the entrance.',
        learningCue:
            'Encourage children to think about trusted adults they can talk to '
            'when something feels wrong.',
        sceneColor: Color(0xFFBBDEFB),
        imageUrl: 'https://openclipart.org/image/800px/355065',
      ),
      StoryPage(
        pageNumber: 8,
        narration:
            'Ricky learned something important that night. Trust is earned by '
            'what someone does, not just what they say. And even the wise can '
            'be unkind. It is always okay to question and speak up.',
        visualDescription:
            'Ricky standing confidently in a sunlit forest clearing at dawn, '
            'surrounded by friends, with the oak tree in the background and '
            'a warm golden glow over everything.',
        learningCue:
            'Reinforce that questioning someone in authority is brave, not rude.',
        sceneColor: Color(0xFFFFF8E1),
        imageUrl: 'https://openclipart.org/image/800px/355825',
      ),
    ],
    educatorGuide: EducatorGuide(
      learningObjectives: [
        'Understand that trust should be based on consistent honest actions, not just words or status.',
        'Recognise that authority figures and knowledgeable individuals can still act unfairly.',
        'Learn to identify when someone in a trusted position is using that position for selfish gain.',
        'Build confidence to speak up and seek help when something a trusted person does feels wrong.',
      ],
      discussionPrompts: [
        DiscussionPrompt(
          question:
              'The owl was supposed to keep everyone safe. How did it trick Ricky and his friends?',
          guidanceNote:
              'Guide younger children to retell the story in their own words, '
              'focusing on what the owl said versus what actually happened.',
          targetAge: AgeGroup.preschool,
        ),
        DiscussionPrompt(
          question:
              'Have you ever trusted someone who turned out not to be telling the truth? How did that feel?',
          guidanceNote:
              'Create a safe space for sharing. Validate feelings of confusion '
              'and disappointment without pressuring specific disclosures.',
          targetAge: AgeGroup.earlyPrimary,
        ),
        DiscussionPrompt(
          question:
              'Why do you think the owl said "Because I could"? What does that tell us about how some people use power?',
          guidanceNote:
              'Explore the concept of power imbalance at an age-appropriate '
              'level. Connect to real-world examples like older kids, coaches, '
              'or online figures who might misuse trust.',
          targetAge: AgeGroup.latePrimary,
        ),
        DiscussionPrompt(
          question:
              'What could the forest animals do differently next time the owl warns them?',
          guidanceNote:
              'Steer toward practical strategies: checking with others, looking '
              'for evidence, and asking questions rather than blindly following.',
          targetAge: AgeGroup.earlyPrimary,
        ),
      ],
      activities: [
        Activity(
          title: 'Trust Traffic Light',
          description:
              'Children sort picture cards of different actions into green '
              '(trustworthy), yellow (not sure), and red (untrustworthy) '
              'categories. Discuss why each action builds or breaks trust.',
          materials: [
            'Picture cards showing helpful and unhelpful actions',
            'Green, yellow, and red circles or mats',
            'Stickers for marking choices',
          ],
          durationMinutes: 15,
          targetAge: AgeGroup.preschool,
        ),
        Activity(
          title: 'The Owl and the Truth',
          description:
              'In pairs, one child plays the owl and makes a claim. The other '
              'child must ask three questions to figure out if the claim is '
              'true or false. Switch roles after each round.',
          materials: [
            'Claim cards with true and false statements',
            'Question prompt sheet',
            'Score sheet for tracking correct guesses',
          ],
          durationMinutes: 20,
          targetAge: AgeGroup.earlyPrimary,
        ),
        Activity(
          title: 'Authority Audit Journal',
          description:
              'Children keep a one-week journal noting moments when someone '
              'in charge made a decision. They reflect on whether the decision '
              'was fair, who it helped, and whether they could ask questions '
              'about it.',
          materials: [
            'Printed journal template with daily reflection prompts',
            'Pencils or pens',
            'Example entries to model the activity',
          ],
          durationMinutes: 30,
          targetAge: AgeGroup.latePrimary,
        ),
      ],
      culturalContext:
          'Raccoons are native to North America and are known for their '
          'curiosity, cleverness, and resourceful foraging habits. Great '
          'horned owls are apex predators in North American forests, often '
          'associated with wisdom in popular culture. This story uses the '
          'natural predator-prey dynamic between owls and smaller mammals '
          'to explore how trusted authority figures can exploit their '
          'position, a theme relevant across cultures.',
      safetyTakeaway:
          'Trust is something that should be earned through honest and '
          'consistent actions. Just because someone is older, wiser, or in '
          'charge does not mean they will always act in your best interest. '
          'If something feels wrong, it is okay to ask questions, check with '
          'others, and tell a safe adult about your concerns.',
    ),
    questions: [
      ComprehensionQuestion(
        id: 'ricky_q1',
        questionText: 'Why did the other animals trust the owl at first?',
        options: [
          'Because the owl was very funny',
          'Because the owl was wise and warned them of danger',
          'Because the owl gave them food',
          'Because the owl was the smallest animal',
        ],
        correctIndex: 1,
        explanation:
            'The animals trusted the owl because it seemed wise and '
            'helpful, always warning them about danger in the forest.',
        mascotEncouragement: 'Good thinking! Trust should be based on actions!',
      ),
      ComprehensionQuestion(
        id: 'ricky_q2',
        questionText:
            'What was the owl really doing with the false danger alerts?',
        options: [
          'Protecting the smaller animals',
          'Practising its warning calls',
          'Scaring animals away to steal their food',
          'Playing a harmless game',
        ],
        correctIndex: 2,
        explanation:
            'The owl used false danger alerts to scare smaller animals '
            'away from their food so it could take the food for itself.',
        mascotEncouragement: 'You uncovered the truth, just like Ricky!',
      ),
      ComprehensionQuestion(
        id: 'ricky_q3',
        questionText: 'What does it mean that trust must be earned?',
        options: [
          'You should trust everyone right away',
          'Trust comes from someone showing honest actions over time',
          'Only trust people who are older than you',
          'You should never trust anyone',
        ],
        correctIndex: 1,
        explanation:
            'Trust is earned when someone shows through their actions, '
            'again and again, that they are honest and care about you.',
        mascotEncouragement:
            'Exactly right! Watch what people do, not just what they say!',
      ),
    ],
  ),
];
