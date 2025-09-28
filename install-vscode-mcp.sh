#!/bin/bash

# Microsoft Learn Docs (Azure MCP に包含)
code --add-mcp '{"name":"MSLearn","type":"http","url":"https://learn.microsoft.com/api/mcp"}'

# Azure (Azure MCP 拡張機能をインストールしている場合は不要)
code --add-mcp '{"name":"Azure","type":"stdio","command":"npx","args":["-y","@azure/mcp@latest","server","start"]}'

# Terraform (HashiCorp Terraform 拡張機能をインストールしている場合は不要)
code --add-mcp '{"name":"Terraform","type":"stdio","command":"docker","args":["run","-i","--rm","hashicorp/terraform-mcp-server:latest"]}'

# Playwright
code --add-mcp '{"name":"Playwright","type":"stdio","command":"npx","args":["@playwright/mcp@latest"]}'

# GitHub
code --add-mcp '{"name":"GitHub","type":"http","url":"https://api.githubcopilot.com/mcp/"}'

# DeepWiki
code --add-mcp '{"name":"DeepWiki","type":"http","url":"https://mcp.deepwiki.com/sse"}'

# Context7
code --add-mcp '{"name":"Context7","type":"stdio","command":"npx","args":["-y","@upstash/context7-mcp"]}'

# Chrome DevTools
code --add-mcp '{"name":"Chrome DevTools","type":"stdio","command":"npx","args":["chrome-devtools-mcp@latest"]}'
