import boto3
from datetime import datetime, timedelta

client = boto3.client('dms')

tasks_definition = {
    "2024-05-01": [],
    "2024-05-02": [],
    "2024-05-03": [],
    "2024-05-04": [],
    "2024-05-05": [],
    "2024-05-06": [],
    "2024-05-07": [],
    "2024-05-08": [],
    "2024-05-09": [],
    "2024-05-10": [],
    "2024-05-11": [],
    "2024-05-12": [],
    "2024-05-13": [],
    "2024-05-14": [],
    "2024-05-15": [],
    "2024-05-16": []
}


def get_current_date(format="%Y-%m-%d %H:%M:%S", debug=False):
    if debug:
        return "2024-05-12"
    else:
        gmt7 = datetime.now() + timedelta(hours=7)
        return gmt7.strftime(format)
    

def lambda_handler(event, context):
    now = get_current_date(format="%Y-%m-%d")
    dms_tasks_arn = tasks_definition[now]
    
    try:
        for task_arn in dms_tasks_arn:
            response = client.start_replication_task(
                ReplicationTaskArn=task_arn,
                StartReplicationTaskType='start-replication'
            )
            print(f"Task {task_arn}, finished with response: {response}")
    except Exception as e:
        raise e
        