from hdfs import InsecureClient

def list_files_in_directory(client, directory):
    files = client.list(directory)
    for file in files:
        print(file)

def read_file_from_hdfs(client, hdfs_file_path):
    with client.read(hdfs_file_path) as reader:
        content = reader.read()
    print(content.decode('utf-8'))

def upload_file_to_hdfs(client, local_file_path, hdfs_file_path):
    client.upload(hdfs_file_path, local_file_path)

if __name__ == "__main__":
    client = InsecureClient('http://localhost:50070', user='hadoop')

    list_files_in_directory(client, '/tmp')
    
    hdfs_file_path = '/tmp/example.txt'
    read_file_from_hdfs(client, hdfs_file_path)
    
    local_file_path = 'example.txt'
    upload_file_to_hdfs(client, local_file_path, hdfs_file_path)
