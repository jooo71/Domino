import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Domino Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DominoCalculator(),
    );
  }
}

// ==================== SIGNATURE WIDGETS ====================

// Option 1: Compact gradient signature
class SignatureWidget1 extends StatelessWidget {
  const SignatureWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade300, Colors.teal.shade300],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Youseif & Omar Essam',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

// Option 2: Simple text signature
class SignatureWidget2 extends StatelessWidget {
  const SignatureWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Powerd by youseif & omar essam',
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.grey.shade700,
        letterSpacing: 0.5,
      ),
    );
  }
}

// Option 3: Compact badge with icon
class SignatureWidget3 extends StatelessWidget {
  const SignatureWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.people,
            color: Colors.blue.shade700,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            'Y & O',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

// Option 4: Gradient text compact
class SignatureWidget4 extends StatelessWidget {
  const SignatureWidget4({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [Colors.blue.shade700, Colors.teal.shade700],
      ).createShader(bounds),
      child: Text(
        'Y & O Essam',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// Option 5: Compact emoji badge
class SignatureWidget5 extends StatelessWidget {
  const SignatureWidget5({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('💙', style: TextStyle(fontSize: 12)),
          const SizedBox(width: 4),
          Text(
            'Y & O',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== MAIN CALCULATOR ====================

class DominoCalculator extends StatefulWidget {
  const DominoCalculator({super.key});

  @override
  State<DominoCalculator> createState() => _DominoCalculatorState();
}

class _DominoCalculatorState extends State<DominoCalculator>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Player names and scores for each tab
  final List<TextEditingController> _americanNames =
  List.generate(4, (_) => TextEditingController());
  final List<int> _americanScores = List.generate(4, (_) => 0);

  final List<TextEditingController> _arabicNames =
  List.generate(4, (_) => TextEditingController());
  final List<int> _arabicScores = List.generate(4, (_) => 0);

  final List<TextEditingController> _arabicInputs =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _arabicFocusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (var controller in _americanNames) controller.dispose();
    for (var controller in _arabicNames) controller.dispose();
    for (var controller in _arabicInputs) controller.dispose();
    for (var node in _arabicFocusNodes) node.dispose();
    super.dispose();
  }

  void _updateScore(int playerIndex, int points, bool isAmerican) {
    setState(() {
      if (isAmerican) {
        _americanScores[playerIndex] += points;
      } else {
        _arabicScores[playerIndex] += points;
      }
    });
  }

  void _updateArabicScore(int playerIndex, bool isAdd) {
    final inputValue = int.tryParse(_arabicInputs[playerIndex].text) ?? 0;
    setState(() {
      if (isAdd) {
        _arabicScores[playerIndex] += inputValue;
      } else {
        _arabicScores[playerIndex] -= inputValue;
      }
    });
    _arabicInputs[playerIndex].clear();
  }

  void _resetScores(bool isAmerican) {
    setState(() {
      if (isAmerican) {
        for (int i = 0; i < 4; i++) {
          _americanScores[i] = 0;
        }
      } else {
        for (int i = 0; i < 4; i++) {
          _arabicScores[i] = 0;
          _arabicInputs[i].clear();
        }
      }
    });
  }

  Color _getPlayerColor(int index) {
    switch (index) {
      case 0:
        return Colors.blue.shade100;
      case 1:
        return Colors.teal.shade100;
      case 2:
        return Colors.green.shade100;
      case 3:
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  Color _getPlayerHeaderColor(int index) {
    switch (index) {
      case 0:
        return Colors.blue.shade300;
      case 1:
        return Colors.teal.shade300;
      case 2:
        return Colors.green.shade300;
      case 3:
        return Colors.red.shade300;
      default:
        return Colors.grey.shade300;
    }
  }

  Widget _buildPlayerCard(int index, bool isAmerican) {
    final names = isAmerican ? _americanNames : _arabicNames;
    final scores = isAmerican ? _americanScores : _arabicScores;

    return Container(
      decoration: BoxDecoration(
        color: _getPlayerColor(index),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400, width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Player header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: _getPlayerHeaderColor(index),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                'P${index + 1}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          // Player name input
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              controller: names[index],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'PLAYER NAME',
                hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              ),
            ),
          ),
          // Score section label
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _getPlayerHeaderColor(index).withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'SCORE',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          // Score display
          Container(
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade400, width: 2),
            ),
            child: Center(
              child: Text(
                '${scores[index]}',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // Score buttons row
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 4, 6, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (isAmerican)
                  _buildScoreButton('-1', Colors.red, () => _updateScore(index, -1, true)),
                _buildScoreButton('+1', Colors.blue, () => _updateScore(index, 1, isAmerican)),
                _buildScoreButton('+3', Colors.green, () => _updateScore(index, 3, isAmerican)),
                _buildScoreButton('+5', Colors.purple, () => _updateScore(index, 5, isAmerican)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArabicPlayerCard(int index) {
    return Container(
      decoration: BoxDecoration(
        color: _getPlayerColor(index),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400, width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Player header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: _getPlayerHeaderColor(index),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                'P${index + 1}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          // Player name input
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              controller: _arabicNames[index],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'PLAYER NAME',
                hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              ),
            ),
          ),

          // Input and Score boxes side by side
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              children: [
                // Input box
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: _getPlayerHeaderColor(index).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'INPUT',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade400, width: 2),
                        ),
                        child: TextField(
                          controller: _arabicInputs[index],
                          focusNode: _arabicFocusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            hintText: _arabicInputs[index].text.isEmpty &&
                                !_arabicFocusNodes[index].hasFocus
                                ? '0'
                                : null,
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            setState(() {});
                          },
                          onTap: () {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                // Score box
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: _getPlayerHeaderColor(index).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'SCORE',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade400, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            '${_arabicScores[index]}',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // + and - buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 8, 6, 6),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _updateArabicScore(index, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _updateArabicScore(index, false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      '-',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreButton(String label, Color color, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(0, 36),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameTab(bool isAmerican) {
    return Column(
      children: [
        // Players grid
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                childAspectRatio: isAmerican ? 0.62 : 0.68,
              ),
              itemCount: 4,
              itemBuilder: (context, index) =>
              isAmerican ? _buildPlayerCard(index, true) : _buildArabicPlayerCard(index),
            ),
          ),
        ),

        // Reset button
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _resetScores(isAmerican),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade100,
                foregroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade400, width: 2),
                ),
              ),
              child: const Text(
                'RESET ALL SCORES',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'DOMINO CALCULATOR',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: .2,
              ),
            ),
            const SignatureWidget2(), // <-- CHANGE THIS NUMBER TO TEST: 1, 2, 3, 4, or 5
          ],
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey.shade400, width: 2),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.teal.shade200,
                borderRadius: BorderRadius.circular(25),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Colors.black,
              labelStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              tabs: const [
                Tab(text: 'AMERICAN'),
                Tab(text: '3adi'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGameTab(true),
          _buildGameTab(false),
        ],
      ),
    );
  }
}