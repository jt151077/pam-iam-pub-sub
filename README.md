# Priviledged Access Manager activity pushed to Pub/Sub

## Setup

1. Find out your GCP project's id and number from the dashboard in the cloud console, and update the following variables in the `terraform.tfvars.json` file. Replace `YOUR_PROJECT_NMR`, `YOUR_PROJECT_ID`, `your_project_region` with the correct values.

```shell
{
    "project_id": "YOUR_PROJECT_ID",
    "project_nmr": YOUR_PROJECT_NMR,
    "project_default_region": "YOUR_PROJECT_REGION",
}
```


## Install

1. Run the following command at the root of the folder:
```shell 
$ sudo ./install.sh
$ terraform init
$ terraform plan
$ terraform apply
```

> Note: The `install.sh` script also sets the current project as the `quota` project, which is required by `cloudasset.googleapis.com` API calls.

2. In the console, under IAM & Admin => PAM, request Grant access to a role for period of time:

![](imgs/0.png)

3. Upon submission, a Grant request will be sent to the Pub/Sub topic, and soon after can be retrieved in the attached subscription:

![](imgs/1.png)