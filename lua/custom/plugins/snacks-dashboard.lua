return {
  'folke/snacks.nvim',
  opts = {
    dashboard = {
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        {
          icon = ' ',
          title = 'Recent Files',
          section = 'recent_files',
          indent = 2,
          padding = { 2, 0 },
          gap = 0,
        },
        {
          icon = ' ',
          title = 'Projects',
          section = 'projects',
          indent = 2,
          padding = 2,
        },
        {
          pane = 2,
          section = 'terminal',
          cmd = 'colorscript -e square',
          height = 5,
          padding = 1,
        },
        { section = 'startup' },
        function()
          local root = Snacks.git.get_root()
          if not root then
            return {}
          end

          -- 1. Extract just 'owner/repo'
          local repo_path = vim.fn.system('git remote get-url origin 2>/dev/null'):gsub('.*[:/]([^/]+/[^/%.]+)%.?git?.*', '%1'):gsub('%s+', '')
          local has_github = repo_path ~= '' and repo_path:match '/'

          -- 2. Fish-compatible environment variable setting using 'env'
          local function gh_cmd(cmd)
            return string.format('env GH_REPO=%s %s 2>/dev/null || true', repo_path, cmd)
          end

          local sections = {
            {
              pane = 2,
              icon = ' ',
              desc = 'Browse Repo',
              padding = 1,
              key = 'b',
              action = function()
                Snacks.gitbrowse()
              end,
            },
          }

          if has_github then
            table.insert(sections, {
              pane = 2,
              section = 'terminal',
              title = 'My Open PRs',
              cmd = gh_cmd "gh pr list --author '@me' -L 3",
              key = 'P',
              action = function()
                -- Also added 'env' here for the browser action
                vim.fn.jobstart(string.format("env GH_REPO=%s gh pr list --web --author '@me'", repo_path), { detach = true })
              end,
              height = 7,
              padding = 1,
              ttl = 300,
            })
          end

          table.insert(sections, {
            pane = 2,
            section = 'terminal',
            title = 'Git Status',
            cmd = 'git --no-pager diff --stat -B -M -C 2>/dev/null || true',
            height = 10,
            padding = 1,
            ttl = 300,
          })

          return sections
        end,
      },
    },
  },
}
