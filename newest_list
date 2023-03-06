import json
import urllib.request
import boto3

def lambda_handler(event, context):
    # Set up the API endpoint and parameters
    url = 'https://api.nytimes.com/svc/books/v3/lists/names.json'
    params = {'api-key': 'xNuCGoa0wYrtqJECeHatrpN7qJvOqVqJ'}

    # Send the API request and retrieve the JSON response
    url_params = urllib.parse.urlencode(params)
    full_url = f"{url}?{url_params}"
    with urllib.request.urlopen(full_url) as response:
        response_data = response.read()

    # Extract the list names and oldest published dates for the 5 newest monthly lists
    response_json = json.loads(response_data)
    lists = []
    for i in range(5):
        list_name = response_json['results'][i]['list_name_encoded']
        oldest_published_date = response_json['results'][i]['oldest_published_date']
        lists.append({'list_name_encoded': list_name, 'oldest_published_date': oldest_published_date})
   
    # write the data to S3
    src_bucket = "api-ingestion-nc"
    object_key = "newest_lists.json"

    # Upload the file to S3
    s3 = boto3.client('s3')
    s3.put_object(Bucket=src_bucket, Key=object_key, Body=json.dumps(lists))
   
    return "json loaded to s3"
