package cec14;

public final class Test {
	public static void changex(double[] x)
	{
		if (x.length >= 1)
			x[0] = 1.0;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		eotp problems = new eotp();
		double x[]={0,0,0,0,0,0,0,0,0,0};
		double x20[] = new double[20];
		double x30[] = new double[30];
		
		
		System.out.println(x[0]);
		changex(x);
		System.out.println(x[0]);

		
		for (int i=1; i<=22; i+=3)
		{
			System.out.println("f"+i +"(0)=" + problems.cec14_eotp_probems(x, i));
		}
		
		for (int i=2; i<=24; i+=3)
		{
			System.out.println("f"+i +"(0)=" + problems.cec14_eotp_probems(x20, i));
		}
		
		for (int i=3; i<=24; i+=3)
		{
			System.out.println("f"+i +"(0)=" + problems.cec14_eotp_probems(x30, i));
		}
		
	}

}
