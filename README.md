# Priviledged Access Manager activity pushed to Pub/Sub

## Setup

1. Find out your GCP project's id and number from the dashboard in the cloud console, and update the following variables in the `terraform.tfvars.json` file. Replace:

* `YOUR_PROJECT_NMR`
* `YOUR_PROJECT_ID`
* `YOUR_PROJECT_REGION`
* `YOUR_ORG_DOMAIN`
* `<user|group>:<YOUR_PRINCIPAL_EMAIL>`
* `<user|group>:<YOUR_APPROVER_PRINCIPAL_EMAIL>`

with the correct values.

```shell
{
    "project_id": "<YOUR_PROJECT_ID>",
    "project_nmr": <YOUR_PROJECT_NMR>,
    "project_default_region": "<YOUR_PROJECT_REGION>",
    "gcp_org_domain": "<YOUR_ORG_DOMAIN>",
    "eligible_users_principals": [
        "<user|group>:<YOUR_PRINCIPAL_EMAIL>"
    ],
    "approver_principals": [
         "<user|group>:<YOUR_APPROVER_PRINCIPAL_EMAIL>"
    ]
}
```


## Install

1. Run the following commands at the root of the folder. Replace `<YOUR_PROJECT_ID>` with the correct value:
```shell 
$ sudo ./install.sh
$ export GOOGLE_CLOUD_QUOTA_PROJECT="<YOUR_PROJECT_ID>"
$ terraform init
$ terraform plan
$ terraform apply
```

> Note: The `GOOGLE_CLOUD_QUOTA_PROJECT` environment variable sets the current project as the `quota` project, which is required by `cloudasset.googleapis.com` API calls.

2. In the console, under IAM & Admin => PAM, request Grant access to a role for period of time:

![](imgs/0.png)

3. Upon submission, a Grant request will be sent to the Pub/Sub topic, and soon after can be retrieved in the attached subscription:

![](imgs/1.png)