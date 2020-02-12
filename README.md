# sample-notes-app

We have a simple NodeJS API with an exposed endpoint that requests data from a Postgres DB, which has a schema and seed file. The current engineers think having to start up the different services each time they want to work on the application is slowing them down. Additionally, they are using different versions of locally installed Postgres.
- How would you help standardize the local environment to facilicate more efficient development?
- Which values need to be moved from the code -> configuraiton?
- What are some best practices you'd recommend following?
  - How would you approach the application engineers to implement them?

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