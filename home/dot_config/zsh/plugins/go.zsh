if type go &> /dev/null; then
  PATH="$(go env GOPATH)/bin:$PATH"
fi
