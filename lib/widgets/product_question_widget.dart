// lib/widgets/product_question_widget.dart
import 'package:flutter/material.dart';
import 'package:ecommerce_front/models/product_question.dart';
import 'package:ecommerce_front/services/product_question_service.dart';

class ProductQuestionWidget extends StatefulWidget {
  final int productId;
  final int currentUserId;
  final bool isAdmin;

  const ProductQuestionWidget({
    Key? key,
    required this.productId,
    required this.currentUserId,
    this.isAdmin = false,
  }) : super(key: key);

  @override
  _ProductQuestionWidgetState createState() => _ProductQuestionWidgetState();
}

class _ProductQuestionWidgetState extends State<ProductQuestionWidget> {
  final ProductQuestionService _service = ProductQuestionService();
  late Future<List<ProductQuestion>> _futureQuestions;
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() {
    _futureQuestions = _service.getQuestions().then((allQuestions) =>
        allQuestions.where((q) => q.productId == widget.productId).toList());
    setState(() {});
  }

  Future<void> _submitQuestion() async {
    if (_questionController.text.isEmpty) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    ProductQuestion newQuestion = ProductQuestion(
      id: 0,
      productId: widget.productId,
      userId: widget.currentUserId,
      question: _questionController.text,
      answer: "",
      createdAt: now,
      answeredAt: 0,
    );
    await _service.postQuestion(newQuestion);
    _questionController.clear();
    _loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<ProductQuestion>>(
            future: _futureQuestions,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              if (snapshot.hasError)
                return Center(child: Text("Erro: ${snapshot.error}"));
              final questions = snapshot.data ?? [];
              return ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final q = questions[index];
                  return Card(
                    child: ListTile(
                      title: Text(q.question),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (q.answer != null && q.answer!.isNotEmpty)
                            Text("Resposta: ${q.answer}"),
                          if (widget.isAdmin &&
                              (q.answer == null || q.answer!.isEmpty))
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _answerController,
                                    decoration: InputDecoration(
                                      labelText: "Digite a resposta",
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.send),
                                  onPressed: () async {
                                    if (_answerController.text.isNotEmpty) {
                                      await _service.answerQuestion(q, _answerController.text);
                                      _answerController.clear();
                                      _loadQuestions();
                                    }
                                  },
                                )
                              ],
                            )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        if (!widget.isAdmin)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _questionController,
              decoration: InputDecoration(
                labelText: "Faça sua pergunta",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        if (!widget.isAdmin)
          ElevatedButton(
            onPressed: _submitQuestion,
            child: Text("Enviar pergunta"),
          ),
      ],
    );
  }
}