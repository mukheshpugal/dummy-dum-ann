PrintWriter writer;
NeuralNetwork network;
Data [] data;
float resolution = 100;

void setup() {
  size(600, 600);
  noStroke();
  
  writer = createWriter("data.txt");

  //create data - xor dataset
  data = new Data[4];
  for (int i = 0; i < 4; i++)
    data[i] = new Data();
  data[0].inputs = new float [] {0, 0};
  data[1].inputs = new float [] {0, 1};
  data[2].inputs = new float [] {1, 0};
  data[3].inputs = new float [] {1, 1};
  data[0].outputs = new float [] {0};
  data[1].outputs = new float [] {1};
  data[2].outputs = new float [] {1};
  data[3].outputs = new float [] {0};

  network = new NeuralNetwork(new int [] {2, 2, 1}, 0.1);
}

void draw() {

  //train
  for (int i = 0; i < 10000; i++) {
    int t = floor(random(4));
    network.train(data[t].inputs, data[t].outputs);
  }

  //evaluate
  for (int i = 0; i < resolution; i++) {
    for (int j = 0; j < resolution; j++) {
      fill(network.evaluate(new float [] {i / resolution, j / resolution})[0] * 255);
      rect(j * width / resolution, i * height / resolution, width / resolution, height / resolution);
    }
  }
  
}

void keyPressed() {
  if (keyCode == 32) {
    writer.close();
    exit();
  }
  if (keyCode == 83) {
    String buffer = "";
    for (int i = 0; i < network.layers_n - 1; i++) {
      buffer += network.getWeights().get(0)[i].printMatrix() + "\n";
      buffer += network.getWeights().get(1)[i].printMatrix() + "\n";
    }
    writer.print(buffer);
    writer.flush();
  }
}
