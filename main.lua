--[[Luis Martinez (Sage)
Let's make the ball interact with the players now, the ball should also give a point to the player of the opposite
side if it does touch the wall. Also changing some of the initial variables for better repeat use, like x is now
playerX and we introduced playerWidth, playerHeight
]]
love.window.setMode(500,500)
love.window.setTitle("pong tutorial 4")

--we've added some variables here, nothing is hard coded now like the X location of the paddle
function love.load()
	playerX = 250
	playerY = 5
	ballx = 250
	bally = 250
	ballxVelocity = 100
	ballyVelocity = 100
	ballRadius = 20
	playerscore = 0
	playerspeed = 100
	playerWidth = 100
	playerHeight = 20
end

function love.update(dt)
	
	if love.keyboard.isDown( "left" ) then
		playerX = playerX - playerspeed*dt
	elseif love.keyboard.isDown( "right" ) then
		playerX = playerX + playerspeed*dt
	end

	--check to see if the ball is colliding with the player's paddle, if so, then we move the paddle
	if ballx < playerX + playerWidth and ballx > playerX and bally - ballRadius < playerY + playerHeight then
		bally = playerY + playerHeight + ballRadius + 1
		ballyVelocity = 100 + love.math.random()*50
	end

	--checking the ball for collision against the game window's borders
	if ballx + ballRadius >= 500 then
		ballx = 500 - ballRadius
		ballxVelocity = -100 - love.math.random()*50
	elseif ballx - ballRadius <= 0 then
		ballx = ballRadius
		ballxVelocity = 100 + love.math.random()*50
	end
	
	if bally + ballRadius >= 500 then
		bally = 500 - ballRadius
		ballyVelocity = -100 - love.math.random()*50
		--let's add a score point if the player gets the ball to touch the wall on the bottom of the window
		playerscore=playerscore+1
	elseif bally - ballRadius <= 0 then
		bally = ballRadius
		ballyVelocity = 100 + love.math.random()*50
	end

	ballx = ballx + ballxVelocity*dt
	bally = bally + ballyVelocity*dt
	
end

function love.draw()
	--love.graphics.rectangle('fill', x, y, width, height)
	love.graphics.rectangle('fill', playerX, playerY, playerWidth, playerHeight)
	love.graphics.rectangle('fill', playerX, playerY + 470, 100, 20)
	love.graphics.setColor(100, 150, 200)
    love.graphics.circle("fill", ballx, bally, ballRadius, 100)
    love.graphics.setColor(0,0,255)
    love.graphics.print(playerscore, 30, 20)
    love.graphics.setColor(255,255,255)
end
