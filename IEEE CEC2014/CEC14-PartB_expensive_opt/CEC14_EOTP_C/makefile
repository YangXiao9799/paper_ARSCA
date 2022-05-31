all	:	cec14_eotp_c.exe

cec14_eotp_c.exe : cec14_eotp_c.obj cec14_eotp.obj
	cl cec14_eotp_c.obj cec14_eotp.obj /Fecec14_eotp_c.exe
	
cec14_eotp_c.obj : cec14_eotp_c.cpp
	cl /c cec14_eotp_c.cpp	

cec14_eotp.obj : cec14_eotp.cpp cec14_eotp.h
	cl /c cec14_eotp.cpp	
	
clean:
	del /F *.obj *.dat