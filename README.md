# sample-notes-app

We have a simple NodeJS API with an exposed endpoint that requests data from a Postgres DB, which has a schema and seed file. The current engineers think having to start up the different services each time they want to work on the application is slowing them down. Additionally, they are using different versions of locally installed Postgres.
- How would you help standardize the local environment to facilicate more efficient development?
- Which values need to be moved from the code -> configuraiton?
- What are some best practices you'd recommend following?
- How would you approach the application engineers to implement them?

## Change Log

1. Create a docker-compose setup with a postgres db service and a nodejs service
2. Setup a multi-stage docker build for the nodejs service that invokes the unit tests
3. Add a release stage to the docker build that generates an 'optimized' build with only our production dependencies
 
   a. Note, the db scripts still need to be stripped from this package

4. Externalize the port, hostname and loglevel from the app code. These are now passed in as environment variables. In docker-compose I have defaulted them to meaningful local values, but in production we'd override them in our orchestrator configuration.
5. Added a winston console logger so that our application logs are picked up by docker. We can now configure a docker log driver to publish these logs to a standard tool (ie awslogs/cloudwatch, splunk, etc)

    a. It's likely that we'll want to disable the file logging or at least ensure we have proper log file rotation in place when we are running in a container so that we don't run out of disk space

## Usage

We are using docker compose to orchestrate a 2 service system including our app running in a node container and a sample database running in a postgres container.

### Build

Running docker-compose build will build our node container, run our unit tests and tag a release image that only holds the production code and production dependencies.

```sh
docker-compose build
```

### Running

To run the app use docker-compose.

```sh
docker-compose up
```
