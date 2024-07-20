package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

func handler(ctx context.Context) (string, error) {
	fmt.Println("Hello, World test 15")
	return "Hello, World test 15", nil
}

func main() {
	lambda.Start(handler)
}
