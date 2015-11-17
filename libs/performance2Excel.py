import os
from workbook import workbook

V_TITLES =['oks',
           'kos',
           'false positives',
           'false negatives', 
           'true positives', 
           'true negatives',
           'miss rate', 
           # 'fppw',
           'Precision',
           'Recall',
           'F score']

def parse(file):
    """ Reads the performance values from the file 'file' and returns
        the information like a column vector (1xN matrix)"""

    info = []

    f = open(file, "r")
    lines = f.readlines()
    f.close()

    lines = map(lambda x: float(x.strip().split(": ")[-1]), lines)
    for line in lines:
        info.append([line])

    return info


def joinInfo(infos):
    table = []
    for row in range(len(infos[0])):
        table.append([infos[i][row][0] for i in range(len(infos))])

    return table

def writeBook(table, titles, sheet_name, save_path, save_name):
    wb = workbook()
    ws1 = wb.init_book()
   
    # primer hoja del libro
    wb.set_sheet_title(ws1,sheet_name)
    # escritura de la tabla
    wb.write_table(ws1,table,h_titles=titles,v_titles=V_TITLES)
    # guardado del libro
    wb.save_book(save_path, save_name)









if __name__=="__main__":
    path = r"C:\Users\marcos\Desktop\work_path\test_results\RGB_SET\2nd approach\numeric_measures"
    info_1 = parse(os.path.join(path, "inria_rbf_rgb_modelR1.txt"))
    # info_2 = parse(os.path.join(path, "inria_linear_rgb_modelR1.txt"))
    # info_3 = parse(os.path.join(path, "inria_rbf_rgb_R1 - opt.txt"))
    # info = joinInfo([info_1, info_2])
    
    titles = ['R1']

    writeBook(info_1, titles, "Sheet1", path, "INRIA RBF RGB R1_opt")