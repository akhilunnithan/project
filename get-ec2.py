import boto3
instance_id= input('Enter the instance id to check(Defaults to all instances): ' )
key_value= input('Enter a key_value to check( Defaults to the entire json data): ')
ec2_client = boto3.client('ec2')
if instance_id:
    ec2_data=ec2_client.describe_instances(
        Filters=[
            # {
            #     'Name': 'tag:Name',
            #     'Values': [
            #         'my-ssh-server',
            #     ]
            # },
        ],

        InstanceIds=[ instance_id
        ],
)
else:
    ec2_data=ec2_client.describe_instances()



if key_value:
    for reservation in ec2_data["Reservations"]:
        for instances in reservation["Instances"]:
            print(instances[key_value])
else:
    print (ec2_data)
