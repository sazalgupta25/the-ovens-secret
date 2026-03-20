# GCP & GitHub Actions Setup Troubleshooting Guide

This guide documents the setup steps and common issues resolved for the **GitHub Actions → Google Cloud Platform (GCP)** deployment pipeline.

## 1. Authentication: Workload Identity Federation (WIF)

If the GitHub Action fails at "**Authenticate to Google Cloud**" with error `invalid_target`, it's because the WIF Pool or Provider is missing or misconfigured.

### Setup Commands (Cloud Shell):
```bash
# Variables
PROJECT_ID="the-ovens-secret"
REPO_NAME="sazalgupta25/the-ovens-secret"
# The service account from your .github/workflows/docker-build.yml
SERVICE_ACCOUNT="github-action-1162908511@the-ovens-secret.iam.gserviceaccount.com"

# 1. Create Pool
gcloud iam workload-identity-pools create "github-pool" \
    --location="global" --display-name="GitHub Actions Pool" --project=$PROJECT_ID

# 2. Create Provider with MANDATORY Security Condition
gcloud iam workload-identity-pools providers create-oidc "github-provider" \
    --project=$PROJECT_ID --location="global" --workload-identity-pool="github-pool" \
    --display-name="GitHub Provider" \
    --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository" \
    --attribute-condition="attribute.repository == '$REPO_NAME'" \
    --issuer-uri="https://token.actions.githubusercontent.com"

# 3. Grant Permission to Service Account
PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format="value(projectNumber)")
gcloud iam service-accounts add-iam-policy-binding $SERVICE_ACCOUNT \
    --role="roles/iam.workloadIdentityUser" \
    --member="principalSet://iam.googleapis.com/projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/github-pool/attribute.repository/$REPO_NAME"
```

---

## 2. Permissions: Service Account Access

If the push/deploy steps fail with `denied: Permission...`, run these commands to grant the required roles:

### Artifact Registry (Push image):
```bash
gcloud projects add-iam-policy-binding the-ovens-secret \
    --member="serviceAccount:github-action-1162908511@the-ovens-secret.iam.gserviceaccount.com" \
    --role="roles/artifactregistry.writer"
```

### Cloud Run (Deploy app):
```bash
gcloud projects add-iam-policy-binding the-ovens-secret \
    --member="serviceAccount:github-action-1162908511@the-ovens-secret.iam.gserviceaccount.com" \
    --role="roles/run.admin"

gcloud projects add-iam-policy-binding the-ovens-secret \
    --member="serviceAccount:github-action-1162908511@the-ovens-secret.iam.gserviceaccount.com" \
    --role="roles/iam.serviceAccountUser"
```

### Firebase Hosting (Static files):
```bash
gcloud projects add-iam-policy-binding the-ovens-secret \
    --member="serviceAccount:github-action-1162908511@the-ovens-secret.iam.gserviceaccount.com" \
    --role="roles/firebase.admin"

gcloud projects add-iam-policy-binding the-ovens-secret \
    --member="serviceAccount:github-action-1162908511@the-ovens-secret.iam.gserviceaccount.com" \
    --role="roles/serviceusage.serviceUsageViewer"
```

---

## 3. Infrastructure: Required Resources

If the build fails because the repository "**may not exist**":

```bash
gcloud artifacts repositories create the-ovens-secret \
    --repository-format=docker --location="us-central1" \
    --project="the-ovens-secret"
```

---

## 4. Build Issues: Font Warnings

If you see `Expected to find fonts for (MaterialIcons, packages/cupertino_icons/CupertinoIcons)...` in the logs:

**Fix:** Ensure `cupertino_icons` is present in `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
```

---

## Troubleshooting Summary

| Error Message | Likely Cause | Resolution Step |
| :--- | :--- | :--- |
| `invalid_target` | WIF Provider missing/wrong condition | Run **Section 1 (Steps 1-3)** |
| `denied: uploadArtifacts` | Missing Artifact Registry role | Run **Section 2 (Artifact Registry)** |
| `Failed to get Firebase project` | Missing Firebase Admin role | Run **Section 2 (Firebase)** |
| `Font asset missing...` | Missing `cupertino_icons` package | Run **Section 4** |
