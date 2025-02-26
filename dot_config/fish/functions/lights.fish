function lights --description 'Control smart lights'
    if not set -q HASS_TOKEN
        echo "Error: HASS_TOKEN not set"
        return 1
    end

    if not set -q HASS_URL
        echo "Error: HASS_URL not set"
        return 1
    end

    set action toggle
    switch $argv[1]
        case on
            set action turn_on
        case off
            set action turn_off
    end

    set resp (curl -fsSX POST "$HASS_URL/api/services/light/$action" \
        --header "Authorization: Bearer $HASS_TOKEN" \
        --header "Content-Type: application/json" \
        --data '{"entity_id": ["light.door", "light.window"]}')

    if test $status -ne 0
        echo "An error occurred while performing the request"
        return 1
    end
end

set -l actions "toggle on off"
complete -c lights -f
complete -c lights -xn "not __fish_seen_subcommand_from $actions" -a $actions
