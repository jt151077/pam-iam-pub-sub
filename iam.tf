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


data "google_organization" "org" {
  domain = "jeremyto.altostrat.com"
}

resource "google_project_iam_member" "serviceusage-serviceUsageConsumer" {
  depends_on = [
    google_project_service.gcp_services
  ]


  project = local.project_id
  role    = "roles/serviceusage.serviceUsageConsumer"
  member  = "group:gcp-developers@jeremyto.altostrat.com"
}


resource "google_project_iam_member" "cloudasset-owner" {
  depends_on = [
    google_project_service.gcp_services
  ]


  project = local.project_id
  role    = "roles/cloudasset.owner"
  member  = "group:gcp-developers@jeremyto.altostrat.com"
}

resource "google_project_iam_member" "privilegedaccessmanager-serviceAgent" {
  depends_on = [
    google_project_service.gcp_services
  ]


  project = local.project_id
  role    = "roles/privilegedaccessmanager.serviceAgent"
  member  = "serviceAccount:service-org-${data.google_organization.org.org_id}@gcp-sa-pam.iam.gserviceaccount.com"
}
