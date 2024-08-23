const int numOfTrials = 100000;
const int numOfBoxes = 100;
const int maxBoxes = 50;

void main(List<String> arguments) {
  if (arguments.isNotEmpty) {
    doTrialSuite(int.parse(arguments[0]), printTrials: false);
  } else
    doTrialSuite(numOfTrials, printTrials: false);
}

void doTrialSuite(int numOfTrials, {bool printTrials = false}) {
  int successfulTrials = 0;
  for (int i = 0; i < numOfTrials; i++) {
    List<bool> results = doTrial();

    printTrials ? printTrial(results) : null;

    if (!results.contains(false)) {
      successfulTrials++;
    }
  }
  print('Successful Trials: $successfulTrials / $numOfTrials');
}

List<bool> doTrial() {
  List<int> boxes = fillBoxes();
  List<bool> isSlipFound = List.filled(boxes.length, false);

  for (int prisonerNumber = 0; prisonerNumber < numOfBoxes; prisonerNumber++) {
    isSlipFound[prisonerNumber] = findSlip(prisonerNumber, boxes);
  }
  return isSlipFound;
}

bool findSlip(int prisonerNumber, List<int> boxes) {
  bool found = false;
  int boxesOpened = 0;
  int currentBox = prisonerNumber;

  while (!found && boxesOpened < maxBoxes) {
    if (boxes[currentBox] == prisonerNumber) {
      found = true;
    } else {
      currentBox = boxes[currentBox];
      boxesOpened++;
    }
  }
  return found;
}

List<int> fillBoxes() {
  List<int> boxes = [];
  for (int i = 0; i < 100; i++) {
    boxes.add(i);
  }
  boxes.shuffle();
  return boxes;
}

void printBoxes(List<int> boxes) {
  for (int i = 0; i < 100; i++) {
    print('Box $i: ${boxes[i]}');
  }
}

void printTrial(List<bool> results) {
  String output = '';
  if (results.contains(false)) {
    output = 'Failed  - ';
  } else {
    output = 'Success - ';
  }

  for (var value in results) {
    output += (value ? 't' : 'f');
  }

  print(output);
}
