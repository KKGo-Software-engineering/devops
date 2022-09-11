# Go API Example

## To run integration test

```console
docker-compose -f docker-compose.test.yml up --build --abort-on-container-exit --exit-code-from it_tests
```

## To tear down integration test

```console
docker-compose -f docker-compose.test.yml down
```
