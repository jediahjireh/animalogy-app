import 'package:flutter/material.dart';
import '../../core/constants/age_groups.dart';
import '../../core/constants/safety_themes.dart';
import '../../domain/models/story_pack.dart';
import '../../domain/models/localized_story_content.dart';
import '../../domain/models/story_page.dart';
import '../../domain/models/educator_guide.dart';
import '../../domain/models/discussion_prompt.dart';
import '../../domain/models/activity.dart';
import '../../domain/models/comprehension_question.dart';

/// Kaia's story pack with multi-language support (English + Afrikaans)
final StoryPack kaiaMeerkatPackMultilang = StoryPack(
  id: 'kaia_bird_danger',
  mascotId: 'kaia_meerkat',
  regionId: 'south_africa',
  safetyTheme: SafetyTheme.onlineDeception,
  ageGroups: [AgeGroup.preschool, AgeGroup.earlyPrimary, AgeGroup.latePrimary],
  availableLanguages: ['en', 'af'],
  defaultLanguage: 'en',
  translations: {'en': _englishContent, 'af': _afrikaansContent},
);

// ============================================================================
// ENGLISH CONTENT
// ============================================================================

final LocalizedStoryContent _englishContent = LocalizedStoryContent(
  title: 'Kaia and the Bird Who Cried Danger',
  synopsis:
      'Kaia the meerkat trusts a clever drongo bird that fakes danger calls '
      'to steal food. Through this betrayal, Kaia learns that not everyone '
      'who sounds helpful is telling the truth — a lesson about recognising '
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
      imageUrl: 'https://openclipart.org/image/800px/355165',
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
      imageUrl: 'https://openclipart.org/image/800px/355412',
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
      imageUrl: 'https://openclipart.org/image/800px/355814',
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
      imageUrl: 'https://openclipart.org/image/800px/355961',
    ),
    StoryPage(
      pageNumber: 5,
      narration:
          'When the meerkats crept back out, every last grub was gone. '
          'The drongo had tricked them and gobbled up their lunch. '
          'It had never been watching over them at all — it was hungry.',
      visualDescription:
          'Meerkats emerging cautiously from burrows to find empty ground '
          'where their food was. In the distance, the drongo flies away '
          'with something in its beak. Kaia stares at the bare sand.',
      learningCue:
          'Help children name the feeling of being tricked by someone '
          'they trusted. This is what deception feels like.',
      sceneColor: Color(0xFFFFCDD2),
      imageUrl: 'https://openclipart.org/image/800px/355131',
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
      imageUrl: 'https://openclipart.org/image/800px/355165',
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
          'We can do this online too — check before we click, share, '
          'or believe.',
      sceneColor: Color(0xFFB2DFDB),
      imageUrl: 'https://openclipart.org/image/800px/355184',
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
      imageUrl: 'https://openclipart.org/image/800px/355165',
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
    ],
    activities: [
      Activity(
        title: 'True or Tricky Sorting Game',
        description:
            'Prepare cards with simple statements — some true, some tricky '
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
    ],
    culturalContext:
        'The fork-tailed drongo is a real bird found across sub-Saharan Africa, '
        'including the Kalahari where meerkats live. Scientists have documented '
        'drongos using deceptive alarm calls to steal food from meerkats, '
        'mongooses, and other animals — an extraordinary example of tactical '
        'deception in nature.',
    safetyTakeaway:
        'Just like Kaia learned to verify danger before reacting, children '
        'must learn to pause and check before trusting online messages, '
        'friend requests, or warnings that create urgency. Deception often '
        'builds trust first, then exploits it.',
  ),
  questions: [
    ComprehensionQuestion(
      id: 'q1',
      questionText: 'Why did the drongo bird call "Danger!" the first time?',
      options: [
        'To help the meerkats',
        'To steal their food',
        'Because it saw a real threat',
        'To make friends',
      ],
      correctIndex: 1,
      explanation:
          'The drongo was actually planning to steal the meerkats\' food by '
          'tricking them into running away. It was never trying to help them!',
      mascotEncouragement:
          'Great thinking! The drongo wasn\'t being honest from the start.',
    ),
    ComprehensionQuestion(
      id: 'q2',
      questionText: 'What did Kaia do differently after she learned the truth?',
      options: [
        'She stopped eating lunch',
        'She moved to a new burrow',
        'She checked for danger herself before reacting',
        'She chased the drongo away',
      ],
      correctIndex: 2,
      explanation:
          'Kaia became smarter! Instead of just believing the drongo, she '
          'started checking for herself to see if there was real danger.',
      mascotEncouragement:
          'Exactly right! Kaia learned to verify information, just like we '
          'should online.',
    ),
  ],
);

// ============================================================================
// AFRIKAANS CONTENT
// ============================================================================

final LocalizedStoryContent _afrikaansContent = LocalizedStoryContent(
  title: 'Kaia en die Voël wat Gevaar geroep het',
  synopsis:
      'Kaia die meerkat vertrou \'n slim drongo-voël wat vals gevaaroproepe '
      'maak om kos te steel. Deur hierdie verraad leer Kaia dat nie almal '
      'wat hulpvaardig klink die waarheid praat nie — \'n les oor bedrog '
      'aanlyn en in die daaglikse lewe.',
  pages: [
    StoryPage(
      pageNumber: 1,
      narration:
          'Kaia was mal oor etetyd. Sy en haar vriende het onder die warm '
          'goue son gegrawe vir kewers en wurms, terwyl hulle gesels en '
          'saam gelag het.',
      visualDescription:
          'A group of meerkats foraging happily in sandy Kalahari terrain '
          'under a bright midday sun, with scattered tufts of dry grass '
          'and a clear blue sky overhead.',
      learningCue:
          'Vra die kinders wat hul gunsteling deel van etetyd is. '
          'Om veilig en gelukkig met vriende te voel is iets wat ons almal geniet.',
      sceneColor: Color(0xFFFFECB3),
      imageUrl: 'https://openclipart.org/image/800px/355165',
    ),
    StoryPage(
      pageNumber: 2,
      narration:
          'Eendag het \'n gladde swart voël van die lug afgeskiet. '
          '"Gevaar! Gevaar!" het dit in \'n skerp, dringende stem geroep. '
          'Die meerkatte het dadelik in hul gate ingehardloop.',
      visualDescription:
          'A glossy fork-tailed drongo diving towards a group of startled '
          'meerkats who are mid-scatter, some already ducking into sandy '
          'burrow entrances, dust rising around them.',
      learningCue:
          'Praat oor hoe die meerkatte sonder om te dink gereageer het. '
          'Wanneer iemand iets skreierig roep, reageer ons dikwels voor '
          'ons kontroleer of dit waar is.',
      sceneColor: Color(0xFFFFE0B2),
      imageUrl: 'https://openclipart.org/image/800px/355412',
    ),
    StoryPage(
      pageNumber: 3,
      narration:
          'Die drongo-voël het elke dag daarna kom kuier, altyd wakker '
          'oor die meerkatte. "Hy pas altyd vir ons op," het Kaia trots '
          'vir haar ma gesê. Die hele gesin het die hulpvaardige voël vertrou.',
      visualDescription:
          'The drongo perched on a low acacia branch near the meerkat '
          'colony, looking attentive while meerkats forage below. '
          'Kaia gazes up at the bird with admiration.',
      learningCue:
          'Bespreek hoe vertroue met tyd bou. Iemand wat herhaaldelik '
          'vriendelik lyk kan ons laat glo hulle sal altyd vriendelik wees.',
      sceneColor: Color(0xFFC8E6C9),
      imageUrl: 'https://openclipart.org/image/800px/355814',
    ),
    StoryPage(
      pageNumber: 4,
      narration:
          'Toe, een sonnige etetyd, net toe die meerkatte die lekkerste '
          'wurms gekry het, het die drongo geskreeu: "Gevaar! Hardloop!" '
          'Kaia en haar vriende het ondergronds gehardloop sonder om twee '
          'keer te dink.',
      visualDescription:
          'Meerkats abandoning a pile of freshly dug beetles and grubs '
          'as they bolt toward their burrows. The drongo watches from '
          'above with its head tilted.',
      learningCue:
          'Vra of die kinders hierdie keer iets anders opgemerk het. '
          'Was daar regte gevaar, of het die voël \'n ander rede gehad '
          'om te roep?',
      sceneColor: Color(0xFFFFF9C4),
      imageUrl: 'https://openclipart.org/image/800px/355961',
    ),
    StoryPage(
      pageNumber: 5,
      narration:
          'Toe die meerkatte versigtig terugkom, was elke wurm weg. '
          'Die drongo het hulle mislei en hul middagete opgeslurp. '
          'Hy het nooit vir hulle opgepas nie — hy was honger.',
      visualDescription:
          'Meerkats emerging cautiously from burrows to find empty ground '
          'where their food was. In the distance, the drongo flies away '
          'with something in its beak. Kaia stares at the bare sand.',
      learningCue:
          'Help kinders om die gevoel te benoem wanneer iemand wat jy '
          'vertrou jou mislei. Dit is hoe bedrog voel.',
      sceneColor: Color(0xFFFFCDD2),
      imageUrl: 'https://openclipart.org/image/800px/355131',
    ),
    StoryPage(
      pageNumber: 6,
      narration:
          'Kaia het \'n swaar hartseer in haar bors gevoel. Mama Meerkat '
          'het haar saggies gestreel en gesê: "Nie almal wat mooi lyk is '
          'regtig vriendelik nie, kleintjie. Party gebruik vriendelikheid '
          'om te kry wat hulle wil hê."',
      visualDescription:
          'Mama Meerkat comforting a visibly sad young Kaia near the '
          'burrow entrance at golden hour. Warm light casts long shadows '
          'across the sandy ground.',
      learningCue:
          'Dit is \'n sleutelmoment om te praat oor vreemdes aanlyn wat '
          'vriendelik lyk maar verborge motiewe het, net soos die drongo.',
      sceneColor: Color(0xFFBBDEFB),
      imageUrl: 'https://openclipart.org/image/800px/355165',
    ),
    StoryPage(
      pageNumber: 7,
      narration:
          'Kaia het besluit sy sal self leer kyk vir gevaar. Die volgende '
          'keer toe die drongo roep, het sy eers versigtig gekyk. '
          'Geen arend nie. Geen jakkals nie. Sy het gebly en haar middagete '
          'klaar geëet.',
      visualDescription:
          'Kaia standing upright on her hind legs, scanning the horizon '
          'with sharp eyes while other meerkats hesitate near burrow '
          'entrances. The drongo sits on a branch looking frustrated.',
      learningCue:
          'Vier hoe Kaia die inligting geverifieer het voor sy reageer het. '
          'Ons kan dit ook aanlyn doen — kyk voor ons kliek, deel, '
          'of glo.',
      sceneColor: Color(0xFFB2DFDB),
      imageUrl: 'https://openclipart.org/image/800px/355184',
    ),
    StoryPage(
      pageNumber: 8,
      narration:
          'Van daardie dag af het Kaia altyd twee keer gekyk en vrae '
          'gevra voor sy \'n waarskuwing geglo het. Vriendelik beteken nie '
          'altyd veilig nie. En dit is \'n baie slim ding om te weet.',
      visualDescription:
          'Kaia confidently leading her meerkat friends in foraging, '
          'standing tall with a watchful but calm expression. The sun '
          'is setting in warm amber tones across the Kalahari.',
      learningCue:
          'Sluit af deur kinders te vra wat hulle anders sal doen wanneer '
          'iemand aanlyn vir hulle iets verrassends of skreierig vertel.',
      sceneColor: Color(0xFFFFF8E1),
      imageUrl: 'https://openclipart.org/image/800px/355165',
    ),
  ],
  educatorGuide: EducatorGuide(
    learningObjectives: [
      'Verstaan dat mense aanlyn kan voorgee om hulpvaardig te wees om '
          'ander te mislei of te benut.',
      'Herken die patroon van vertroue bou oor tyd as \'n manipulasie '
          'taktiek wat gebruik word in uitvis, vals identiteite, en sosiale manipulasie.',
      'Ontwikkel die gewoonte om inligting te verifieer voor reagering, '
          'veral wanneer \'n boodskap dringendheid of vrees skep.',
      'Bou selfvertroue om te stop, vrae te vra, en \'n vertrouede '
          'volwassene te soek wanneer iets aanlyn verkeerd voel.',
    ],
    discussionPrompts: [
      DiscussionPrompt(
        question:
            'Die drongo-voël het aan die begin baie mooi gelyk. Kan jy dink '
            'aan \'n tyd toe iemand mooi gelyk het maar nie eerlik was nie?',
        guidanceNote:
            'Vir jonger kinders, hou voorbeelde konkreet en uit die daaglikse '
            'lewe. Vermy om hulle na vreesagtigheid te lei; fokus op die idee '
            'dat kontroleer slim is, nie dat almal sleg is nie.',
        targetAge: AgeGroup.preschool,
      ),
      DiscussionPrompt(
        question:
            'Hoekom het Kaia en haar vriende die drongo so vinnig geglo '
            'elke keer as dit gevaar geroep het?',
        guidanceNote:
            'Lei kinders om die patroon te identifiseer: die drongo het vertroue '
            'gebou deur konsekwent te wees voor dit uitgebuit is. Verbind dit met hoe '
            'aanlynse bedrieërs geloofwaardigheid vestig voor hulle iets vra.',
        targetAge: AgeGroup.earlyPrimary,
      ),
    ],
    activities: [
      Activity(
        title: 'Waar of Gevaarlik Sorteerspel',
        description:
            'Maak kaarte met eenvoudige stellings — party waar, party misleidend. '
            'Kinders sorteer hulle in "Waar" en "Gevaarlik" hope, dan verduidelik '
            'hulle hul redenasie. Versterk dat kontroleer altyd die slim keuse is.',
        materials: [
          'Gedrukte of handgeskrewe stellingskaarte',
          'Twee sorteerhou mandjies of geëtiketteerde areas',
          'Stickers of stemples vir korrekte sortering',
        ],
        durationMinutes: 15,
        targetAge: AgeGroup.preschool,
      ),
    ],
    culturalContext:
        'Die vurk-stert drongo is \'n regte voël wat regoor sub-Sahara Afrika '
        'voorkom, insluitend die Kalahari waar meerkatte leef. Wetenskaplikes '
        'het gedokumenteer hoe drongos misleidende alarmoproepe gebruik om kos '
        'van meerkatte, muishonde, en ander diere te steel — \'n buitengewone '
        'voorbeeld van taktiese bedrog in die natuur.',
    safetyTakeaway:
        'Net soos Kaia geleer het om gevaar te verifieer voor sy reageer, '
        'moet kinders leer om te stop en te kontroleer voor hulle aanlynse '
        'boodskappe, vriendversoeke, of waarskuwings wat dringendheid skep, '
        'vertrou. Bedrog bou dikwels eers vertroue, dan buit dit dit uit.',
  ),
  questions: [
    ComprehensionQuestion(
      id: 'q1',
      questionText:
          'Hoekom het die drongo-voël die eerste keer "Gevaar!" geroep?',
      options: [
        'Om die meerkatte te help',
        'Om hul kos te steel',
        'Omdat dit \'n regte bedreiging gesien het',
        'Om vriende te maak',
      ],
      correctIndex: 1,
      explanation:
          'Die drongo was eintlik van plan om die meerkatte se kos te steel '
          'deur hulle te mislei om weg te hardloop. Dit het nooit probeer help nie!',
      mascotEncouragement:
          'Goeie denkwerk! Die drongo was nie van die begin af eerlik nie.',
    ),
    ComprehensionQuestion(
      id: 'q2',
      questionText:
          'Wat het Kaia anders gedoen nadat sy die waarheid geleer het?',
      options: [
        'Sy het opgehou eet',
        'Sy het na \'n nuwe gat getrek',
        'Sy het self vir gevaar gekyk voor sy reageer',
        'Sy het die drongo weggeja',
      ],
      correctIndex: 2,
      explanation:
          'Kaia het slimmer geword! In plaas van net die drongo te glo, '
          'het sy begin self kyk of daar regte gevaar was.',
      mascotEncouragement:
          'Presies reg! Kaia het geleer om inligting te verifieer, net soos '
          'ons aanlyn moet doen.',
    ),
  ],
);
