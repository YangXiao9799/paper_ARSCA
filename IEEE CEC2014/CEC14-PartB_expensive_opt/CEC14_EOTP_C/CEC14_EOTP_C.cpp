// CEC14_EOTP_C.cpp : Defines the entry point for the console application.
//
#include "cec14_eotp.h"
#include <stdio.h>
#include <memory.h>
#include <math.h>

#include <iostream>
#include <iomanip>      // std::setprecision
int test();


int main(int argc, char* argv[])
{
	double *x;
	int dim, problem_no;
	double ret;
	bool isGood;

	//test();
	// Read std::cin
	std::cin >> dim >> problem_no;
	x = (double *)malloc(dim*sizeof(double));
	for (int i = 0; i < dim; i++)
		std::cin >> std::setprecision(16)>> x[i];

	// calculated the problem
	ret = cec14_eotp_problems(x, dim, problem_no, &isGood);
	// output to std::cout
	if (isGood)
		std::cout << std::setprecision(16) << ret;
	else
		std::cout << "NaN";

	free(x);
}



int test()
{

	double x10[10];
	double x20[20];
	double x30[30];
	double *x;
	double ret;
	int problem_count;
	bool isGood;

	int function_count, dim_count;


	memset(x10, 1, 10 * sizeof(double));
	memset(x20, 1, 20 * sizeof(double));
	memset(x30, 1, 30 * sizeof(double));


	for (function_count = 1; function_count <= 8; function_count++)
	{
		for (dim_count = 1; dim_count <= 3; dim_count++)
		{
			if (dim_count == 1)
				x = x10;
			if (dim_count == 2)
				x = x20;
			if (dim_count == 3)
				x = x30;

			problem_count = 3 * (function_count - 1) + dim_count;

			ret = cec14_eotp_problems(x, dim_count*10, problem_count,&isGood);
	
			if (!isGood)
				printf("Error from cec14_eotp_problems.\n");
			else
				printf("Problem f%d(0) = %f \n", problem_count, ret);
		}
	}





	return 0;
}

