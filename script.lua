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

package.cpath = package.cpath .. ";/Users/nicholasonigkeit/code/javaforschool/newton/newton.so" --change this to the path to your own executable

-- load the c library
local newton = require("newton")

-- newton raphson method to find the root https://www.youtube.com/watch?v=WuaI5G04Rcw this vid helped me understand the idea of it


-- f is the function whose root we want to find
-- f_prime is the derivative of that function
-- x0 is the initial guess, tolerance is how close we need to get to the root
-- max_iterations is the maximum number of iterations to avoid infinite loops


function newton_raphson(f, f_prime, x0, tolerance, max_iterations)
    local x_n = x0
    for n = 1, max_iterations do
        -- Calculate the function value at the current guess (f(x_n))
        local fx_n = f(x_n)
        -- Calculate the derivative value at the current guess (f'(x_n))

        local f_prime_x_n = f_prime(x_n)
        
        -- avoid div by 0
        if f_prime_x_n == 0 then
            print("Derivative is zero, cannot continue.")
            return nil
        end
        
       -- Perform the nr iteration to update the guess
        -- x_next is the next guess for the root based on the current guess and derivative
        local x_next = x_n - fx_n / f_prime_x_n
        
        -- check for convergence
        if math.abs(x_next - x_n) < tolerance then
            print("Root found: " .. x_next .. " (after " .. n .. " iterations)")
            return x_next
        end
        
        x_n = x_next  -- update to new guess
    end
    
    print("Max iterations reached, root not found.")
    return nil
end

-- ex usage
local initial_guess = 0.5
local tolerance = 1e-6
local max_iterations = 100

-- Use the C functions for f(x) and f'(x)
local root = newton_raphson(newton.f, newton.f_prime, initial_guess, tolerance, max_iterations)
