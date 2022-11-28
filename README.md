# Action to create a pull request to another repository
The GitHub Action "deploy-terraform-workflow" uses "paygoc6/action-pull-request-another-repo" to copy a folder/files from the current repository to a location in another repository and creates a pull request\

## Example Workflow
    name: deploy-terraform-workflow
    on:
        workflow_dispatch:
    jobs:
      pull-request:
        runs-on: ubuntu-latest
        steps:
        - name: Checkout
          uses: actions/checkout@v2

        - name: Create pull request
          uses: paygoc6/action-pull-request-another-repo@v1.0.1
          env:
            API_TOKEN_GITHUB: ${{ secrets.API_TOKEN_GITHUB }}
          with:
            source_folder: 'source-folder'
            destination_repo: 'user-name/repository-name'
            destination_folder: 'folder-name'
            destination_base_branch: 'branch-name'
            destination_head_branch: 'branch-name'
            user_email: 'user-name@paygo.com.br'
            user_name: 'user-name'
            pull_request_reviewers: 'reviewers'

## Variables
* source_folder: The folder to be moved. Uses the same syntax as the `cp` command. Incude the path for any files not in the repositories root directory.
* destination_repo: The repository to place the file or directory in.
* destination_folder: [optional] The folder in the destination repository to place the file in, if not the root directory.
* user_email: The GitHub user email associated with the API token secret.
* user_name: The GitHub username associated with the API token secret.
* destination_base_branch: [optional] The branch into which you want your code merged. Default is `main`.
* destination_head_branch: The branch to create to push the changes. Cannot be `master` or `main`.
* pull_request_reviewers: [optional] The pull request reviewers. It can be only one (just like 'reviewer') or many (just like 'reviewer1,reviewer2,...')

## Values
This action copies values from a config.yml which is present in config folder\
Sample config file : 

        terraform:
          version: 1.0.1
          destination_base_branch: main
          user_email: siddom91@gmail.com
          user_name: Djackk
          reviewers:
            - Djackk
            - purijivan
          repo:
            - Djackk/gitHub-actions
            - Djackk/github-workflows

## ENV
* API_TOKEN_GITHUB: You must create a personal access token in you account. Follow the link:
- [Personal access token](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token)

> You must select the scopes: 'repo = Full control of private repositories', 'admin:org = read:org' and 'write:discussion = Read:discussion';


## Behavior Notes
The action will create any destination paths if they don't exist. It will also overwrite existing files if they already exist in the locations being copied to. It will not delete the entire destination repository.