# Databricks notebook source
spark

# COMMAND ----------

df = spark.read.csv('/Volumes/ng_db/default/ng_db_man_vol/Credit_Card.csv', inferSchema=True, header=True)

# COMMAND ----------

df.show(10)

# COMMAND ----------

# a. Number of members who are eligible for credit cards. [NOTE: People having credit score greater than 700 are eligible]
df.filter(df['CreditScore'] > 700).count()


# COMMAND ----------

# b. Number of members who are eligible and active in the bank.
df.filter((df['IsActiveMember']==1) & (df['CreditScore'] > 700)).count()

# COMMAND ----------

# c. credit card users in Spain
df.filter(df['Geography']=='Spain').count()
