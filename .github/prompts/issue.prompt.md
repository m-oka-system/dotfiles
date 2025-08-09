---
mode: agent
model: Claude Sonnet 4
tools: ["azure-terraform-research", "codebase", "fetch"]
description: Create GitHub issues with title and description based on context, following Issue Templates.
---

Create an issue URL following the Issue Template format.
If no context is provided, ALWAYS ask the user for input.

## Work Steps

1. If not specified, select an appropriate template from Issue Templates in `.github/ISSUE_TEMPLATE/*.md`

2. Generate issue title and description based on the provided context

3. Use the **azure-terraform-research** toolset to retrieve the following information and add it to the description and notes:

- Development best practices
- Code implementation examples
- azurerm resource block references
- Documentation URLs (prioritize jp locale)

4. Present a Markdown format draft to the user and ask for confirmation (y/n)

- title: Title generated based on context
- body: Description generated based on context
- assignees: Current working user

5. Create the issue using `gh issue create --title <title> --body <body> --assignee @me`

## Notes

- Issue title and description should be written in Japanese
- Provide URLs with jp locale whenever possible
- Use Markdown tables and Mermaid syntax for better visual clarity
