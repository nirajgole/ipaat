# Databricks notebook source
# from pyspark.sql import SparkSession
# spark = SparkSession.builder.master("local[*]").appName("Banking").getOrCreate()
spark

# COMMAND ----------

df = spark.read.csv('/Volumes/ng_db/default/ng_db_man_vol/Transaction.csv', inferSchema=True, header=True)
df.summary()

# COMMAND ----------

# df.show(truncate=False)
df.select('Account No').distinct().show()

# COMMAND ----------

from pyspark.sql import functions as f
# a. Count of transaction on every account
df.groupBy('Account No').agg(f.count('TRANSACTION DETAILS').alias('no_of_transactions')).orderBy('no_of_transactions', ascending=False).show()

# COMMAND ----------

# b. Maximum withdrawal amount of each account
from pyspark.sql.types import DecimalType
df.groupBy('Account No').agg(f.max(' WITHDRAWAL AMT ').cast(DecimalType(18,2)).alias('max_withdrawl')).orderBy('max_withdrawl', ascending=False).show(truncate=False)

# COMMAND ----------

# c. Minimum withdrawal amount of each account
df.groupBy('Account No').agg(f.min(' WITHDRAWAL AMT ').cast(DecimalType(18,2)).alias('min_withdrawl')).orderBy('min_withdrawl').show(truncate=False)


# COMMAND ----------

# d. Maximum deposit amount of each account
df.groupBy('Account No').agg(f.max(' DEPOSIT AMT ').cast(DecimalType(18,2)).alias('max_deposit')).orderBy('max_deposit',ascending=False).show()

# COMMAND ----------

# e. Minimum deposit amount of each account
df.groupBy('Account No').agg(f.min(' DEPOSIT AMT ').cast(DecimalType(18,2)).alias('min_deposit')).orderBy('min_deposit').show()

# COMMAND ----------

# f. Sum of balance in every bank account
df.groupBy('Account No').agg(f.sum('BALANCE AMT').cast(DecimalType(18,2)).alias('total_balance')).orderBy('total_balance',ascending=False).show()

# COMMAND ----------

# g. Number of transaction on each date
df.groupBy('VALUE DATE').count().orderBy('count',ascending=False).show()

# COMMAND ----------

# h. List of customers with withdrawal amount more than 1 lakh
# df.groupBy('Account No').agg(f.sum(' WITHDRAWAL AMT ').alias('total_withdrawl_amount'))
df.groupBy('Account No').agg(f.sum(' WITHDRAWAL AMT ').cast(DecimalType(18,2)).alias('total_withdrawl_amount')).filter(f.col('total_withdrawl_amount') > 100000).show()
