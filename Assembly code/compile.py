
import sys
def compile(input_file,out_b="bin",out_d="int"):
    try:

        conversion = {
                        "EN0":          3,
                        "EN1":          4,
                        "EN2":          5,
                        "EN3":          6,
                        "ENALL":        7,
                        "RSTALL":       8,
                        "LODAC":        9,
                        "MACCI":        11,
                        "MACCJ":        12,
                        "MACCK":        13,
                        "MVSKR":        14,
                        "MVSIR":        15,
                        "MVSJR":        16,
                        "MCIAC":        17,
                        "MCJAC":        18,
                        "MCKAC":        19,
                        "MAAAR":        20,
                        "MVACR":        21,
                        "MABAR":        22,
                        "MTACR":        23,
                        "MACTA":        24,
                        "MVRAC":        25,
                        "MADAR":        26,
                        "STOAC":        27,
                        "RSTAC":        28,
                        "RSTSJ":        29,
                        "RSTSK":        30,
                        "INCSI":        31,
                        "INCSJ":        32,
                        "INCSK":        33,
                        "SUBTR":        34,
                        "MULTI":        35,
                        "ADDIT":        36,
                        "JUMNZ":        40,
                        "END":          38,
                        }

        instruction = open(input_file,"r")
        ins = instruction.readlines()

        ins_int = open(out_d+".txt","w")
        int_list = []
        for i in ins:
            i = i.split()[0]
            if (i in list(conversion.keys())):
                int_list.append(str(conversion[i])+'\n')
            else:
                int_list.append(i+'\n')
        print (int_list)
        ins_int.writelines(int_list)
        ins_int.close()

        ins_bin = open(out_b+".txt","w")
        bin_list = []
        for j in ins:
            j = j.split()[0]
            if (j in list(conversion.keys())):
                n=format(conversion[j],'08b')
                bin_list.append(str(n)+'\n')
            else:
                bin_list.append(i+'\n')
            #n = bin(conversion[j]).replace("0b","")
        print (bin_list)
        ins_bin.writelines(bin_list)
        ins_bin.close()

        instruction.close()

    except:
        print ("There is an error in your instruction file. Please check.")

    else:
        print ("Successfully instructions are switched to integer and binary values")

if __name__=="__main__":
    if (len(sys.argv)==4):
        compile(sys.argv[1],sys.argv[3],sys.argv[2])
    elif ((len(sys.argv)==3)):
        compile(sys.argv[1],out_d=sys.argv[2])
    elif ((len(sys.argv)==2)):
        compile(sys.argv[1])