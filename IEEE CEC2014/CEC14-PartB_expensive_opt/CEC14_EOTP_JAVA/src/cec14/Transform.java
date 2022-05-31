package cec14;

 public class Transform {
	private int n = 0;
	private int d = 0;
	public Transform(int no, int dim)
	{
		assert(no>=1 && no<=8);
		assert(dim==2||dim==10||dim==20||dim==30);
		n = no-1;
		switch (dim) {
			case  2: d = 0; break;
			case 10: d = 1; break;
			case 20: d = 2; break;
			case 30: d = 3; break;
		}
	}

	public double [] getMatrix()
	{
		if (n<=3)
			return Rotation_data.M[n][d];
		else
			return Rotation_data_ex.M[n-4][d];

	}
	public double [] getO()
	{
		return Shift_data.o[n];
	}



}
