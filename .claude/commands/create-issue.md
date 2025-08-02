---
allowed-tools: mcp__Azure*,mcp__Terraoform*,mcp__Github__create_issue
description: Generate PR description and automatically create pull request on GitHub
---

Create an issue URL following the Issue Template format.
If no context is provided, ALWAYS ask the user for input.

## Work Steps

1. Execute `git config user.name` to check the current working user

2. If not specified, select an appropriate template from Issue Templates in `.github/ISSUE_TEMPLATE/*.md`

3. Generate issue title and description based on the provided context

4. Use the Azure MCP/Terraform MCP to retrieve the following information and add it to the description and notes:

- Development best practices
- Code implementation examples
- azurerm resource block references
- Documentation URLs (prioritize jp locale)

5. Present a Markdown format draft to the user and ask for confirmation (y/n)

- title: Title generated based on context
- body: Description generated based on context
- assignees: Current working user

6. Create the issue using GitHub MCP

## Notes

- Issue title and description should be written in Japanese
- Provide URLs with jp locale whenever possible
- Use Markdown tables and Mermaid syntax for better visual clarity
