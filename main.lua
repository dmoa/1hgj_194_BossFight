require("Player")
require("Boss")

function love.load()
  WW = love.graphics.getWidth()
  WH = love.graphics.getHeight()

  love.mouse.setVisible(false)

  player = Player.new()
  boss = Boss.new()

  playing = true

  won = false

  font = love.graphics.newFont(30)
  smallfont = love.graphics.newFont(20)
  againText = love.graphics.newText(font, "TRY AGAIN?\nPRESS SPACE")
  wellDoneText = love.graphics.newText(font, "WELL DONE\neasy right?")

  mainText = love.graphics.newText(smallfont, "impossible boss fight\nor is it?")


  time = 0

  timeText = love.graphics.newText(smallfont, time)
end

function love.draw()
  drawText()
  if playing then
    love.graphics.draw(mainText, WW / 2 - mainText:getWidth() / 2, WH / 2 - mainText:getHeight() / 2)
    love.graphics.draw(timeText, WW / 2 - mainText:getWidth() / 2, WH / 2 - mainText:getHeight() / 2 + 50)
    player.draw()
    boss.draw()
  else
    if not won then
      love.graphics.draw(againText, WW / 2 - againText:getWidth() / 2, WH / 2 - againText:getHeight() / 2)
    else
      love.graphics.draw(wellDoneText, WW / 2 - wellDoneText:getWidth() / 2, WH / 2 - wellDoneText:getHeight() / 2)
    end
  end
end

function love.update(dt)
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
  if playing then
    player.update(dt)
    boss.update(dt)
    time = time + dt
    boss.xv = boss.xv + dt * 8
    timeText = love.graphics.newText(smallfont, math.floor(time))
  end
end

function love.keypressed(key)
  if key == "space" then
    if not playing then
      time = 0
      boss.x = 0
      boss.xv = 100
      player.x = 500
      player.y = 100
      player.xv = 600
      player.yv = 0
      player.acceleration = 1000
      time = 0
      playing = true
      player.bulletx = -100
      player.bullety = -100
      player.bulletxv = 0
      boss.health = 1
    else
      player.jump()
    end
  end
  if key == "m" then
    player.shoot()
  end
end


function drawText()
  love.graphics.print("escape to exit", 0, 0)
  love.graphics.print("AD to move", 0, 15)
  love.graphics.print("space to jump", 0, 30)
  love.graphics.print("m to shoot", 0, 45)
  love.graphics.print("you can't win, or can you?", 0, 70)
end
