import json
import urllib.request
import boto3
import time
from datetime import datetime

def lambda_handler(event, context):
    
    # Get the path to the JSON file and end_date (optional)
    path_to_file = event['filePath']
    end_date = '2012-12-31'
    
    # Download the file from S3
    s3 = boto3.client('s3')
    bucket_name = path_to_file.split('/')[2]
    file_name = '/'.join(path_to_file.split('/')[3:])
    s3.download_file(bucket_name, file_name, '/tmp/newest_lists.json')
    
    # Read the list of newest list names from the file
    with open('/tmp/newest_lists.json') as f:
        list_names = json.load(f)
    
    # Iterate over the 5 newest lists
    for list_name in list_names[:5]:
        list_name_encoded = list_name['list_name_encoded']
        oldest_published_date = list_name['oldest_published_date']
        date = oldest_published_date
        
        #while date <= end_date:
            
        # Make a request to the API endpoint for the list of books for the current date and list
        # books_url = f'https://api.nytimes.com/svc/books/v3/lists/{list_name_encoded}/{date}.json?api-key=xNuCGoa0wYrtqJECeHatrpN7qJvOqVqJ'
        books_url = f'https://api.nytimes.com/svc/books/v3/lists/{list_name_encoded}.json?api-key=xNuCGoa0wYrtqJECeHatrpN7qJvOqVqJ'
            
        with urllib.request.urlopen(books_url) as response:
            books_response = response.read()
        
        # Write the response to the NDJson file
        s3 = boto3.client('s3')
        bucket_name = 'api-ingestion-nc'
        file_name = f'{list_name_encoded}.ndjson'
        s3.put_object(Bucket=bucket_name, Key=file_name, Body=books_response)  
        
        # Check if the 'next_published_date' key is present in the JSON response
        try:
            date = json.loads(books_response)["results"]["next_published_date"]
        except KeyError:
            print(f'KeyError: "next_published_date" not found in books_response')
            break
        
        time.sleep(6)
    
    return 'loaded to S3'
