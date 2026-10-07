# Authentication and Credential Handling Audit

## Repository finding

The `DBMS-TASKS` repository is a MySQL coursework database project. It currently does **not** contain an application login/authentication module, password hashing code, JWT/session handling, OAuth flow, API authentication middleware, or credential storage.

The database schema is focused on e-commerce entities such as Customer, Product, Orders, Order_Details, Payment, Seller, Inventory, Review, and Rating.

## Database authentication

MySQL itself authenticates a database client using a MySQL account and password or another configured authentication plugin. Those credentials belong to the MySQL server environment and should not be committed to this repository.

The SQL files use:

```sql
USE ecommerce_db;
```

They do not contain a database username or password.

## GitHub repository authentication

GitHub access is separate from the database application. Repository operations require an authenticated GitHub account or application/integration with appropriate permissions.

Conceptual request flow:

```text
Developer / Git client
        |
        | HTTPS request + authenticated credential
        v
      GitHub
        |
        | authorize repository operation
        v
   DBMS-TASKS repository
```

This repository does not define or store GitHub credentials. A secure development setup should use a GitHub App credential, token, SSH key, or the credential mechanism provided by the client, depending on the workflow.

## Credential and token handling

- Store secrets outside source control.
- Prefer environment variables or a secret manager.
- Never hard-code personal access tokens.
- Never print tokens in logs.
- Give tokens only the minimum permissions required.
- Rotate or revoke a credential if it is exposed.
- Do not commit `.env` files containing secrets.

Example environment-variable pattern:

```bash
export GITHUB_TOKEN="your-token"
```

Application code should read the environment variable through its normal configuration mechanism instead of embedding the token in source code.

## Important security note

The `Customer` table contains customer contact information, and the `Payment` table contains transaction information. These are application data, not authentication stores.

Passwords, password hashes, API keys, access tokens, card numbers, CVVs, and other authentication secrets should not be added to these tables unless a separate authentication design is explicitly required.

## Conclusion

**Authentication implementation status: Not implemented in this repository.**

The correct documentation approach is to state this explicitly rather than claiming that the DBMS project already has login, JWT, OAuth, or token-based authentication.
