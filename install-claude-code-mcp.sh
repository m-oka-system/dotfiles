#!/bin/bash

# Azure MCP Server
claude mcp add -s project Azure npx @azure/mcp@latest server start

# Terraform
claude mcp add -s project Terraform -- docker run -i --rm hashicorp/terraform-mcp-server

# Playwright
claude mcp add -s project Playwright npx @playwright/mcp@latest

# Context7
claude mcp add -s project Context7 -- npx -y @upstash/context7-mcp@latest

# GitHub
claude mcp add -s project Github -- docker run -i --rm -e GITHUB_PERSONAL_ACCESS_TOKEN ghcr.io/github/github-mcp-server
