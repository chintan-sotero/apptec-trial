This repository will create a postgreSQL production and QA database in RDS. It expected VPC ID and Subnet ID as input to create these database instances. Please update these values based on output from trial-vpc run.

After success completion of database creation, run the following commands to upload a dataset in both DB:

1. terraform output rds_password_prod - this command will give database password in cleartext
2. psql -h $(terraform output -raw rds_hostname_prod) -p $(terraform output -raw rds_port_prod) -U $(terraform output -raw rds_username_prod) postgres < employees_data.sql - this command will prompt for database password and then load sample HR databset in production database.
3. psql -h $(terraform output -raw rds_hostname_qa) -p $(terraform output -raw rds_port_qa) -U $(terraform output -raw rds_username_qa) postgres < employees_schema.sql - This is same as 2 but will upload database schema in QA database. We are not to load any dataset in QA environment
4. You may want to create a couple of database users from DBeaver running following SQL statements:
    - create role hruser1 with password 'Sotero123$' login; grant rds_superuser to hruser1;
    - create role analyticuser1 with password 'Sotero123$' login; grant rds_superuser to analyticuser1;
