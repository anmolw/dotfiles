function lights --description 'Control smart lights'
    if not set -q HASS_TOKEN
        echo "Error: HASS_TOKEN not set"
        return 1
    end

    if not set -q HASS_URL
        echo "Error: HASS_URL not set"
        return 1
    end

    switch $argv[1]
        case on
            set action turn_on
        case off
            set action turn_off
        case toggle ''
            set action toggle
        case '*'
            echo "Usage: lights [on|off|toggle]"
            return
    end

    set resp (curl -fsSX POST "$HASS_URL/api/services/light/$action" \
        --header "Authorization: Bearer $HASS_TOKEN" \
        --header "Content-Type: application/json" \
        --data '{"entity_id": ["light.door", "light.window"]}')

    if test $status -eq 1
        echo "An error occurred while performing the request"
        return 1
    end
end

set -l actions "toggle on off"
complete -c lights -f
complete -c lights -xn "not __fish_seen_subcommand_from $actions" -a $actions
