from os import error
import numpy as np
from numpy.core.fromnumeric import size

def result_check(outfile):
    try:
        with open (outfile, 'r') as f:
            data = f.read()
            output = list(map(int,data.split()))
            if len(output) > 3:
                nrA = output[0]
                ncA = output[1]
                nrB = output[1]
                ncB = output [2]
                nrD = output[0]
                ncD = output [2]
                length_data = 3 + nrA*ncA + nrB*ncB + nrD*ncD
                if len(output) == length_data:
                    A = output[3:3+nrA*ncA]
                    B = output[3+nrA*ncA:3+nrA*ncA+nrB*ncB]
                    D = output[3+nrA*ncA+nrB*ncB:3+nrA*ncA+nrB*ncB+nrD*ncD]
                    #print (A, len(A))
                    #print (B, len(B))
                    #print (D, len(D))
                    A_1D = np.array(A)
                    B_1D = np.array(B)
                    D_1D = np.array(D)
                    #print (A_1D, len(A_1D))
                    #print (B_1D, len(B_1D))
                    #print (D_1D, len(D_1D))
                    A_2D = np.reshape(A_1D, (-1, ncA))
                    B_2D = np.reshape(B_1D, (-1, ncB))
                    D_2D = np.reshape(D_1D, (-1, ncD))
                    #print (A_2D, size(A_2D))
                    #print (B_2D, size(B_2D))
                    #print (D_2D, size(D_2D))
                    C_2D = np.dot(A_2D, B_2D)
                    #print (C_2D)
                    #print (D_2D)
                    C = list(np.reshape(C_2D, (1, -1))[0])
                    #print (C, len(C), type(C))
                    #print (D, len(D), type(D))
                    if C == D:
                        print ("Simulation is right and the multiplicated output is")
                        print (C_2D)
                    else:
                        print ("Simulation showing wrong result")
                        print ('\n')
                        print ("Simulation result is")
                        print (D_2D)
                        print ('\n')
                        print ("Expected matrix is")
                        print (C_2D)
                else:
                    raise ValueError("data.txt file doesnot have enough elements")
            else:
                raise ValueError("data.txt file doesnot have enough elements")
    except:
        print ("There was en error in the data.txt. Please check that.")
    else:
        print ('\n')
        print ("End")

if __name__=="__main__":
    result_check("dataout1.txt")
    result_check("dataout2.txt")
    result_check("dataout3.txt")
    result_check("dataout4.txt")

