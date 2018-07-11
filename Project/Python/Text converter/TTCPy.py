import re
import numpy as np

class TTC(object):

    def __init__(self, minSup):
        if minSup < 0 or minSup > 1:
            raise ValueError("minSup must be between 0 and 1")

        self.minSup = minSup
        self.header = None

    def compute(self, data):
        ### cleaning step
        #take away all that is not numbers or letters
        try:
            splitted = [re.sub('[^A-Za-z0-9]+', ' ', x[0]) for x in data]
        except ValueError:
            print("Needs to be a list of strings")

        splitted = [x.split(" ") for x in splitted]

        #to make it to comparable strings
        split_fix = []
        for obs in splitted:
            tmp = []
            for j in obs:
                tmp.append(j.casefold())
            split_fix.append(tmp)

        flat_list = [item for sublist in split_fix for item in sublist]

        #count it
        np_flat_list = np.array(flat_list)
        unique, counts = np.unique(np_flat_list, return_counts=True)

        check = self.minSup * len(unique)

        #filter for too low support and remove '' and make lower case
        frequent_1_items = [[k,v] for k,v in zip(unique, counts) if k != '' and v >= check]

        #merge to a single string to be able to use "in"
        nam_check1 = [x[0] for x in frequent_1_items]
        self.header = nam_check1
        nam_check = ' '.join(nam_check1)

        #filter all that we do not want from each observation
        filtered_rows = []
        pos = [] #store the positions
        for row in split_fix:
            filtered = list(filter(lambda x: x in nam_check and x != '', row))
            filtered_rows.append(filtered)
            unique, counts = np.unique(filtered, return_counts=True)

            #INSERTION into the matrix
            store_count = []
            n = 0
            for check in nam_check1:
                for uni, cou in zip(unique, counts):
                    if check == uni:
                        store_count.append(cou)
                    else:
                        continue
                #check if the previous for loop put in a value or not
                n = n + 1
                if len(store_count) != n:
                    store_count.append(0)

            if len(store_count) == 0:
                store_count = [0] * len(nam_check1)
            pos.append(store_count)

        return np.array(pos)
