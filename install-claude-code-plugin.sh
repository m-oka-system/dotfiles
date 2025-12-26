#!/bin/bash

# マーケットプレイスを追加
claude plugin marketplace add anthropics/skills
claude plugin marketplace add anthropics/claude-plugins-official

# マーケットプレイスの一覧を確認
claude plugin marketplace list

# プラグインを追加 (ユーザースコープ)
claude plugin install example-skills@anthropic-agent-skills
claude plugin install document-skills@anthropic-agent-skills
claude plugin install context7@claude-plugins-official
claude plugin install pr-review-toolkit@claude-plugins-official
claude plugin install playwright@claude-plugins-official
claude plugin install feature-dev@claude-plugins-official

# プラグインの一覧を確認
claude code
/plugin
/skills

# プラグインを削除
claude plugin uninstall example-skills@anthropic-agent-skills
claude plugin uninstall document-skills@anthropic-agent-skills
claude plugin uninstall context7@claude-plugins-official
claude plugin uninstall pr-review-toolkit@claude-plugins-official
claude plugin uninstall playwright@claude-plugins-official
claude plugin uninstall feature-dev@claude-plugins-official
