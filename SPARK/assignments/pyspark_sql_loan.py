# Databricks notebook source
spark

# COMMAND ----------

# MAGIC %sql
# MAGIC use catalog `ng_db`; select * from `default`.`loan` limit 100;

# COMMAND ----------

df = spark.table('ng_db.default.loan')
df.show()

# COMMAND ----------

from pyspark.sql.types import IntegerType,StringType

def get_digits(s):
    return ''.join([i for i in s if i.isdigit()])

get_digits_udf = udf(get_digits, StringType())

# COMMAND ----------

from pyspark.sql.functions import col, udf

df = df.withColumn('Loan Amount', get_digits_udf(col('Loan Amount')).cast(IntegerType()))\
    .withColumnRenamed(' Debt Record','Debt Record')\
    .withColumn('Debt Record', get_digits_udf(col('Debt Record')).cast(IntegerType()))\
    .withColumnRenamed(' Returned Cheque','Returned Cheque')\
    .withColumnRenamed(' Dishonour of Bill','Dishonor of Bill')

# COMMAND ----------

# Number of loans in each category
from pyspark.sql import functions as f

df.groupBy("Loan Category").agg(f.count("Loan Category").alias("count")).orderBy(
    "count", ascending=False
).show()

# COMMAND ----------

# b. Number of people who have taken more than 1 lakh loan
# df.where('"Loan Amount" > "1,00,000"').show()
# df.filter(df['Loan Amount']> '1,00,000').agg(f.count('Loan Amount').alias('count of loan_amount_more_than_1lac')).show()
df.filter(df["Loan Amount"] > 100000).count()

# COMMAND ----------

# c. Number of people with income greater than 60000 rupees
df.filter(df['Income'] > 60000).count()

# COMMAND ----------

# d. Number of people with 2 or more returned cheques and income less than 50000
df.filter((df['Returned Cheque'] > 2) & (df['Income'] < 50000)).count()

# COMMAND ----------

# e. Number of people with 2 or more returned cheques and are single
df.filter((df['Returned Cheque'] > 2) & (df['Marital Status']=='SINGLE')).count()

# COMMAND ----------

# f. Number of people with expenditure over 50000 a month
df.filter(df['Expenditure'] > 50000).count()
