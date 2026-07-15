import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../domain/models/story_pack.dart';

class PdfGenerator {
  static const _pageMargin = 40.0;
  static const _headerFontSize = 22.0;
  static const _subHeaderFontSize = 16.0;
  static const _bodyFontSize = 12.0;
  static const _smallFontSize = 10.0;
  static const _captionFontSize = 9.0;

  static pw.Document generateStoryPrintout(
    StoryPack pack, [
    String? languageCode,
  ]) {
    final pdf = pw.Document();
    final titleStyle = pw.TextStyle(
      fontSize: _headerFontSize,
      fontWeight: pw.FontWeight.bold,
    );
    final bodyStyle = pw.TextStyle(fontSize: _bodyFontSize, lineSpacing: 4);
    final captionStyle = pw.TextStyle(
      fontSize: _captionFontSize,
      fontStyle: pw.FontStyle.italic,
      color: PdfColors.grey700,
    );

    // Title page
    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(_pageMargin),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(height: 80),
            pw.Center(
              child: pw.Text(
                pack.titleIn(languageCode),
                style: pw.TextStyle(
                  fontSize: 28,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.SizedBox(height: 24),
            pw.Center(
              child: pw.Text(
                'Safety Theme: ${pack.safetyTheme.label}',
                style: pw.TextStyle(
                  fontSize: _subHeaderFontSize,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
            ),
            pw.SizedBox(height: 16),
            pw.Center(
              child: pw.Text(
                'Ages: ${pack.ageGroups.map((a) => a.displayName).join(', ')}',
                style: pw.TextStyle(fontSize: _bodyFontSize),
              ),
            ),
            pw.SizedBox(height: 40),
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey400),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Synopsis',
                    style: pw.TextStyle(
                      fontSize: _subHeaderFontSize,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text(pack.synopsisIn(languageCode), style: bodyStyle),
                ],
              ),
            ),
            pw.Spacer(),
            pw.Center(
              child: pw.Text(
                'Animalogy - Teaching Safety Through Stories',
                style: captionStyle,
              ),
            ),
          ],
        ),
      ),
    );

    // Story pages (2 per PDF page)
    for (var i = 0; i < pack.pagesIn(languageCode).length; i += 2) {
      pdf.addPage(
        pw.Page(
          margin: const pw.EdgeInsets.all(_pageMargin),
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildStoryPageBlock(
                pack.pagesIn(languageCode)[i],
                titleStyle,
                bodyStyle,
              ),
              if (i + 1 < pack.pagesIn(languageCode).length) ...[
                pw.SizedBox(height: 24),
                pw.Divider(color: PdfColors.grey300),
                pw.SizedBox(height: 24),
                _buildStoryPageBlock(
                  pack.pagesIn(languageCode)[i + 1],
                  titleStyle,
                  bodyStyle,
                ),
              ],
            ],
          ),
        ),
      );
    }

    // Safety takeaway page
    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(_pageMargin),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Safety Takeaway', style: titleStyle),
            pw.SizedBox(height: 16),
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                color: PdfColors.amber50,
                border: pw.Border.all(color: PdfColors.amber200),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Text(
                pack.educatorGuideIn(languageCode).safetyTakeaway,
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                  lineSpacing: 5,
                ),
              ),
            ),
            pw.SizedBox(height: 32),
            pw.Text('Cultural Context', style: titleStyle),
            pw.SizedBox(height: 12),
            pw.Text(
              pack.educatorGuideIn(languageCode).culturalContext,
              style: bodyStyle,
            ),
          ],
        ),
      ),
    );

    return pdf;
  }

  static pw.Widget _buildStoryPageBlock(
    dynamic page,
    pw.TextStyle titleStyle,
    pw.TextStyle bodyStyle,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Page ${page.pageNumber}',
          style: pw.TextStyle(
            fontSize: _subHeaderFontSize,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Text(page.narration, style: bodyStyle),
        pw.SizedBox(height: 8),
        pw.Container(
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            color: PdfColors.blue50,
            borderRadius: pw.BorderRadius.circular(4),
          ),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Learning Cue: ',
                style: pw.TextStyle(
                  fontSize: _smallFontSize,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blue800,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  page.learningCue,
                  style: pw.TextStyle(
                    fontSize: _smallFontSize,
                    fontStyle: pw.FontStyle.italic,
                    color: PdfColors.blue800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Document generateActivitySheet(
    StoryPack pack, [
    String? languageCode,
  ]) {
    final pdf = pw.Document();
    final guide = pack.educatorGuideIn(languageCode);

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(_pageMargin),
        header: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Activity Sheet: ${pack.titleIn(languageCode)}',
              style: pw.TextStyle(
                fontSize: _headerFontSize,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              'Safety Theme: ${pack.safetyTheme.label}',
              style: pw.TextStyle(
                fontSize: _smallFontSize,
                fontStyle: pw.FontStyle.italic,
                color: PdfColors.grey600,
              ),
            ),
            pw.SizedBox(height: 12),
            pw.Divider(color: PdfColors.grey300),
            pw.SizedBox(height: 12),
          ],
        ),
        footer: (context) => pw.Container(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            'Animalogy - Page ${context.pageNumber}',
            style: pw.TextStyle(
              fontSize: _captionFontSize,
              color: PdfColors.grey500,
            ),
          ),
        ),
        build: (context) => [
          // Learning objectives
          pw.Text(
            'Learning Objectives',
            style: pw.TextStyle(
              fontSize: _subHeaderFontSize,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 8),
          ...guide.learningObjectives.map(
            (obj) => pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 6),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    '  *  ',
                    style: pw.TextStyle(fontSize: _bodyFontSize),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      obj,
                      style: pw.TextStyle(
                        fontSize: _bodyFontSize,
                        lineSpacing: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          pw.SizedBox(height: 20),

          // Activities
          pw.Text(
            'Activities',
            style: pw.TextStyle(
              fontSize: _subHeaderFontSize,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 12),
          ...guide.activities.map(
            (activity) => pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 16),
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey300),
                borderRadius: pw.BorderRadius.circular(6),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          activity.title,
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: pw.BoxDecoration(
                          color: PdfColors.green50,
                          borderRadius: pw.BorderRadius.circular(10),
                          border: pw.Border.all(color: PdfColors.green200),
                        ),
                        child: pw.Text(
                          '${activity.targetAge.displayName} | ${activity.durationMinutes} min',
                          style: pw.TextStyle(
                            fontSize: _captionFontSize,
                            color: PdfColors.green900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    activity.description,
                    style: pw.TextStyle(
                      fontSize: _bodyFontSize,
                      lineSpacing: 3,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Materials needed:',
                    style: pw.TextStyle(
                      fontSize: _smallFontSize,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  ...activity.materials.map(
                    (m) => pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 12, bottom: 3),
                      child: pw.Text(
                        '- $m',
                        style: pw.TextStyle(fontSize: _smallFontSize),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return pdf;
  }

  static pw.Document generateDiscussionCards(
    StoryPack pack, [
    String? languageCode,
  ]) {
    final pdf = pw.Document();
    final prompts = pack.educatorGuideIn(languageCode).discussionPrompts;

    // 4 cards per page in a 2x2 grid
    for (var i = 0; i < prompts.length; i += 4) {
      final batch = prompts.skip(i).take(4).toList();

      pdf.addPage(
        pw.Page(
          margin: const pw.EdgeInsets.all(_pageMargin),
          build: (context) => pw.Column(
            children: [
              pw.Text(
                'Discussion Cards: ${pack.titleIn(languageCode)}',
                style: pw.TextStyle(
                  fontSize: _subHeaderFontSize,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'Cut along the dotted lines',
                style: pw.TextStyle(
                  fontSize: _captionFontSize,
                  fontStyle: pw.FontStyle.italic,
                  color: PdfColors.grey500,
                ),
              ),
              pw.SizedBox(height: 16),
              pw.Expanded(
                child: pw.GridView(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: batch.map((prompt) {
                    return pw.Container(
                      padding: const pw.EdgeInsets.all(12),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.grey400,
                          style: pw.BorderStyle.dashed,
                          width: 1.5,
                        ),
                        borderRadius: pw.BorderRadius.circular(8),
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: pw.BoxDecoration(
                              color: PdfColors.purple50,
                              borderRadius: pw.BorderRadius.circular(4),
                            ),
                            child: pw.Text(
                              prompt.targetAge.displayName,
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.purple900,
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Text(
                            prompt.question,
                            style: pw.TextStyle(
                              fontSize: _bodyFontSize,
                              fontWeight: pw.FontWeight.bold,
                              lineSpacing: 3,
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Divider(color: PdfColors.grey200),
                          pw.SizedBox(height: 4),
                          pw.Text(
                            'Guidance:',
                            style: pw.TextStyle(
                              fontSize: _captionFontSize,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.grey600,
                            ),
                          ),
                          pw.SizedBox(height: 2),
                          pw.Expanded(
                            child: pw.Text(
                              prompt.guidanceNote,
                              style: pw.TextStyle(
                                fontSize: _captionFontSize,
                                fontStyle: pw.FontStyle.italic,
                                color: PdfColors.grey600,
                                lineSpacing: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return pdf;
  }

  static pw.Document generateQuizSheet(StoryPack pack, [String? languageCode]) {
    final pdf = pw.Document();
    final questions = pack.questionsIn(languageCode);
    if (questions.isEmpty) return pdf;

    final labels = ['A', 'B', 'C', 'D'];

    // Questions pages
    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(_pageMargin),
        header: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Comprehension Quiz: ${pack.titleIn(languageCode)}',
              style: pw.TextStyle(
                fontSize: _headerFontSize,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              'Safety Theme: ${pack.safetyTheme.label}',
              style: pw.TextStyle(
                fontSize: _smallFontSize,
                fontStyle: pw.FontStyle.italic,
                color: PdfColors.grey600,
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Divider(color: PdfColors.grey300),
            pw.SizedBox(height: 12),
          ],
        ),
        footer: (context) => pw.Container(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            'Animalogy - Page ${context.pageNumber}',
            style: pw.TextStyle(
              fontSize: _captionFontSize,
              color: PdfColors.grey500,
            ),
          ),
        ),
        build: (context) => [
          pw.Text(
            'Name: ____________________________    Date: ____________',
            style: pw.TextStyle(fontSize: _bodyFontSize),
          ),
          pw.SizedBox(height: 20),
          ...questions.asMap().entries.map((entry) {
            final idx = entry.key;
            final q = entry.value;
            return pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 20),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    '${idx + 1}. ${q.questionText}',
                    style: pw.TextStyle(
                      fontSize: _bodyFontSize,
                      fontWeight: pw.FontWeight.bold,
                      lineSpacing: 3,
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  ...q.options.asMap().entries.map((optEntry) {
                    final optIdx = optEntry.key;
                    final optText = optEntry.value;
                    return pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 16, bottom: 5),
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            width: 20,
                            height: 20,
                            decoration: pw.BoxDecoration(
                              shape: pw.BoxShape.circle,
                              border: pw.Border.all(color: PdfColors.grey400),
                            ),
                            child: pw.Center(
                              child: pw.Text(
                                labels[optIdx],
                                style: pw.TextStyle(
                                  fontSize: _smallFontSize,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          pw.SizedBox(width: 8),
                          pw.Expanded(
                            child: pw.Text(
                              optText,
                              style: pw.TextStyle(
                                fontSize: _bodyFontSize,
                                lineSpacing: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            );
          }),
        ],
      ),
    );

    // Answer key page
    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(_pageMargin),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Answer Key',
              style: pw.TextStyle(
                fontSize: _headerFontSize,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              pack.titleIn(languageCode),
              style: pw.TextStyle(
                fontSize: _smallFontSize,
                fontStyle: pw.FontStyle.italic,
                color: PdfColors.grey600,
              ),
            ),
            pw.SizedBox(height: 16),
            pw.Divider(color: PdfColors.grey300),
            pw.SizedBox(height: 16),
            ...questions.asMap().entries.map((entry) {
              final idx = entry.key;
              final q = entry.value;
              return pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 16),
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: PdfColors.green50,
                  border: pw.Border.all(color: PdfColors.green200),
                  borderRadius: pw.BorderRadius.circular(6),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '${idx + 1}. ${q.questionText}',
                      style: pw.TextStyle(
                        fontSize: _bodyFontSize,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 6),
                    pw.Text(
                      'Answer: ${labels[q.correctIndex]} - ${q.options[q.correctIndex]}',
                      style: pw.TextStyle(
                        fontSize: _bodyFontSize,
                        color: PdfColors.green900,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      q.explanation,
                      style: pw.TextStyle(
                        fontSize: _smallFontSize,
                        fontStyle: pw.FontStyle.italic,
                        lineSpacing: 2,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );

    return pdf;
  }
}
