#! /usr/local/julia-1.1.1/bin/julia

using Pkg

function recompile()
    for pkg in Pkg.installed()
        try
            pkgsym = Symbol(pkg[1])
            eval(:(using $pkgsym))
        catch
            println("ERROR!")
        end
    end
end


Pkg.add(map(x->string(x), ARGS))
recompile()
