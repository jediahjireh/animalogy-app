import 'package:flutter/material.dart';
import '../../core/constants/age_groups.dart';
import '../../core/constants/safety_themes.dart';
import '../../domain/models/story_pack.dart';
import '../../domain/models/localized_story_content.dart';
import '../../domain/models/localized_story_page.dart';
import '../../domain/models/localized_educator_guide.dart';
import '../../domain/models/localized_discussion_prompt.dart';
import '../../domain/models/localized_activity.dart';
import '../../domain/models/localized_comprehension_question.dart';

/// Bruno's story pack with Romanian + English support
final StoryPack brunoBearPack = StoryPack(
  id: 'bruno_hidden_berries',
  mascotId: 'bruno_bear', // Note: mascot needs to be added to mascot_registry
  regionId: 'carpathian_mountains', // Note: region needs to be added to regions
  safetyTheme: SafetyTheme.hiddenDanger,
  ageGroups: [
    AgeGroup.preschool,
    AgeGroup.earlyPrimary,
    AgeGroup.latePrimary,
  ],
  availableLanguages: ['ro', 'en'],
  defaultLanguage: 'ro',
  translations: {
    'ro': _romanianContent,
    'en': _englishContent,
  },
);

// ============================================================================
// ROMANIAN CONTENT (PRIMARY)
// ============================================================================

final LocalizedStoryContent _romanianContent = LocalizedStoryContent(
  title: 'Bruno și Poiana cu Afine Ascunse',
  synopsis:
      'Bruno ursul brun găsește o poiană frumoasă plină cu afine în munții '
      'Carpați. Dar sub frunzele verzi se ascunde un pericol pe care Bruno '
      'nu îl vede. O lecție despre cum lucrurile frumoase pot ascunde pericole '
      'ascunse — la fel ca pe internet.',
  pages: [
    LocalizedStoryPage(
      pageNumber: 1,
      narration:
          'Bruno ursul brun trăia în pădurea deasă a munților Carpați. '
          'Într-o zi călduroasă de vară, a simțit un miros dulce plutind '
          'prin aer. Afine! Bruno era foarte fericit.',
      visualDescription:
          'A brown bear in a dense Carpathian forest with tall pine trees, '
          'looking excited as he sniffs the air. Morning sunlight filters '
          'through the canopy.',
      learningCue:
          'Întrebați copiii ce le place lor să mănânce. Când găsim ceva ce '
          'ne place, devenim entuziasmați — dar trebuie să fim atenți.',
      sceneColor: Color(0xFF81C784),
      imageUrl: '', // Could add bear image here
    ),
    LocalizedStoryPage(
      pageNumber: 2,
      narration:
          'Bruno a urmat mirosul până la o poiană frumoasă. Soarele strălucea, '
          'păsările cântau, iar pe jos erau sute de arbuști cu afine mari și '
          'strălucitoare. "Ce loc minunat!" s-a gândit Bruno.',
      visualDescription:
          'A sunny forest clearing filled with lush berry bushes, flowers, '
          'and butterflies. Bruno stands at the edge looking delighted. '
          'The scene looks almost too perfect.',
      learningCue:
          'Discutați cum poiana arată perfectă — prea frumoasă pentru a fi '
          'adevărat. Câteodată lucrurile frumoase ne pot distrage atenția.',
      sceneColor: Color(0xFFAED581),
      imageUrl: '',
    ),
    LocalizedStoryPage(
      pageNumber: 3,
      narration:
          'Bruno a alergat spre arbuști și a început să mănânce afinele. '
          'Erau atât de delicioase! Dar nu a observat că sub frunzele verzi '
          'se ascundeau viespi. Când a atins un arbust, viespile au ieșit '
          'și l-au înțepat pe Bruno!',
      visualDescription:
          'Bruno recoiling in pain and surprise as wasps emerge from beneath '
          'the berry bushes. His paw is near a hidden wasp nest. The sunny '
          'clearing now looks more dangerous.',
      learningCue:
          'Ajutați copiii să înțeleagă că Bruno nu a verificat mai întâi. '
          'Pericole pot fi ascunse sub lucruri frumoase.',
      sceneColor: Color(0xFFFFCC80),
      imageUrl: '',
    ),
    LocalizedStoryPage(
      pageNumber: 4,
      narration:
          'Bruno a fugit repede la râul din apropiere și și-a răcorit laba '
          'în apă. Mama Urs a venit și i-a spus: "Drag Bruno, atunci când '
          'ceva pare prea bun ca să fie adevărat, verifică întotdeauna mai '
          'întâi. Pericolele se pot ascunde sub lucruri frumoase." Bruno a '
          'învățat să fie mai atent.',
      visualDescription:
          'Bruno sitting by a cool mountain stream, his paw in the water. '
          'Mother Bear sits beside him, looking wise and caring. The forest '
          'is peaceful and safe here.',
      learningCue:
          'Încheiați întrebându-i pe copii ce vor face diferit când văd ceva '
          'care pare prea bun pe internet. Verificați întotdeauna înainte de '
          'a da click sau de a împărtăși informații.',
      sceneColor: Color(0xFF81D4FA),
      imageUrl: '',
    ),
  ],
  educatorGuide: LocalizedEducatorGuide(
    learningObjectives: [
      'Înțelegeți că pericolele se pot ascunde sub lucruri frumoase sau tentante.',
      'Recunoașteți tiparele de atracție folosite în înșelăciunea online.',
      'Dezvoltați obiceiul de a verifica înainte de a acționa.',
      'Construiți încrederea de a cere ajutor unui adult de încredere.',
    ],
    discussionPrompts: [
      LocalizedDiscussionPrompt(
        question: 'De ce nu a văzut Bruno viespile ascunse?',
        guidanceNote:
            'Bruno era atât de entuziasmat de afine încât nu a verificat '
            'cu atenție. Când ceva pare foarte tentant, putem uita să fim precauți.',
        targetAge: AgeGroup.preschool,
      ),
      LocalizedDiscussionPrompt(
        question:
            'Cum este poiana cu afine ca și linkurile pe care le vedem online?',
        guidanceNote:
            'Ambele pot arăta minunat la suprafață dar pot ascunde pericole. '
            'Linkurile strălucitoare sau ofertele "gratuite" pot fi capcane.',
        targetAge: AgeGroup.earlyPrimary,
      ),
    ],
    activities: [
      LocalizedActivity(
        title: 'Jocul "Verifică Înainte de Click"',
        description:
            'Creați carduri cu imagini de pe internet — unele sigure, altele '
            'suspecte. Copiii practică întrebări de verificare: Cine a trimis-o? '
            'Este prea bună pentru a fi adevărată? Îmi cer informații personale?',
        materials: [
          'Carduri tipărite cu capturi de ecran',
          'Listă de întrebări de verificare',
          'Stickere pentru răspunsuri corecte',
        ],
        durationMinutes: 20,
        targetAge: AgeGroup.earlyPrimary,
      ),
    ],
    culturalContext:
        'Ursul brun (Ursus arctos) este un simbol iconic al munților Carpați '
        'și al României. Acești urși trăiesc în pădurile dese și sunt cunoscuți '
        'pentru inteligența lor. Povestea folosește un cadru familiar copiilor '
        'români pentru a preda siguranța online.',
    safetyTakeaway:
        'La fel cum Bruno a învățat să verifice mai întâi înainte de a se '
        'grăbi spre ceva tentant, copiii trebuie să învețe să verifice înainte '
        'de a da click pe linkuri, de a descărca fișiere sau de a împărtăși '
        'informații. Dacă ceva pare prea bun pentru a fi adevărat, probabil '
        'că este.',
  ),
  questions: [
    LocalizedComprehensionQuestion(
      id: 'q1',
      questionText: 'Ce s-a ascuns sub afinele strălucitoare?',
      options: [
        'Mai multe afine',
        'Un cuib de viespi',
        'Un râu',
        'Mama Urs',
      ],
      correctIndex: 1,
      explanation:
          'Sub frunzele verzi ale arbuștilor se ascundea un cuib de viespi '
          'care l-a înțepat pe Bruno.',
      mascotEncouragement:
          'Foarte bine! Pericolele pot fi ascunse chiar și sub lucruri frumoase.',
    ),
    LocalizedComprehensionQuestion(
      id: 'q2',
      questionText: 'Ce i-a învățat Mama Urs pe Bruno?',
      options: [
        'Să nu mănânce niciodată afine',
        'Să verifice întotdeauna mai întâi',
        'Să fugă de viespi',
        'Să rămână acasă',
      ],
      correctIndex: 1,
      explanation:
          'Mama Urs i-a învățat pe Bruno să verifice întotdeauna mai întâi, '
          'mai ales când ceva pare prea bun ca să fie adevărat.',
      mascotEncouragement:
          'Corect! Întotdeauna verificăm înainte de a acționa, și online și în viață.',
    ),
  ],
);

// ============================================================================
// ENGLISH CONTENT (SECONDARY)
// ============================================================================

final LocalizedStoryContent _englishContent = LocalizedStoryContent(
  title: 'Bruno and the Hidden Berry Clearing',
  synopsis:
      'Bruno the brown bear finds a beautiful clearing full of berries in the '
      'Carpathian Mountains. But beneath the green leaves lies a danger Bruno '
      'doesn\'t see. A lesson about how beautiful things can hide hidden dangers '
      '— just like online.',
  pages: [
    LocalizedStoryPage(
      pageNumber: 1,
      narration:
          'Bruno the brown bear lived in the dense forest of the Carpathian '
          'Mountains. One warm summer day, he caught a sweet smell drifting '
          'through the air. Berries! Bruno was very excited.',
      visualDescription:
          'A brown bear in a dense Carpathian forest with tall pine trees, '
          'looking excited as he sniffs the air. Morning sunlight filters '
          'through the canopy.',
      learningCue:
          'Ask children what they like to eat. When we find something we love, '
          'we get excited — but we need to stay careful.',
      sceneColor: Color(0xFF81C784),
      imageUrl: '',
    ),
    LocalizedStoryPage(
      pageNumber: 2,
      narration:
          'Bruno followed the smell to a beautiful clearing. The sun was '
          'shining, birds were singing, and covering the ground were hundreds '
          'of bushes with big, shiny berries. "What a wonderful place!" '
          'thought Bruno.',
      visualDescription:
          'A sunny forest clearing filled with lush berry bushes, flowers, '
          'and butterflies. Bruno stands at the edge looking delighted. '
          'The scene looks almost too perfect.',
      learningCue:
          'Discuss how the clearing looks perfect — too good to be true. '
          'Sometimes beautiful things can distract us.',
      sceneColor: Color(0xFFAED581),
      imageUrl: '',
    ),
    LocalizedStoryPage(
      pageNumber: 3,
      narration:
          'Bruno rushed to the bushes and started eating the berries. They '
          'were so delicious! But he didn\'t notice that underneath the green '
          'leaves hid wasps. When he touched a bush, the wasps flew out and '
          'stung Bruno!',
      visualDescription:
          'Bruno recoiling in pain and surprise as wasps emerge from beneath '
          'the berry bushes. His paw is near a hidden wasp nest. The sunny '
          'clearing now looks more dangerous.',
      learningCue:
          'Help children understand that Bruno didn\'t check first. Dangers '
          'can be hidden beneath beautiful things.',
      sceneColor: Color(0xFFFFCC80),
      imageUrl: '',
    ),
    LocalizedStoryPage(
      pageNumber: 4,
      narration:
          'Bruno ran quickly to the nearby stream and cooled his paw in the '
          'water. Mother Bear came and said: "Dear Bruno, when something seems '
          'too good to be true, always check first. Dangers can hide beneath '
          'beautiful things." Bruno learned to be more careful.',
      visualDescription:
          'Bruno sitting by a cool mountain stream, his paw in the water. '
          'Mother Bear sits beside him, looking wise and caring. The forest '
          'is peaceful and safe here.',
      learningCue:
          'Close by asking children what they will do differently when they see '
          'something that seems too good online. Always check before clicking '
          'or sharing information.',
      sceneColor: Color(0xFF81D4FA),
      imageUrl: '',
    ),
  ],
  educatorGuide: LocalizedEducatorGuide(
    learningObjectives: [
      'Understand that dangers can hide beneath beautiful or tempting things.',
      'Recognize attraction patterns used in online deception.',
      'Develop the habit of checking before acting.',
      'Build confidence to ask a trusted adult for help.',
    ],
    discussionPrompts: [
      LocalizedDiscussionPrompt(
        question: 'Why didn\'t Bruno see the hidden wasps?',
        guidanceNote:
            'Bruno was so excited about the berries he didn\'t check carefully. '
            'When something seems very tempting, we can forget to be cautious.',
        targetAge: AgeGroup.preschool,
      ),
      LocalizedDiscussionPrompt(
        question: 'How is the berry clearing like links we see online?',
        guidanceNote:
            'Both can look wonderful on the surface but hide dangers. Flashy '
            'links or "free" offers can be traps.',
        targetAge: AgeGroup.earlyPrimary,
      ),
    ],
    activities: [
      LocalizedActivity(
        title: 'Check Before You Click Game',
        description:
            'Create cards with screenshots from the internet — some safe, '
            'some suspicious. Children practice verification questions: Who '
            'sent it? Is it too good to be true? Does it ask for personal info?',
        materials: [
          'Printed screenshot cards',
          'Verification question checklist',
          'Stickers for correct answers',
        ],
        durationMinutes: 20,
        targetAge: AgeGroup.earlyPrimary,
      ),
    ],
    culturalContext:
        'The brown bear (Ursus arctos) is an iconic symbol of the Carpathian '
        'Mountains and Romania. These bears live in dense forests and are known '
        'for their intelligence. The story uses a familiar setting for Romanian '
        'children to teach online safety.',
    safetyTakeaway:
        'Just like Bruno learned to check first before rushing toward something '
        'tempting, children must learn to check before clicking links, '
        'downloading files, or sharing information. If something seems too good '
        'to be true, it probably is.',
  ),
  questions: [
    LocalizedComprehensionQuestion(
      id: 'q1',
      questionText: 'What was hidden under the shiny berries?',
      options: [
        'More berries',
        'A wasp nest',
        'A stream',
        'Mother Bear',
      ],
      correctIndex: 1,
      explanation:
          'Under the green leaves of the bushes was a wasp nest that stung Bruno.',
      mascotEncouragement:
          'Well done! Dangers can be hidden even beneath beautiful things.',
    ),
    LocalizedComprehensionQuestion(
      id: 'q2',
      questionText: 'What did Mother Bear teach Bruno?',
      options: [
        'Never eat berries',
        'Always check first',
        'Run from wasps',
        'Stay home',
      ],
      correctIndex: 1,
      explanation:
          'Mother Bear taught Bruno to always check first, especially when '
          'something seems too good to be true.',
      mascotEncouragement:
          'Correct! We always check before acting, both online and in life.',
    ),
  ],
);
