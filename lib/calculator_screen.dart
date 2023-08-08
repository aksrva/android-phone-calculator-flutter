import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});
  @override
  State<StatefulWidget> createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController textController = TextEditingController();
  String currentValue = "";
  String finalResult = "";
  double calculateExpression(String expression) {
    try {
      final Parser parser = Parser();
      final Expression exp = parser.parse(expression);
      final ContextModel contextModel = ContextModel();
      final double result = exp.evaluate(EvaluationType.REAL, contextModel);
      finalResult = result.toString();
      currentValue = finalResult.toString();
      textController.text = finalResult.toString();
      setState(() {});
      return result;
    } catch (e) {
      finalResult = double.nan.toString();
      setState(() {});
      return double.nan;
    }
  }

  void addCurrentValue(
    String value,
  ) {
    setState(() {
      if (value == "C") {
        textController.text = "";
        currentValue = "";
        finalResult = "";
        return;
      }
      if (value == "<" && currentValue.isNotEmpty) {
        currentValue = currentValue.substring(0, currentValue.length - 1);
        textController.text = currentValue;
        return;
      }
      currentValue += value;
      textController.text = currentValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    var buttonsIcon = [
      {
        "bIcon": "C",
        "bColor": const Color.fromARGB(255, 56, 56, 56),
        "onPressed": () => addCurrentValue("C"),
      },
      {
        "bIcon": "%",
        "bColor": const Color.fromARGB(255, 56, 56, 56),
        "onPressed": () => addCurrentValue("%"),
      },
      {
        "bIcon": "<",
        "bColor": const Color.fromARGB(255, 56, 56, 56),
        "onPressed": () => addCurrentValue("<"),
      },
      {
        "bIcon": "/",
        "bColor": const Color.fromARGB(255, 56, 56, 56),
        "onPressed": () => addCurrentValue("/"),
      },
      {
        "bIcon": "7",
        "bColor": const Color.fromARGB(255, 21, 21, 21),
        "onPressed": () => addCurrentValue("7"),
      },
      {
        "bIcon": "8",
        "bColor": const Color.fromARGB(255, 21, 21, 21),
        "onPressed": () => addCurrentValue("8"),
      },
      {
        "bIcon": "9",
        "bColor": const Color.fromARGB(255, 21, 21, 21),
        "onPressed": () => addCurrentValue("9"),
      },
      {
        "bIcon": "x",
        "bColor": const Color.fromARGB(255, 56, 56, 56),
        "onPressed": () => addCurrentValue("*"),
      },
      {
        "bIcon": "4",
        "bColor": const Color.fromARGB(255, 21, 21, 21),
        "onPressed": () => addCurrentValue("4"),
      },
      {
        "bIcon": "5",
        "bColor": const Color.fromARGB(255, 21, 21, 21),
        "onPressed": () => addCurrentValue("5"),
      },
      {
        "bIcon": "6",
        "bColor": const Color.fromARGB(255, 21, 21, 21),
        "onPressed": () => addCurrentValue("6"),
      },
      {
        "bIcon": "-",
        "bColor": const Color.fromARGB(255, 56, 56, 56),
        "onPressed": () => addCurrentValue("-"),
      },
      {
        "bIcon": "1",
        "bColor": const Color.fromARGB(255, 21, 21, 21),
        "onPressed": () => addCurrentValue("1"),
      },
      {
        "bIcon": "2",
        "bColor": const Color.fromARGB(255, 21, 21, 21),
        "onPressed": () => addCurrentValue("2"),
      },
      {
        "bIcon": "3",
        "bColor": const Color.fromARGB(255, 21, 21, 21),
        "onPressed": () => addCurrentValue("3"),
      },
      {
        "bIcon": "+",
        "bColor": const Color.fromARGB(255, 56, 56, 56),
        "onPressed": () => addCurrentValue("+"),
      },
      {
        "bIcon": "00",
        "bColor": const Color.fromARGB(255, 21, 21, 21),
        "onPressed": () => addCurrentValue("00"),
      },
      {
        "bIcon": "0",
        "bColor": const Color.fromARGB(255, 21, 21, 21),
        "onPressed": () => addCurrentValue("0"),
      },
      {
        "bIcon": ".",
        "bColor": const Color.fromARGB(255, 21, 21, 21),
        "onPressed": () => addCurrentValue("."),
      },
      {
        "bIcon": "=",
        "bColor": const Color.fromARGB(255, 235, 81, 3),
        "onPressed": () => calculateExpression(currentValue),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: const Icon(Icons.close_fullscreen),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.calculate,
              size: 25,
            ),
            SizedBox(width: 20),
            Icon(
              Icons.grid_view,
              size: 25,
            ),
            SizedBox(width: 20),
            Icon(
              Icons.more_vert,
              size: 25,
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: textController,
                    readOnly: true,
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    finalResult,
                    style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 17,
                runSpacing: 17,
                children: buttonsIcon
                    .map(
                      (btn) => InkWell(
                        onTap: btn["onPressed"] as void Function()?,
                        child: Container(
                            width: MediaQuery.of(context).size.width / 5 - 10,
                            height: 65,
                            decoration: BoxDecoration(
                                color: btn["bColor"]! as Color,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Text(
                                btn["bIcon"].toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 35),
                              ),
                            )),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
