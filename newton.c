#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>



// polynomial func f(x) = 2x^3 - 3x^2 + 5x - 1
int f(lua_State *L) {
    double x = luaL_checknumber(L, 1);  // get arg (x)
    double result = 2 * x * x * x - 3 * x * x + 5 * x - 1; //input
    lua_pushnumber(L, result);  // push to lua
    return 1;  // return 1 result
}

// derivative f'(x) = 6x^2 - 6x + 5
int f_prime(lua_State *L) {
    double x = luaL_checknumber(L, 1);  // get arg (x)
    double result = 6 * x * x - 6 * x + 5; //derivative
    lua_pushnumber(L, result); // push to lua
    return 1;  // Return 1 result
}

// register it into lua (had to google this)
int luaopen_newton(lua_State *L) {
    static const struct luaL_Reg newtonlib [] = {
        {"f", f},
        {"f_prime", f_prime},
        {NULL, NULL}  // End of list
    };
    luaL_newlib(L, newtonlib);  // Create the new library
    return 1;  // Return the library to Lua
}
