# Fully Serverless API using Terraform , NodeJS & Express

- This repo is all about hosting an entire Express application on lambda. Similar approach can be used to host angular or react websites with serverside rendering too.

- The lambda handler proxies the request to the express app allowing us to define routes within the application instead of messing around with API gateway.

### Advantages of the approach

    - Lambda can scale out very well and scale to zero when not needed. - Quick turn around: Easy to spinup and migrate apps to the cloud. - No worries about containers, servers , port mappings etc.

### Trade-offs

    - This is lambda specific. For azure functions, use the modern serverless-express framework. The concept is same.
    - Lambda cold start needs to be address by either keeping it warm by a polling service or provision concurrency. Typically startup delays with nodejs apps are neglible.

Infrastructure is createdd following this repo built previously `https://github.com/JAYARAJ2014/tf-lambda-apigw/` . Details documented there.

The infrastructure includes

- API Gateway -- Lambda
- Code is built , hashed and published to s3 bucket
- API Gateway invokes lambda through proxy integration.

Because API Gateway doesn't intervene very much between the client and the backend Lambda function for the Lambda proxy integration, the client and the integrated Lambda function can adapt to changes in each other without breaking the existing integration setup of the API. To enable this, the client must follow application protocols enacted by the backend Lambda function.

(There is no pipelines defined here. But we could use git hub actions, jenkins or azure devops)
