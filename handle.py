# Read file yugabyted_credentials.txt and "Password" of YSQL
with open("certs/yugabyted_credentials.txt", "r") as file:
    for line in file:
        if "Password" in line:
            password = line.split(":")[1].strip()
            break

print(password)

# rewrite .env file with POSTGRES_PASSWORD=password, POSTGRES_USER=yb_user, POSTGRES_HOST=yugabyted-0:5433, POSTGRES_DB=data
with open(".env", "w") as file:
    file.write(f"POSTGRES_PASSWORD={password}\n")
    file.write(f"POSTGRES_USER=yugabyte\n")
    file.write(f"POSTGRES_HOST=yugabyted-0:5433\n")
    file.write(f"POSTGRES_DB=yugabyte\n")

print("File .env created")
