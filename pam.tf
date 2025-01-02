/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


resource "google_privileged_access_manager_entitlement" "entitlement" {
  depends_on = [
    google_project_service.gcp_services,
    google_project_iam_member.privilegedaccessmanager-serviceAgent
  ]


  entitlement_id       = "bigquery-admin-entitlement"
  location             = "global"
  max_request_duration = "3600s"
  parent               = "projects/${local.project_id}"

  requester_justification_config {
    unstructured {}
  }

  eligible_users {
    principals = local.eligible_users_principals
  }

  privileged_access {
    gcp_iam_access {
      role_bindings {
        role = "roles/bigquery.admin"
      }
      resource      = "//cloudresourcemanager.googleapis.com/projects/${local.project_id}"
      resource_type = "cloudresourcemanager.googleapis.com/Project"
    }
  }

  approval_workflow {
    manual_approvals {
      require_approver_justification = true
      steps {
        approvals_needed = 1
        approvers {
          principals = local.approver_principals
        }
      }
    }
  }
}


resource "google_cloud_asset_project_feed" "pam-asset-inventory-feed" {
  depends_on = [
    google_pubsub_topic.iam-asset-inventory-topic
  ]

  project         = local.project_id
  feed_id         = "pam-iam-inventory-feed"
  content_type    = "RESOURCE"
  billing_project = local.project_id

  asset_types = [
    "privilegedaccessmanager.googleapis.com/Grant",
  ]

  feed_output_config {
    pubsub_destination {
      topic = google_pubsub_topic.iam-asset-inventory-topic.id
    }
  }
}
