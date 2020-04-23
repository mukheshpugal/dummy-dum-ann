class Matrix {
  public float [] [] data;
  public int rows, columns;

  public Matrix(int r, int c) {
    rows = r;
    columns = c;
    data = new float[rows][columns];
  }    

  public Matrix(Matrix in) {
    rows = in.rows;
    columns = in.columns;
    data = new float[rows][columns];
  }
  
  public String printMatrix() {
    String out = "";
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.columns; j++)
        out += str(this.data[i][j]) + "\t";
      out += "\n";
    }
    return out;
  }

  public void mutate(float mr) {
    for (int i = 0; i < this.rows; i++) 
      for (int j = 0; j < this.columns; j++)
        if (random(1) < mr)
          data[i][j] = 2 * random(1) - 1;
  }

  public Matrix copy() {
    Matrix out = new Matrix(this.rows, this.columns);
    out.rows = this.rows;
    out.columns = this.columns;
    for (int i = 0; i < this.rows; i++) 
      for (int j = 0; j < this.columns; j++)
        out.data[i][j] = this.data[i][j];
    return out;
  }
}
