
function check_techs()
  if settings.startup["ymm-reset-effects"].value then
    for _, force in pairs(game.forces) do
        game.print("Resetting technology effects. Please disable after saveing your game.")
        force.reset_technology_effects()
    end
  end
end

script.on_init(function() --if save is new or mod was added later on
  check_techs()
end)
script.on_configuration_changed(function () --settings change, mod/game version change, mod-add/remove
  check_techs()
end)
