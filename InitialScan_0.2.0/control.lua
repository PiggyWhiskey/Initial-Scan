Scan_size = 32 --Scan size in chunks

script.on_event(defines.events.on_player_created, function(event)
  if event.player_index == 1 then
    global.scan_starting_area = true
  end
end)

script.on_event(defines.events.on_tick, function(event)
  scan()
  finished()
end)

function scan()
  if not global.scan_starting_area then return end
  local player = game.players[1]
  local f = player.force
  local s = player.surface
  local z = Scan_size/2
  for k = 6,z do
    if game.tick ==((k^2)*24) - 10*60 then 
      f.chart(s, {{-32*k, -32*k}, {32*k, 32*k}})
      if k == z then
        global.scan_starting_area = nil
        Scan_size = nil
        global.print_finished_message = game.tick + 10*60
      end
      return
    end
  end
end

function finished()
  if not global.print_finished_message then return end
  if game.tick ~= global.print_finished_message then return end
  game.print("Initial map scan is finished")
  global.print_finished_message = nil
end