function nixchk --description "Check when a nixpkgs branch was last updated"
    if test (count $argv) -eq 0
        echo "specify a branch"
        return
    end
    set res (curl -sS "https://api.github.com/repos/nixos/nixpkgs/branches/$argv[1]")
    if test $status -eq 1
        echo "Failed to fetch info from the github API"
        return 1
    end
    set commit_date (echo $res | jq --exit-status -r '.commit.commit.committer.date')
    if test $status -eq 1
        echo "Branch $argv[1] not found"
    else
        echo "$argv[1] was last updated on $(date -d $commit_date)"
    end
end

set -l branches "master nixpkgs-unstable nixos-unstable nixos-24.11"
complete -c nixchk -f
complete -c nixchk -r -n "not __fish_seen_subcommand_from $branches" -a $branches
