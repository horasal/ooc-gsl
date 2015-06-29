use ooc-gsl
import poly

ps := PolySolver new(6)
// -1 + x^5
result := ps solve([-1. as Double, 0, 0, 0, 0, 1])
// PolySolver is alloced by gsl, free it manually
ps free()

"solve -1 + x^5: "println()

for(i in 0..5){
    "x = #{result[2*i]}+#{result[2*i+1]}i" println()
}
