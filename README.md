# Flask App with CI/CD

This project is a simple Flask application with a robust CI/CD pipeline using GitHub Actions.

## Project Structure

- `main.py`: The main Flask application
- `requirements.txt`: Python dependencies
- `Dockerfile`: Instructions for building the Docker image
- `.github/workflows/`: Contains GitHub Actions workflow files

## CI/CD Pipeline

We use GitHub Actions for continuous integration and deployment. The pipeline is defined in three main workflow files:

1. `ci-cd.yaml`: Handles production builds
2. `staging-ci-cd.yaml`: Manages staging builds
3. `docker-build-template.yaml`: A reusable workflow for building and pushing Docker images

Both production and staging workflows use the `docker-build-template.yaml` as a reusable workflow, ensuring consistency across environments.

## Versioning Strategy

Our versioning strategy adapts based on the branch and whether it's a tagged release:

### Production (Master Branch)

- Tagged Releases: Use the tag as the version (e.g., `v1.2.3`)
- Untagged Pushes: Use `latest` as the version

### Staging and Other Branches

Format: `{branch}-{short_commit_sha}-{timestamp}`
Example: `staging-a1b2c3d-1234567890`

## How to Use

1. Push to the `staging` branch to trigger a staging build
2. Merge to `master` to create a production build
3. Tag a commit on `master` (e.g., `v1.2.3`) to create a versioned production release

## Development

1. Clone the repository
2. Install dependencies: `pip install -r requirements.txt`
3. Run the Flask app locally: `python main.py`

## Building Docker Image Locally
```bash
docker build -t flask-app .
docker run -p 5000:5000 flask-app
```

Visit `http://localhost:5000` to see the app running.

## Environment Variables

No environment variables are required for basic operation. However, you may want to set `FLASK_ENV` to `development` for local development.

## Deployment

The application is automatically deployed through our CI/CD pipeline:

- Staging: Automatically deployed when changes are pushed to the `staging` branch
- Production: Deployed when changes are merged to `master` or a new tag is pushed

## Troubleshooting

If you encounter any issues with the CI/CD pipeline:

1. Check the GitHub Actions logs for detailed error messages
2. Ensure all required secrets (e.g., `GITHUB_TOKEN`) are properly set in the repository settings
3. Verify that the Dockerfile builds successfully in your local environment
