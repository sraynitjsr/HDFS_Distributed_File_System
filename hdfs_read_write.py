from hdfs import InsecureClient

client = InsecureClient('http://localhost:50070', user='hadoop')

files = client.list('/tmp')
print("Files in directory:")
for file in files:
    print(file)

local_file_path = 'dummy.txt'
hdfs_file_path = '/tmp/example.txt'
client.upload(hdfs_file_path, local_file_path)

print("File uploaded successfully.")
