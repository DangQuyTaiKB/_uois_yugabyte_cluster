# Step 1: Start yugabyted-0
docker-compose -f docker-compose-yugabyted-0.yml up -d

Start-Sleep -Seconds 12

# Step 2: Generate Certificates for Other Nodes (yugabyted-1 and yugabyted-2)
# docker exec -it yugabyted-0 bash
# ./bin/yugabyted cert generate_server_certs --hostnames=yugabyted-1,yugabyted-2
# exit
# powershell -File generate_certs.ps1
docker exec -it yugabyted-0 bash -c "./bin/yugabyted cert generate_server_certs --hostnames=yugabyted-1,yugabyted-2"

# Step 3: Copy Certificates to the Host Machine
$folderPath = "certs"

if (Test-Path $folderPath) {
    Remove-Item -Recurse -Force $folderPath
}

New-Item -ItemType Directory -Path $folderPath

docker cp yugabyted-0:/root/var/generated_certs/yugabyted-0 certs\yugabyted-0
docker cp yugabyted-0:/root/var/generated_certs/yugabyted-1 certs\yugabyted-1
docker cp yugabyted-0:/root/var/generated_certs/yugabyted-2 certs\yugabyted-2

# copy yugabyted-credentials.txt to certs folder for management
docker cp yugabyted-0:/root/var/data/yugabyted_credentials.txt certs\
# /root/var/data/yugabyted_credentials.txt

# Step 4: Copy Certificates into yugabyted-1 and yugabyted-2 Containers
Start-Sleep -Seconds 1
docker-compose -f docker-compose-yugabyted-1-2.yml up -d

Start-Sleep -Seconds 5
docker cp certs\yugabyted-1 yugabyted-1:/root/var/certs/
docker cp certs\yugabyted-2 yugabyted-2:/root/var/certs/

Start-Sleep -Seconds 1

# Step 5: Restart the Nodes with Certificates
docker-compose -f docker-compose-yugabyted-1-2.yml restart

Start-Sleep -Seconds 5

# Step 6: recreate .env file
python handle.py
Start-Sleep -Seconds 5
# Step 7: Start the UOIS
docker-compose -f docker-compose-uois.yml up -d

