--[[
this code combines C and Lua to solve for a root of a polynomial using the newton raphson method,  
The C portion defines a polynomial function and its derivative, 
it then exposes them as a Lua module that Lua can call. 
The Lua script loads this module and implements the iterative Newton-Raphson algorithm
which refines an initial guess until the root is found within a specified tolerance. 
It also includes safeguards checking for div by 0 and max iteraiton limits

newton-raphson is an iterative method for finding roots of equations. 
basically, if you have a function \( f(x) \) and you want to find where it equals zero (the root), 
the method keeps refining a guess until it's close enough to the actual root. it uses tangential lines ot see if the guess is close 
--]]

package.cpath = package.cpath .. ";/Users/nicholasonigkeit/code/newton/newton.so" --change this to the path to your own executable
package.path = package.path .. ";/usr/local/share/lua/5.4/?.lua"  -- Adjust based on Lua version


-- load the c library
local newton = require("newton")
local socket = require("socket")

-- newton raphson method to find the root https://www.youtube.com/watch?v=WuaI5G04Rcw this vid helped me understand the idea of it


-- f is the function whose root we want to find
-- f_prime is the derivative of that function
-- x0 is the initial guess, tolerance is how close we need to get to the root
-- max_iterations is the maximum number of iterations to avoid infinite loops

-- time
function measure_time(func)
    local start_time = socket.gettime()
    func()  -- Call the function inside the timing block
    local end_time = socket.gettime()
    print("Execution time: " .. (end_time - start_time) .. " seconds")
end

-- newton raph
function newton_raphson(f, f_prime, x0, tolerance, max_iterations)
    local x_n = x0
    for n = 1, max_iterations do
        -- 
        local fx_n = f(x_n)
        local f_prime_x_n = f_prime(x_n)

        -- Adiv by 0
        if f_prime_x_n == 0 then
            print("Derivative is zero at x = " .. x_n .. ", cannot continue.")
            return nil
        end

        -- comp new guess
        local x_next = x_n - fx_n / f_prime_x_n

        -- Check for convergence
        if math.abs(x_next - x_n) < tolerance then
            print("Root found: " .. x_next .. " (after " .. n .. " iterations)")
            return x_next
        end

        x_n = x_next  -- 
    end

    print("Max iterations reached, root not found.")
    return nil
end

-- Example usage
local initial_guess = 0.5
local tolerance = 1e-6  -- 
local max_iterations = 1000  --

-- 
measure_time(function()
    newton_raphson(newton.f, newton.f_prime, initial_guess, tolerance, max_iterations)
end)
