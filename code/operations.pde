Matrix add(Matrix x, Matrix y) {
  Matrix a = new Matrix(x);
  for (int i = 0; i < x.rows; i++) 
    for (int j = 0; j < x.columns; j++)
      a.data[i][j] = x.data[i][j] + y.data[i][j];
  return a;
}

Matrix sub(Matrix x, Matrix y) {
  Matrix a = new Matrix(x);
  for (int i = 0; i < x.rows; i++) 
    for (int j = 0; j < x.columns; j++)
      a.data[i][j] = x.data[i][j] - y.data[i][j];
  return a;
}

Matrix mult(Matrix x, Matrix y) {
  Matrix a = new Matrix(x.rows, y.columns);
  for (int i = 0; i < a.rows; i++)
    for (int j = 0; j < a.columns; j++) {
      a.data[i][j] = 0;
      for (int k = 0; k < x.columns; k++) 
        a.data[i][j] += x.data[i][k] * y.data[k][j];
    }
  return a;
}

Matrix scale(Matrix in, float k) {
  Matrix out = new Matrix(in);
  for (int i = 0; i < out.rows; i++)
    for (int j = 0; j < out.columns; j++)
      out.data[i][j] = k * in.data[i][j];   
  return out;
}

Matrix hadamard(Matrix x, Matrix y) {
  Matrix a = new Matrix(x);
  for (int i = 0; i < x.rows; i++) 
    for (int j = 0; j < x.columns; j++)
      a.data[i][j] = x.data[i][j] * y.data[i][j];
  return a;
}

Matrix transpose(Matrix in) {
  Matrix out = new Matrix(in.columns, in.rows);
  for (int i = 0; i < in.rows; i++)
    for (int j = 0; j < in.columns; j++)
      out.data[j][i] = in.data[i][j];        
  return out;
}

Matrix randomize(int r, int c, float l, float u) {
  Matrix out = new Matrix(r, c);
  for (int i = 0; i < r; i++)
    for (int j = 0; j < c; j++)
      out.data[i][j] = random(l, u);   
  return out;
}

Matrix mapSigmoid(Matrix in) {
  Matrix out = new Matrix(in);
  for (int i = 0; i < out.rows; i++)
    for (int j = 0; j < out.columns; j++)
      out.data[i][j] = 1 /( 1 + exp(-1 * in.data[i][j]));   
  return out;
}

Matrix mapdSigmoid(Matrix in) {  
  //all layers have been sigmoided
  //else,
  //Matrix sig = mapSigmoid(in);
  //use sig instead of in
  Matrix i = unit(in);
  Matrix out = hadamard(in, sub(i, in));
  return out;
}

Matrix fromArray(float [] in) {
  Matrix out = new Matrix(in.length, 1);
  for (int i = 0; i < in.length; i++)
    out.data[i][0] = in[i];  
  return out;
}

float [] toArray(Matrix in) {
  float [] out = new float[in.rows];
  for (int i = 0; i < in.rows; i++)
    out[i] = in.data[i][0];
  return out;
}

Matrix unit(int r, int c) {
  Matrix out = new Matrix(r, c);
  for (int i = 0; i < out.rows; i++)
    for (int j = 0; j < out.columns; j++)
      out.data[i][j] = 1;
  return out;
}

Matrix unit(Matrix in) {
  Matrix out = new Matrix(in);
  for (int i = 0; i < out.rows; i++)
    for (int j = 0; j < out.columns; j++)
      out.data[i][j] = 1;
  return out;
}
