# Auth0 Action Terraform module

Terraform module which creates all supported Auth0 Action resources on Auth0.

## Auth0 Action

Actions are secure, tenant-specific, versioned functions written in Node.js that execute at certain points during the Auth0 runtime. Actions are used to customize and extend Auth0's capabilities with custom logic.

`Example Usage`

```hcl
module "auth0_action" {
  source = "git@github.com:kemeattang/terraform_modules.git//auth0/auth0_action/auth0_action?ref=auth0-action-v1.0.0"

  name    = "My Action"
  runtime = "node16"
  deploy  = true
  code    = <<-EOT
  /**
   * Handler that will be called during the execution of a PostLogin flow.
   *
   * @param {Event} event - Details about the user and the context in which they are logging in.
   * @param {PostLoginAPI} api - Interface whose methods can be used to change the behavior of the login.
   */
   exports.onExecutePostLogin = async (event, api) => {
     console.log(event);
   };
  EOT

  supported_triggers = [
    {
      id      = "post-login"
      version = "v3"
    }
  ]

  dependencies = [
    {
      name    = "lodash"
      version = "latest"
    },
    {
      name    = "request"
      version = "latest"
    }
  ]

  secrets = [
    {
      name  = "FOO"
      value = "Foo"
    },
    {
      name  = "BAR"
      value = "Bar"
    }
  ]
}
```

## Auth0 Trigger Actions

With this resource, you can bind actions to a trigger. Once actions are created and deployed, they can be attached (i.e. bound) to a trigger so that it will be executed as part of a flow. The list of actions reflects the order in which they will be executed during the appropriate flow.

`Example Usage`

```hcl
module "auth0_trigger_action" {
  source = "git@github.com:kemeattang/terraform_modules.git//auth0/auth0_action/auth0_trigger_action?ref=auth0-action-v1.0.0"

  trigger = "post-login"

  actions =[
    {
      id           = auth0_action.action_foo.id
      display_name = auth0_action.action_foo.name
    },
    {
      id           = auth0_action.action_bar.id
      display_name = auth0_action.action_bar.name
    }
  ]
}
```