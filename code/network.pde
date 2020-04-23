class NeuralNetwork {
  public Matrix [] layers;
  public Matrix [] weights;
  public Matrix [] biases;
  public Matrix [] layers_del;
  public Matrix [] weights_del;
  public Matrix [] biases_del;
  public int layers_n;
  public float learningRate;

  public NeuralNetwork(int [] layers_inp, float lr) {
    layers_n = layers_inp.length;
    layers = new Matrix[layers_n];
    layers_del = new Matrix[layers_n];
    for (int i = 0; i < layers_n; i++) {
      layers[i] = new Matrix(layers_inp[i], 1);
      layers_del[i] = new Matrix(layers_inp[i], 1);
    }

    weights = new Matrix[layers_n - 1];
    weights_del = new Matrix[layers_n - 1];
    for (int i = 0; i < layers_n - 1; i++) {
      weights[i] = randomize(layers[i + 1].rows, layers[i].rows, -1 ,1);
      weights_del[i] = new Matrix(layers[i + 1].rows, layers[i].rows);
    }

    biases = new Matrix[layers_n - 1];
    biases_del = new Matrix[layers_n - 1];
    for (int i = 0; i < layers_n - 1; i++) {
      biases[i] = randomize(layers[i + 1].rows, 1, -1, 1);
      biases_del[i] = new Matrix(layers[i + 1]);
    }

    learningRate = lr;
  }

  public NeuralNetwork(NeuralNetwork in) {

    layers_n = in.layers_n;
    layers = new Matrix[layers_n];
    layers_del = new Matrix[layers_n];
    for (int i = 0; i < layers_n; i++) {
      layers[i] = in.layers[i].copy();
      layers_del[i] = new Matrix(layers[i].rows, 1);
    }

    weights = new Matrix[layers_n - 1];
    weights_del = new Matrix[layers_n - 1];
    for (int i = 0; i < layers_n - 1; i++) {
      weights[i] = in.weights[i].copy();
      weights_del[i] = new Matrix(weights[i]);
    }

    biases = new Matrix[layers_n - 1];
    biases_del = new Matrix[layers_n - 1];
    for (int i = 0; i < layers_n - 1; i++) {
      biases[i] = in.biases[i].copy();
      biases_del[i] = new Matrix(biases[i]);
    }

    learningRate = in.learningRate;
  }

  public void setLearningRate(float lr) {
    learningRate = lr;
  }

  public void feedForward(float [] inputs) {
    layers[0] = fromArray(inputs);
    for (int i = 0; i < layers_n - 1; i++) {
      layers[i + 1] = mapSigmoid(add(mult(weights[i], layers[i]), biases[i]));
    }
  }

  public float [] evaluate(float [] inputs) {
    feedForward(inputs);
    return toArray(layers[layers_n - 1]);
  }
  
  public ArrayList<Matrix []> getWeights() {
    ArrayList<Matrix []> out  = new ArrayList<Matrix []>();
    out.add(weights);
    out.add(biases);
    return out;
  }

  public void backPropagation(float [] targets) {
    layers_del[layers_n - 1] = sub(fromArray(targets), layers[layers_n - 1]);
    for (int i = layers_n - 2; i >= 0; i--) {
      //calculate layer errors
      layers_del[i] = mult(transpose(weights[i]), layers_del[i+1]);
      //calculate bias errors
      biases_del[i] = scale(hadamard(layers_del[i + 1], mapdSigmoid(layers[i + 1])), learningRate);
      //calcute weight errors
      weights_del[i] = mult(biases_del[i], transpose(layers[i]));
    }
  }

  public void train(float [] inputs, float [] targets) {
    feedForward(inputs);
    backPropagation(targets);

    //correct values
    for (int i = 0; i < layers_n - 1; i++) {
      weights[i] = add(weights[i], weights_del[i]);
      biases[i] = add(biases[i], biases_del[i]);
    }
  }

  public void mututate(float mr) {
    for (int i = 0; i < layers_n - 1; i++) {
      weights[i].mutate(mr);
      biases[i].mutate(mr);
    }
  }
}
