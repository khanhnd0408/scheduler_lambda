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
    "2024-05-12": ["full1", "full2"],
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


def get_task_arn(task_id):
    response = client.describe_replication_tasks(
        Filters=[
            {
                'Name': 'replication-task-id',
                'Values': [
                    task_id
                ]
            },
        ]
    )
    return response['ReplicationTasks'][0]['ReplicationTaskArn']
    

def lambda_handler(event, context):
    now = get_current_date(format="%Y-%m-%d", debug=True)
    dms_tasks_id = tasks_definition[now]

    try:
        for task_id in dms_tasks_id:
            task_arn = get_task_arn(task_id)
            response = client.start_replication_task(
                ReplicationTaskArn=task_arn,
                StartReplicationTaskType='reload-target'#'start-replication'
            )
            print(f"Task {task_arn}, finished with response: {response}")
    except Exception as e:
        raise e
