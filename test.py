# conda activate base

# cd (FILE LOCATION)

# python test.py

from sql_connection import sql_connection
import csv

file = open('VeroCustomersNewsletterFiveYearsTrend20210513.csv', 'r') #Make sure you save it as CSV file, otherwise no file found 
data = list(csv.reader(file))

data[0] = ['[' + x + ']' for x in data[0]]

db = sql_connection()
db.create_conn()
db.type_inference_insert(data[1:], data[0], 'tbl_VeroCustomersNewsletterFiveYearsTrend20210513') #write the database table name within the quotation mark

db.close_connection()