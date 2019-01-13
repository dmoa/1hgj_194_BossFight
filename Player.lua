Player = {}

Player.new = function()
  local self = {}

  self.x = 500
  self.y = 100

  self.xv = 600
  self.yv = 0
  self.acceleration = 1000

  self.bulletx = -100
  self.bullety = -100
  self.bulletxv = 0
  self.bulletL = 50
  self.bulletH = 30

  self.canJump = false

  self.canShoot = true

  self.imageFront = love.graphics.newImage("player.png")
  self.imageLeft = love.graphics.newImage("playerLeft.png")
  self.imageRight = love.graphics.newImage("playerRight.png")

  self.currentImage = self.imageFront

  self.draw = function()
    love.graphics.draw(self.currentImage, self.x, self.y)
    love.graphics.rectangle("fill", self.bulletx, self.bullety, self.bulletL, self.bulletH)
  end

  self.update = function(dt)
    self.y = self.y + self.yv * dt
    self.yv = self.yv + self.acceleration * dt
    self.bulletx = self.bulletx + self.bulletxv * dt
    if self.y + self.currentImage:getHeight() + self.yv * dt > WH then
      self.y = WH - self.currentImage:getHeight()
      self.yv = 0
      self.acceleration = 0
      self.canJump = true
    end
    if love.keyboard.isDown("a") then
      if self.x - self.xv * dt > 0 then
        self.x = self.x - self.xv * dt
      else
        self.x = 0
      end
      self.currentImage = self.imageLeft
    end
    if love.keyboard.isDown("d") then
      if self.x + self.currentImage:getWidth() + self.xv * dt < WW then
        self.x = self.x + self.xv * dt
      else
        self.x = WW - self.currentImage:getWidth()
      end
      self.currentImage = self.imageRight
    end
    if not (love.keyboard.isDown("a")) and not (love.keyboard.isDown("d")) then
      self.currentImage = self.imageFront
    end

    if self.bulletx + self.bulletL > boss.x and self.bulletx < boss.x + boss.currentImage:getWidth() then
      boss.health = boss.health - 0.025
      self.bulletx = -100
      self.bulletxv = 0
      self.canShoot = true
    end

  end


  self.jump = function()
    if self.canJump then
      self.yv = - 600
      self.acceleration = 1000
      self.canJump = false
    end
  end

  self.shoot = function()
    if self.canShoot then
      print("WOOh")
      self.bullety = self.y + self.currentImage:getHeight() / 2 - self.bulletH / 2
      if self.x > boss.x then
        self.bulletx = self.x - self.bulletL
        self.bulletxv = -400
      else
        self.bulletx = self.x + self.currentImage:getWidth()
        self.bulletxv = 400
      end
      self.canShoot = false
    end
  end

  return self
end
