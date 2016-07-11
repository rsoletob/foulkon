echo -e '- Starting authorizr unit test'
go list ./... | grep -v '/vendor/' | grep -v '/database/' | PATH=$TEMPDIR:$PATH xargs -n1 go test ${GOTEST_FLAGS:--cover -timeout=900s}
echo -e '- Starting connectors test'
echo -e '-- Starting test for PostgreSQL connector'
echo $(echo -e '--- Starting PostgreSQL container postgrestest with id ') $(docker run --name postgrestest -p 54320:5432 -e POSTGRES_PASSWORD=password -d postgres)
echo -e '--- Starting authorizr test for PostgreSQL connector'
go test ./database/postgresql ${GOTEST_FLAGS:--cover -timeout=900s}
echo $(echo -e '--- Removing PostgreSQL container ') $(docker rm -f postgrestest)
