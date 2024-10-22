# create user
docker exec -it yugabyted-0 bash -c "./bin/ysqlsh -h yugabyted-0 -U yugabyte -c 'CREATE USER yb_user WITH PASSWORD ''yb_password'';'"

# create database
docker exec -it yugabyted-0 bash -c "./bin/ysqlsh -h --echo-queries --host yugabyted-0 -U yugabyte -c 'CREATE DATABASE data;'"

docker exec -it yugabyted-0 bash -c "./bin/ysqlsh --echo-queries --host yugabyted-0 -U yugabyte -d yugabyte -c 'CREATE DATABASE data;'"

# create test ta
docker exec -it yugabyted-0 bash -c "./bin/ysqlsh --host yugabyted-0 -U yugabyte"
docker exec -it yugabyted-0 bash -c "./bin/ysqlsh --host yugabyted-0 -U yb_user"

# create test table sql command 
# CREATE TABLE sample(k1 int, k2 int, v1 int, v2 text, PRIMARY KEY (k1, k2));
# show all databases
# yugabyte=# \l

# show all users
# yugabyte=# \du

# create user
# CREATE USER yb_user WITH PASSWORD 'yb_password';
docker exec -it yugabyted-0 bash -c "./bin/ysqlsh -h yugabyted-0 -U yugabyte -c 'CREATE USER yb_user WITH PASSWORD ''yb_password'';'"
# GRANT ALL ON DATABASE yugabyte TO yb_user;

# create database
# CREATE DATABASE data;

# REVOKE ALL ON DATABASE yugabyte FROM yb_user;
# DROP USER yb_user;