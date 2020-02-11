# Pre-requisites to setup Hygieia

Install docker on your machine

# Instructions to setup Hygieia

There are two main steps to setup Hygieia on your local machine after you clone this project:

## Step 1 - Setup the environment variables

Copy the `.env.template` file to `.env`. Update a bunch of values on this file. These values will be looked up by the `docker-compose` utility.
  * ENTERPRISE_USERNAME - Your enterprise EUID
  * ENTERPRISE_PASSWORD - Password for the above
  * GITLAB_API_TOKEN - Get an API token for your user from the Gitlab account settings
  * JIRA_CREDENTIALS - Run `echo -n <enterprise_username>:<enterprise_password> | base64` from shell and get the value
  * JIRA_PROJECT_IDS - A comma separated list of board ids on Jira that we want to monitor
  * GITLAB_PROJECT_IDS - A comma separated list of project ids on Gitlab that we want to monitor the build/deploy stats for
  * SONAR_URL - The base URL for the sonar server, for eg; http://sonar.company.com
  * GITLAB_HOST - The base URL for gitlab server, for eg; https://gitlab.company.com
  * JIRA_BASE_URL - The base URL for JIRA, for eg; https://jira.company.com/jira

## Step 2 - Bring up the docker containers via `docker-compose up`

### By using pre-built images

| WARNING: Due to a dependency between SCM, build and deploy collectors, this method won't work currently. But be assured that a fix is on the way! |
| --- |

All the constituent images have been pushed to the docker registry. You can bring up Hygieia simply by running `docker-compose up`


### By building docker images ab initio

If you want to fix a bug or enhance/customize a component; you'll have the clone the respective component, make changes, build a docker image and optionally push it to the docker registry. Refer to the following set of steps on how you can customize each component:

1. Clone the [hygieia-core](https://github.com/Hygieia/hygieia-core) project. Build the code with `mvn clean install`. This is a pre-requisite to build other hygieia projects.

2. Clone the [api](https://github.com/Hygieia/api) project. Build the code with `mvn install` and then the docker image for the api project

    `docker build -t vaibhawj/hygieia-api .`

3. Clone the [sonar collector](https://github.com/Hygieia/hygieia-codequality-sonar-collector) project. Build the code with `mvn install` and then the docker image for the sonar collector

    `docker build -t vaibhawj/hygieia-sonar .`

4. Clone the [Hygieia](https://github.com/Hygieia/Hygieia) project and navigate into the UI directory. Build the code with `mvn install` and then the docker image for UI.

   `docker build -t vaibhawj/hygieia-ui .`

5. Clone the [Gitlab SCM](https://github.com/kumarsi/hygieia-scm-gitlab-collector) project. Build the code with `mvn install` and then the docker image for the sonar collector

    `docker build -t vaibhawj/hygieia-gitlab-scm .`

6. Clone the [Jira collector](https://github.com/kumarsi/hygieia-feature-jira-collector) project. Build the code with `mvn install -DskipTests` (yes, tests are not important _now_) and then the docker image for the JIRA collector

    `docker build -t vaibhawj/hygieia-jira .`

7. Clone the [Gitlab build collector](https://github.com/kumarsi/hygieia-build-gitlab-collector) project. Build the code with `mvn install -DskipTests` (yes, tests are not important here either) and then the docker image for the build collector

    `docker build -t vaibhawj/hygieia-gitlab-build .`

8. Clone the [Deploy collector](https://github.com/kumarsi/hygieia-deploy-gitlab-collector) project. Build the code with `mvn install -DskipTests` (yes, tests are yet again not important _now_) and then the docker image for the deploy collector

    `docker build -t vaibhawj/hygieia-gitlab-deploy .`

9.  Clone the [Score collector](https://github.com/Hygieia/hygieia-misc-score-collector) project. Build the code with `mvn install` and then the docker image for the score collector

    `docker build -t vaibhawj/hygieia-score .`

10. Run the following command

    `docker-compose up`
    